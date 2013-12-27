/*global module:false, require:false*/
var md = require('matchdep');

module.exports = function(grunt) {

	'use strict';
	
	var GRUNT_FILE = 'Gruntfile.js';
	
	var BUILD_FILE = './dist/build.json';
	
	var LESS_FILE = 'css/main.less';
	
	var SRC_FILFES = [
		'./src/com/*.js',
		'./src/modules/*.js',
		'./src/transitions/*.js',
		'./src/pages/*.js',
		'./src/utils/*.js'
	];
	
	var TEST_FILES = ['js/tests/*.js'];
	
	var getBuildNumber = function () {
		var b = {};
		
		try {
			b = grunt.file.readJSON(BUILD_FILE);
		} catch (e) {}
		
		b.lastBuild = b.lastBuild > 0 ? b.lastBuild + 1 : 1;
		
		grunt.file.write(BUILD_FILE, JSON.stringify(b));
		
		return b.lastBuild;
	};
	
	var config = {
		pkg: grunt.file.readJSON('package.json'),
		build: 'auto',
		meta: {
			banner: '/*! <%= pkg.title || pkg.name %> - v<%= pkg.version %> ' +
			'- build <%= build %> - ' +
			'<%= grunt.template.today("yyyy-mm-dd") %>\n' +
			'<%= pkg.homepage ? "* " + pkg.homepage + "\\n" : "" %>' +
			'* Copyright (c) <%= grunt.template.today("yyyy") %> <%= pkg.author.name %> (<%= pkg.author.url %>);\n' +
			'* Licensed <%= _.pluck(pkg.licenses, "type").join(", ") %> */\n'
		},
		concat: {
			options: {
				process: true,
				banner: '<%= meta.banner %>'
			},
			dist: {
				src: SRC_FILFES,
				dest: 'js/<%= pkg.name %>.js'
			}
		},
		
		watch: {
			files: SRC_FILFES.concat(GRUNT_FILE),
			tasks: ['dev']
		},
		
		jshint: {
			files: SRC_FILFES.concat(GRUNT_FILE),
			options: {
				curly: true,
				eqeqeq: false, // allow ==
				immed: false, //
				latedef: false, // late definition
				newcap: false, // capitalize ctos
				nonew: true, // no new ..()
				noarg: true, 
				sub: true,
				undef: true,
				//boss: true,
				eqnull: true, // relax
				browser: true,
				regexp: true,
				strict: true,
				trailing: false,
				smarttabs: true,
				lastsemic: true,
				globals: {
					console: true,
					jQuery: true,
					pd: true,
					_: true,
					Popcorn: true,
					DEBUG: true,
					CSS3: true,
					JSON: true
				}
			}
		},
		uglify: {
			prod: {
				files: {
					'js/<%= pkg.name %>.min.js': '<%= concat.dist.dest %>' 
				}
			},
			options: {
				banner: '<%= meta.banner %>',
				report: 'gzip',
				sourceMap: 'js/<%= pkg.name %>.min.js.map',
				sourceMappingURL: '<%= pkg.name %>.min.js.map',
				mangle: true,
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
			development: {
				files: {
					'css/main.css': LESS_FILE
					//'css/main.mobile.css': lessMobileFile,
					//'css/ie9.css': 'css/ie9.less'
				}
			},
			production: {
				options: {
					yuicompress: true
				},
				files: {
					'css/main.min.css': LESS_FILE
					//'css/main.mobile.min.css': lessMobileFile,
					//'css/ie9.min.css': 'css/ie9.less'
				}
			}
		},
		
		usebanner: {
			build: {
				options: {
					position: 'top',
					banner: '<%= meta.banner %>',
					linebreak: true
				},
				files: {
					src: [ 'css/main.min.css'/*, 'css/ie9.min.css'*/ ]
				}
			}
		},
		
		complexity: {
			generic: {
				src: SRC_FILFES,
				options: {
					//jsLintXML: 'report.xml', // create XML JSLint-like report
					errorsOnly: false, // show only maintainability errors
					cyclomatic: 10, // 3
					halstead: 17, // 8
					maintainability: 95 //100
				}
			}
		},
		clean: {
			copy: {
				options: {
					force: true
				},
				src:['../../../dist/**']
			}
		},
		
		copy: {
			main: {
				files: [
					{expand: true, cwd: '../../', src: ['**', '.htaccess'], dest: '../../../dist/', filter: 'isFile'}
				],
				options: {
					processContentExclude: ['**/img/*.{png,gif,jpg,ico,psd}', '**/symphony/*.{png,gif,jpg,ico,psd}', '**/extensions/*.{png,gif,jpg,ico,psd}'],
					processContent: function (content, srcpath) {
						var r = [
							/Gruntfile\.js/g, 
							/package\.json/g, 
							/node_modules(.*)/g, 
							/\/js\/com\/(.*)\.js/g, 
							/\/js\/modules\/(.*)\.js/g, 
							/\/js\/pages\/(.*)\.js/g, 
							/\/js\/transitions\/(.*)\.js/g, 
							/\/js\/utils\/(.*)\.js/g, 
							/\/css\/(.*)\.less/g
							];
						var res = true;
						r.forEach(function (re) {
							if (re.test(srcpath)) {
								res = false;
								return false; // break;
							}
							return true;
						});
						return res ? content : res;
					}
				}
			}
		}
	};
	
	var init = function (grunt) {
		grunt.file.preserveBOM = true;
		
		// Project configuration.
		grunt.initConfig(config);

		// Default tasks.
		grunt.registerTask('dev',     ['jshint','complexity']);
		grunt.registerTask('build',   ['concat','uglify','less','usebanner']);
		grunt.registerTask('dist',    ['clean:copy','build','copy']);
		grunt.registerTask('default', ['dev','build']);
	};
	
	var load = function (grunt) {
		md.filter('grunt-*').forEach(grunt.loadNpmTasks);
		md.filter('karma-*').forEach(grunt.loadNpmTasks);
		
		config.build = getBuildNumber();
		
		init(grunt);
	};
	
	load(grunt);
};