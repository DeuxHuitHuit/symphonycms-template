'use strict';

module.exports = function cssopruner (grunt) {
	grunt.config.merge({
		cssopruner: {
			compress: {
				options: {
					whitelist: [
						'end',
						/^js-.+/,
						/^is-.+/,
						/snip-/,
						/snipcart-/,
						/^flickity-/,
						/^nano.*/,
						/^h[1-6]$/,
						/^snip/,
						'a',
						'p',
						'button',
						'table',
						'tr',
						'td',
						'dl',
						'dd',
						'dt',
						'ol',
						'ul',
						'li',
						'br',
						'active',
						'hr',
						/^ui/
					],
					blacklist: ['www', 'version', 'xml']
				}
			}
		}
	});
	
	var moduleStart = (new Date()).getTime();
	var fs = require('fs');
	var stream = require('stream');
	var es = require('event-stream');
	var async = require('async');
	var _ = require('lodash');
	var chalk = require('chalk');
	var maxmin = require('maxmin');
	var assert = require('assert');
	var modulesLoaded = (new Date()).getTime();

	var arrayize = function (something) {
		if (!something) {
			return [];
		}
		if (_.isArray(something)) {
			return something;
		}
		return [something];
	};

	var d = 'Prune unused css from csso tree';
	grunt.registerMultiTask('cssopruner', d, function () {
		var csso;
		var start = _.now();
		var options = this.options({
			tokenizer: /[a-zA-Z0-9-_$]+/g,
			whitelist: [],
			blacklist: [],
			src: []
		});
		var done = (function () {
			var d = this.async();
			return function () {
				grunt.log.writeln('Done in ' + (_.now() - start) + ' ms');
				d();
			};
		}).bind(this)();
		var src = grunt.file.expand(arrayize(options.src));
		if (!src || !src.length) {
			return grunt.fail.fatal('Please set some sources');
		}

		var dictionary = new Map();

		var wordIsColorListed = function (colorlist) {
			return function wordIsColorlistedFor (word) {
				return !!(_.filter(colorlist, function (colorword) {
					if (!colorword) {
						return false;
					}
					if (colorword.test) {
						return colorword.test(word);
					}
					return word === colorword;
				}).length);
			};
		};
		var wordIsWhiteListed = wordIsColorListed(options.whitelist);
		var wordIsBlackListed = wordIsColorListed(options.blacklist);

		var quotes = /^["'](.*)["']$/;
		var unquoteValue = function (value) {
			if (quotes.test(value)) {
				value = value.replace(quotes, '$1');
			}
			return value;
		};

		var processSequence = function (sequence) {
			var wordsToMatched = [];
			sequence.each(function (seq) {
				switch (seq.type) {
					case 'Negation':
						break;

					case 'SimpleSelector':
						assert(seq.sequence, 'SimpleSelector sequence is not falsy');
						wordsToMatched = wordsToMatched.concat(processSequence(seq.sequence));
						break;

					case 'Id':
					case 'Class':
						assert(seq.name, seq.type + ' name is not falsy');
						wordsToMatched.push(seq.name);
						break;

					case 'Attribute':
						if (!!seq.name.name) {
							wordsToMatched.push(seq.name.name);
						}
						if (!!seq.value) {
							if (!!seq.value.name) {
								wordsToMatched.push(seq.value.name);
							} else if (!!seq.value.value) {
								wordsToMatched.push(unquoteValue(seq.value.value));
							}
						}
						break;

					case 'Identifier':
						assert(seq.name, seq.type + ' name is not falsy');
						if (seq.name !== '*') {
							wordsToMatched.push(seq.name);
						}
						break;

					case 'FunctionalPseudo':
						break;

					case 'PseudoElement':
						// ::before, ::after
						break;

					case 'PseudoClass':
						// :hover, :active
						break;

					case 'Combinator':
						break;
				}
			});
			return wordsToMatched;
		};

		var processSelectorsResults = {
			DIC: 'dictionary',
			WL: 'whitelist',
			NA: 'not found'
		};

		var processSelectors = function (ast, selectors) {
			var selectorsRemoved = 0;
			selectors.each(function (selector, item, list) {
				if (selector.type !== 'SimpleSelector') {
					throw new Error('Cannot deal with anything else then a simple selector');
				}
				var wordsToMatched = processSequence(selector.sequence);
				var results = _.reduce(wordsToMatched, function (memo, word, index) {
					if (!memo[word]) {
						memo[word] = dictionary.has(word) ?
							processSelectorsResults.DIC : (
								wordIsWhiteListed(word) ?
								processSelectorsResults.WL : processSelectorsResults.NA
						);
					}
					return memo;
				}, {});
				var allMatched = _.every(_.map(results, function (r) {
					return r !== processSelectorsResults.NA;
				}));
				if (!allMatched) {
					//ast.stats.removedSelectors.push({
					//	selector: csso.translate(selector),
					//	results: results
					//});
					selectorsRemoved++;
				}
				//ast.stats.selectorsSeen++;
			});
			return selectors.size - selectorsRemoved;
		};

		var walkAllRules = function (ast) {
			csso.walkRules(ast, function (node, item, list) {
				if (node.type === 'Ruleset') {
					//ast.stats.rulesetCount++;
					if (processSelectors(ast, node.selector.selectors) === 0) {
						list.remove(item);
						//ast.stats.rulesetRemovedCount++;
						//ast.stats.rulesetRemoved.push(node);
					}
				} else if (node.type === 'Atrule') {
					if (node.name === 'media') {
						if (!!node.block.rules) {
							node.block.rules.each(function (ruleset, item, list) {
								//ast.stats.rulesetCount++;
								if (processSelectors(ast, ruleset.selector.selectors) === 0) {
									list.remove(item);
									//ast.stats.relesetRemovedCount++;
									//ast.stats.rulesetRemoved.push(ruleset);
								}
							});
							if (node.block.rules.isEmpty()) {
								list.remove(item);
							}
						}
					}
					// ignore:
					// keyframes
					// import
					// ...
				} else {
					throw new Error('Walked across something unexpected');
				}
			});
			grunt.verbose.writeln('--- Walked and killed', ast.filename);
		};

		var fillDictionary = function () {
			grunt.verbose.writeln('+++', chalk.green('Starting read and tokenize'));
			async.each(src, function (file, next) {
				var lineNr = 0;

				grunt.verbose.writeln('--- Reading source ' + file);

				var s = fs.createReadStream(file)
					.pipe(es.split())
					.pipe(es.map(function (line, nextLine) {

						// pause the readstream
						s.pause();

						lineNr += 1;

						if (options.tokenizer && options.tokenizer.lastIndex) {
							options.tokenizer.lastIndex = 0;
						}
						_.each(_.filter(_.words(line, options.tokenizer), function (word) {
							return isNaN(Number(word)) && !wordIsBlackListed(word);
						}), function (word) {
							if (!dictionary.has(word)) {
								dictionary.set(word, 0);
							}
						});

						// resume
						s.resume();
						
						// next
						nextLine();
					})
					.on('error', function (err) {
						next(new Error('Error while reading file: ' + file + ' ' + err.message));
					})
					.on('end', function () {
						next();
					}));
			}, function (err) {
				if (err) {
					return grunt.fail.fatal(err.message);
				}
				grunt.verbose.writeln('+++', chalk.green('All sources read and tokenized'));
				done();
			});
		};
		
		fillDictionary();
		
		grunt.config.merge({
			csso: {
				options: {
					beforeCompress: [function (ast, options, cssoInstance) {
						csso = cssoInstance;
						ast.filename = ast.filename || options.filename;
						walkAllRules(ast);
					}]
				}
			}
		});
	});
};
