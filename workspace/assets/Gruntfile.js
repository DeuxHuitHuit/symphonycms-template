/*global global:false, module:false, require:false*/
var md = require('matchdep');
var stripJsonComments = require('strip-json-comments');

module.exports = function (grunt) {

	'use strict';
	
	var GRUNT_FILE = 'Gruntfile.js';
	
	var BUILD_FILE = './build.json';
	
	var FTP_FILE = JSON.parse(stripJsonComments(grunt.file.read('../../ftpsync.settings')));
	var FTP_PASS = '.ftppass';
	
	var LESS_FILE = 'css/dev/grunt.less';
	var DEV_BUNDLE_LESS_FILE = 'css/dev/bundle.less';
	
	var JSON_JS_FILE = grunt.file.readJSON('./js.json');
	
	var fixJsFilePath = function (f) {
		return './js/' + f;
	};
	
	var fixCdnJsFilePath = function (file) {
		var filename = file.split('/');
		filename = filename[filename.length - 1];
		return './js/libs/' + filename;
	};
	
	var SRC_FILES = JSON_JS_FILE.sources.map(fixJsFilePath);
	
	var LIB_FILES = JSON_JS_FILE.libs.map(fixJsFilePath);
	
	var LIBS_FILES = JSON_JS_FILE['cdn-before'].map(fixCdnJsFilePath);
	
	var TEST_FILES = ['js/tests/*.js'];
	
	var visitor = (function () {
		try {
			return require('./Gruntcustom.js');
		} catch (e) {}
		var noop = function () {};
		return {
			config: noop,
			register: noop
		};
	})();
	
	var config = {
		pkg: grunt.file.readJSON('package.json'),
		buildnum: {
			options: {
				file: BUILD_FILE
			}
		},
		meta: {
			banner: '/*! <%= pkg.title || pkg.name %> - v<%= pkg.version %> - ' +
			'r<%= svninfo.last ? svninfo.last.rev : "X" %> - build <%= buildnum.num %> - ' +
			'<%= grunt.template.today("yyyy-mm-dd") %>\n' +
			'<%= pkg.homepage ? " * " + pkg.homepage + "\\n" : "" %>' +
			' * Copyright (c) <%= grunt.template.today("yyyy") %> ' +
			'<%= pkg.author.name %> (<%= pkg.author.url %>);\n' +
			' * <%= pkg.license %> */'
		},
		concat: {
			options: {
				process: true
			},
			sources: {
				src: SRC_FILES,
				dest: 'js/<%= pkg.name %>.js'
			},
			libs: {
				src: LIBS_FILES.concat(LIB_FILES).concat([
					'js/core/framework.min.js',
					'js/<%= pkg.name %>.min.js'
				]),
				dest: '<%= concat.libs.src[concat.libs.src.length - 1] %>',
				options: {
					process: false
				}
			},
			lessLibs: {
				src: 'css/lib/*.less',
				dest: 'css/lib/bundle.less'
			},
			lessCore: {
				src: 'css/core/*.less',
				dest: 'css/core/bundle.less'
			}
		},
		
		curl: (function (cdn) {
			var ret = {};
			cdn.forEach(function (file) {
				var filename = fixCdnJsFilePath(file);
				if (file.indexOf('//') === 0) {
					file = 'https:' + file;
				}
				ret[filename] = file;
			});
			return ret;
		})(JSON_JS_FILE['cdn-before']),
		
		watch: {
			files: SRC_FILES.concat(GRUNT_FILE),
			tasks: ['dev', 'css']
		},
		
		jshint: {
			files: SRC_FILES.concat(GRUNT_FILE),
			options: {
				bitwise: false,
				camelcase: false,
				curly: true,
				eqeqeq: false, // allow ==
				forin: true,
				//freeze: true,
				immed: false, //
				latedef: true, // late definition
				newcap: true, // capitalize ctos
				noempty: true,
				nonew: true, // no new ..()
				noarg: true, 
				plusplus: false,
				quotmark: 'single',
				undef: true,
				maxparams: 5,
				maxdepth: 5,
				maxstatements: 30,
				maxlen: 100,
				//maxcomplexity: 10,
				
				// relax options
				//boss: true,
				//eqnull: true, 
				esnext: true,
				regexp: true,
				strict: true,
				trailing: false,
				sub: true, // [] notation
				smarttabs: true,
				lastsemic: false, // enforce semicolons
				white: true,
				
				// env
				browser: true,
				
				globals: {
					jQuery: true,
					console: true,
					App: true,
					Loader: true,
					_: true
				}
			}
		},
		jscs: {
			src: SRC_FILES.concat(GRUNT_FILE),
			options: {
				config: '.jscsrc',
				fix: true
			}
		},
		uglify: {
			prod: {
				files: {
					'js/<%= pkg.name %>.min.js': '<%= concat.sources.dest %>' 
				}
			},
			options: {
				banner: '<%= meta.banner %>',
				report: 'gzip',
				sourceMap: true,
				sourceMapName: 'js/<%= pkg.name %>.min.js.map',
				mangle: true,
				preserveComments: 'some',
				screwIE8: true,
				quoteStyle: 3,
				compress: {
					global_defs: {
						DEBUG: false
					},
					dead_code: true,
					unused: true,
					warnings: true
				}
			}
		},
		
		less: {
			options: {
				ieCompat: false,
				strictUnits: true,
				report: 'gzip',
			},
			production: {
				options: {
					sourceMap: true,
					sourceMapFilename: 'css/main.css.map',
					sourceMappingURL: 'main.css.map',
				},
				files: {
					'css/main.css': LESS_FILE
				}
			},
			bundle: {
				files: {
					'css/lib/bundle.css': DEV_BUNDLE_LESS_FILE
				}
			}
		},
		
		purifycss: {
			options: {
				minify: false,
				info: true,
				rejected: true,
				whitelist: ['hidden', 'show', 'end', 'js-*', 'is-*', '#bg-transition']
			},
			target: {
				src: [
					'../pages/*.xsl',
					'../utilities/*.xsl',
					'../utilities/**/*.xsl',
					'js/**/*.js'
				],
				css: ['css/main.css'],
				dest: 'css/main.pure.css'
			}
		},
		
		csso: {
			compress: {
				options: {
					report: 'gzip',
					banner: '<%= meta.banner %>\n',
				},
				files: {
					'css/main.min.css': ['css/main.pure.css']
				}
			}
		},
		
		complexity: {
			generic: {
				src: SRC_FILES,
				options: {
					//jsLintXML: 'report.xml', // create XML JSLint-like report
					errorsOnly: false, // show only maintainability errors
					cyclomatic: 10, // 3
					halstead: 17, // 8
					maintainability: 95 //100
				}
			}
		},

		csslint: {
			options: {
				// errors
				import: 2,
				
				// warnings
				'font-sizes': true,
				
				// disable
				important: false,
				'unique-headings': false,
				ids: false,
				'box-model': false,
				'universal-selector': false,
				'adjoining-classes': false,
				'font-faces': false,
				shorthand: false,
				'box-sizing': false,
				'qualified-headings': false,
				'fallback-colors': false,
				'bulletproof-font-face': false,
				'regex-selectors': false,
				'unqualified-attributes': false
			},
			src: ['css/main.css']
		},
		
		clean: {
			bundle: {
				options: {
					force: true
				},
				src: ['<%= concat.lessLibs.dest %>', '<%= concat.lessCore.dest %>']
			}
		},

		svninfo: {
			options: {
				cwd: '../../'
			}
		},

		ftps_deploy: {
			options: {
				auth:{
					host: FTP_FILE.default.host,
					port: FTP_FILE.default.port || 21,
					authKey: 'default',
					secure: true
				}
			},
			build: {
				files: [{
					cwd: '.',
					src: [
						'js/<%= pkg.name %>.min.js',
						'css/main.min.css',
						BUILD_FILE
					],
					dest: FTP_FILE.default.path + 'workspace/assets/',
				}]
			},
			bundle: {
				files: [{
					cwd: '.',
					src: [
						'css/lib/bundle.css',
						'css/lib/bundle.less',
						'css/core/bundle.less'
					],
					dest: FTP_FILE.default.path + 'workspace/assets/',
				}]
			}
		}
	};
	
	var init = function (grunt) {
		// Overrides some values
		grunt.util.linefeed = '\n';
		grunt.file.preserveBOM = true;
		
		// visit config
		visitor.config(grunt, config);
		
		// verbose by default
		grunt.option('verbose', true);
		
		// Project configuration.
		grunt.initConfig(config);

		// generate build number
		grunt.registerTask('buildnum',
			'Generates and updates the current build number', function () {
			var options = this.options();
			var getBuildNumber = function () {
				var b = {};
				
				try {
					b = grunt.file.readJSON(options.file);
				} catch (e) {}
				
				b.previous = {
					lastBuild: b.lastBuild,
					svn: Object.assign({}, b.svn)
				};
				
				b.lastBuild = b.lastBuild > 0 ? b.lastBuild + 1 : 1;
				
				b.date = (new Date()).toISOString();
				
				var svn = grunt.config.get('svninfo');
				if (!!svn) {
					b.svn = {
						rev: svn.rev,
						last: svn.last,
						url: svn.url
					};
				}
				
				grunt.file.write(options.file, JSON.stringify(b, null, 4));
				
				return b.lastBuild;
			};
			
			var buildnum = getBuildNumber();
			grunt.config.set('buildnum.num', buildnum);
			grunt.log.writeln('New build num:', buildnum);
			grunt.log.writeln('For version:', config.pkg.version);
		});

		// ftps boot
		grunt.registerTask('ftps_boot', 'Creates FTP files', function () {
			grunt.file.write(FTP_PASS, JSON.stringify(FTP_FILE));
		});

		// ftps clean up
		grunt.registerTask('ftps_cleanup', 'Cleans shit up', function () {
			grunt.file.delete(FTP_PASS);
		});

		// Default tasks.
		grunt.registerTask('push',    ['ftps_boot', 'ftps_deploy:build', 'ftps_cleanup']);
		grunt.registerTask('dev',     ['jscs', 'jshint', 'complexity']);
		grunt.registerTask('js',      ['concat:sources', 'uglify', 'curl', 'concat:libs']);
		grunt.registerTask('bundle',  [
			'clean:bundle',
			'concat:lessLibs',
			'concat:lessCore',
			'less:bundle',
			'ftps_boot',
			'ftps_deploy:bundle',
			'ftps_cleanup'
		]);
		grunt.registerTask('css',     ['less:production', 'purifycss', 'csso']);
		grunt.registerTask('build',   ['svninfo', 'buildnum', 'js', 'css']);
		grunt.registerTask('default', ['dev', 'build']);
		
		// visit grunt
		visitor.register(grunt, config);
	};
	
	var load = function (grunt) {
		md.filterAll('grunt-*').forEach(grunt.loadNpmTasks);
		
		init(grunt);
	};
	
	load(grunt);
};
