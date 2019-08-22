/**
 * Form Field
 * @author Deux Huit Huit
 * @requires https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.15.0/moment.min.js
 */
(function ($, win, undefined) {

	'use strict';

	var defaults = {
		container: '.js-form-field',
		input: '.js-form-field-input',
		hint: '.js-form-field-hint',
		filename: '.js-form-field-filename',
		preview: '.js-form-field-preview',
		validationEvents: 'blur change',
		emptinessEvents: 'blur keyup change',
		previewEvents: 'change input',
		formatEvents: 'blur',
		showFilename: true,
		onlyShowFirstHint: false,
		group: null,
		rules: {
			required: {
				presence: true
			},
			email: {
				email: true
			},
			money: {
				numericality: {
					onlyInteger: false,
					greaterThan: 0
				}
			},
			integer: {
				numericality: {
					onlyInteger: true,
					greaterThan: 0
				}
			},
			document: {
				format: {
					pattern: '^.+\\.(?:docx?|pdf)$',
					flags: 'i'
				},
				presence: {
					allowEmpty: true
				}
			},
			image: {
				format: {
					pattern: '^.+\\.(?:jpe?g|png)$',
					flags: 'i'
				},
				presence: {
					allowEmpty: true
				}
			},
			phoneUS: {
				format: {
					pattern: '\\+?1?[- ]?\\(?[0-9]{3}\\)?[- ]?[0-9]{3}[- ]?[0-9]{4}',
					flags: 'i'
				}
			},
			url: {
				url: true
			},
			embed: {
				format: {
					pattern: '^http(.+)(youtube\\.com|youtu\\.be|vimeo\\.com|facebook\\.com)(.+)$',
					flags: 'i'
				}
			},
			confirmEmail: {
				sameAs: {
					target: 'input[name="form[email]"]'
				}
			},
			date: {
				datetime: {
					dateOnly: true
				}
			}
		},
		rulesOptions: {

		},
		formatters: {

		},
		onFocus: null,
		onBlur: null,
		onKeyup: null,
		onKeydown: null,
		onChangeOrInput: null
	};

	var extendedDateRules = null;

	if (window.moment) {
		extendedDateRules = {
			rules: {
				over18Now: {
					datetime: {
						dateOnly: true,
						earliest: window.moment.utc().subtract(150, 'years'),
						latest: window.moment.utc().subtract(18, 'years')
					}
				}
			}
		};
	} else {
		App.log('com::form-field: Extended date rules are not available.' +
			' Add Moment.js to enable them.');
	}

	App.components.exports('form-field', function formField (options) {
		var ctn;
		var input;
		var hint;
		var filename;
		var rules = [];
		var self;
		var isList = false;

		options = $.extend(true, {}, defaults, extendedDateRules, options);

		var enable = function (enable) {
			if (enable) {
				input.enable();
			} else {
				input.disable();
			}
		};

		var focus = function () {
			input.focus();
		};
		
		var scrollTo = function (options) {
			$.scrollTo(ctn, options);
		};

		var previewFile = function (ctn, file) {
			ctn.empty();
			//Change filename caption
			if (options.showFilename) {
				if (!!file && file.name) {
					filename.text(file.name);
				} else {
					filename.text(filename.attr('data-text'));
				}
			}

			if (!!file && !!win.FileReader && !!_.contains(file.type.split('/'), 'image')) {
				var reader = new win.FileReader();
				reader.onload = function readerLoaded (event) {
					ctn.empty();
					var r = event.target.result;
					if (!!r) {
						var img = $('<img />')
							.attr('class', ctn.attr('data-preview-class'))
							.attr('src', r)
							.on('error', function () {
								img.remove();
							});
						ctn.append(img);
					}
				};
				reader.readAsDataURL(file);
			}
		};

		var reset = function () {
			App.modules.notify('changeState.update', {
				item: ctn,
				state: 'valid',
				action: 'off'
			});

			App.modules.notify('changeState.update', {
				item: ctn,
				state: 'invalid',
				action: 'off'
			});

			App.modules.notify('changeState.update', {
				item: ctn,
				state: 'filled',
				action: 'off'
			});

			App.modules.notify('changeState.update', {
				item: ctn,
				state: 'focused',
				action: 'off'
			});

			App.modules.notify('changeState.update', {
				item: ctn,
				state: 'empty',
				action: 'on'
			});

			if (input.attr('type') == 'file') {
				if (options.showFilename) {
					filename.text(filename.attr('data-text'));
				} else {
					var target = ctn.find('.js-filename');
					var defaultFilename = ctn.attr('data-default-text-filename');
					target.text(defaultFilename);
				}

				//Reset preview
				previewFile(ctn.find(options.preview), null);
			}
		};

		var value = function () {
			var value;
			var selectedInput;
			var nb;
			if (input.attr('type') == 'checkbox') {
				value = input.prop('checked') ? 'true' : '';
			} else if (input.attr('type') == 'radio') {
				//Get grouped item
				var goodInput = input.closest('form').
					find('input[type="radio"][name="' + input.attr('name') + '"]:checked');
				if (!!goodInput.length) {
					value = goodInput.prop('checked') ? goodInput.val() : '';
				} else {
					value = input.prop('checked') ? input.val() : '';
				}
			} else if (input.hasClass('js-form-field-radio-list')) {
				selectedInput = input.find('input[type="radio"]:checked');
				nb = selectedInput.length;
				
				selectedInput.each(function (i) {
					var t = $(this);
					if (t.prop('checked')) {
						if (!!!value) {
							value = '';
						}

						value += t.attr('value');
						
						if (i < nb - 1) {
							value += ', ';
						}
					}
				});
			} else if (input.hasClass('js-form-field-checkbox-list')) {
				selectedInput = input.find('input[type="checkbox"]:checked');
				nb = selectedInput.length;
				
				selectedInput.each(function (i) {
					var t = $(this);
					if (t.prop('checked')) {
						if (!!!value) {
							value = '';
						}

						value += t.attr('value');
						
						if (i < nb - 1) {
							value += ', ';
						}
					}
				});
			} else {
				value = input.val();
			}
			return value;
		};

		var setValueState = function () {
			var val = value();

			App.modules.notify('changeState.update', {
				item: ctn,
				state: 'filled',
				action: !!val ? 'on' : 'off'
			});

			App.modules.notify('changeState.update', {
				item: ctn,
				state: 'empty',
				action: !val ? 'on' : 'off'
			});
		};

		var preview = function (e) {
			var p = ctn.find(options.preview);
			if (input.attr('type') == 'file') {
				setValueState();
				if (!!p.length) {
					var file = !!e && !!e.target.files && e.target.files[0];
					file = file || (input[0].files && input[0].files[0]);
					previewFile(p, file);
				}
			}
		};

		var tryValidate = function (value) {
			try {
				var constraints = {};
				var rulesOptions = {};
				_.each(rules, function (rule) {
					if (!!options.rules[rule]) {
						constraints = $.extend(constraints, options.rules[rule]);
					}
					if (!!options.rulesOptions[rule]) {
						rulesOptions = $.extend(rulesOptions, options.rulesOptions[rule]);
					}
				});

				return win.validate.single(value, constraints, rulesOptions);
			} catch (ex) {
				App.log({fx: 'error', args: [ex]});
			}
			return false;
		};
		
		var isValid = function () {
			return !tryValidate(value());
		};

		var format = function () {
			_.each(rules, function (rule) {
				if (!!options.formatters[rule]) {
					options.formatters[rule](input, self);
				}
			});
		};

		var validate = function () {
			var result = tryValidate(value());

			App.modules.notify('changeState.update', {
				item: ctn,
				state: 'invalid',
				action: !!result ? 'on' : 'off'
			});

			App.modules.notify('changeState.update', {
				item: ctn,
				state: 'valid',
				action: !result ? 'on' : 'off'
			});

			var hintMessages = !result ? '' :
				(options.onlyShowFirstHint ? result[0] : result.join('. '));

			hint.html(hintMessages);

			if (!result) {
				return;
			}

			return {
				result: result,
				field: self,
				hintMessages: hintMessages
			};
		};

		var attachEvents = function () {
			var i;
			if (!!options.formatEvents) {
				input.on(options.formatEvents, format);
			}
			if (!!options.validationEvents) {
				input.on(options.validationEvents, function (event) {
					if (event.type === 'blur' && !value()) {
						return;
					}

					validate();
				});
			}
			if (!!options.emptinessEvents) {
				input.on(options.emptinessEvents, setValueState);
			}
			if (!!options.previewEvents) {
				input.on(options.previewEvents, preview);
			}
			if (!!$.isFunction(options.onKeyup)) {
				input.on('keyup', function () {
					options.onKeyup({
						field: self
					});
				});
			}
			if (!!$.isFunction(options.onKeydown)) {
				input.on('keyup', function (e) {
					options.onKeydown({
						field: self,
						e: e
					});
				});
			}
			if (!!$.isFunction(options.onChangeOrInput)) {
				input.on('change input', function (e) {
					options.onChangeOrInput({
						field: self,
						e: e
					});
				});
			}

			i = input;

			if (!!isList) {
				i = input.find('input[type="radio"],input[type="checkbox"]');
			} else if (ctn.hasClass('js-form-field-file')) {
				i = ctn.find('.js-form-field-label-ctn');
			}

			i.on('focus', function () {
				App.modules.notify('changeState.update', {
					item: ctn,
					state: 'focused',
					action: 'on'
				});

				if (!!$.isFunction(options.onFocus)) {
					options.onFocus({
						field: self
					});
				}
			});

			i.on('blur', function () {
				App.modules.notify('changeState.update', {
					item: ctn,
					state: 'focused',
					action: 'off'
				});

				if (!!$.isFunction(options.onBlur)) {
					options.onBlur({
						field: self
					});
				}
			});
		};

		var fieldOptions = function (ctn) {
			var opts = {};
			var dataAttrPattern = new RegExp('^formField');
			opts = _.reduce(ctn.data(), function (memo, value, key) {
				if (dataAttrPattern.test(key)) {
					if (_.isObject(value)) {
						return memo;
					}
					var parsedKey = key.replace(dataAttrPattern, '');
					var validKey = '';
					if (!!parsedKey && !!parsedKey[0]) {
						validKey = parsedKey[0].toLowerCase();
						if (parsedKey.length >= 2) {
							validKey += parsedKey.substr(1);
						}
						memo[validKey] = value;
					}
				}
				return memo;
			}, {});
			return opts;
		};

		/* jshint maxstatements:38 */
		var init = function (o) {
			options = $.extend(true, options, o);
			ctn = $(options.container);
			input = ctn.find(options.input);
			hint = ctn.find(options.hint);
			filename = ctn.find(options.filename);
			rules = _.filter((ctn.attr('data-rules') || '').split(/[|,\s]/g));
			isList = input.hasClass('js-form-field-checkbox-list') ||
				input.hasClass('js-form-field-radio-list');

			options = _.assign(options, fieldOptions(ctn));

			attachEvents();
			setValueState();
		};

		self = {
			init: init,
			validate: validate,
			format: format,
			enable: enable,
			focus: focus,
			reset: reset,
			preview: preview,
			scrollTo: scrollTo,
			group: function () {
				return options.group;
			},
			isValid: isValid,
			isRequired: function () {
				return !!~rules.indexOf('required');
			},
			isEmpty: function () {
				return win.validate.isEmpty(value());
			},
			getCtn: function () {
				return ctn;
			},
			getInput: function () {
				return input;
			},
			getName: function () {
				return input.attr('name');
			},
			getValue: value
		};
		return self;
	});

})(jQuery, window);
