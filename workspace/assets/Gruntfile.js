/*global global:false, module:false, require:false*/

module.exports = function (grunt) {

	'use strict';
	
	var PKG_FILE = 'package.json';
	var GRUNT_FILE = 'Gruntfile.js';
	var BUILD_FILE = 'build.json';
	var LESS_FILE = 'css/dev/grunt.less';
	var PAGES_PATH = '../pages/*.xsl';
	var DEV_LIB_BUNDLE_LESS_FILE = 'css/dev/lib.less';
	var DEV_THEME_BUNDLE_LESS_FILE = 'css/dev/theme.less';

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
		pkg: grunt.file.readJSON(PKG_FILE),
		
		meta: {
			banner: '/*! <%= pkg.title || pkg.name %> - v<%= pkg.version %> - ' +
			'r<%= svninfo.last ? svninfo.last.rev : "X" %> - build <%= buildnum.num %> - ' +
			'<%= grunt.template.today("yyyy-mm-dd") %>\n' +
			'<%= pkg.homepage ? " * " + pkg.homepage + "\\n" : "" %>' +
			' * Copyright (c) <%= grunt.template.today("yyyy") %> ' +
			'<%= pkg.author.name %> (<%= pkg.author.url %>);\n' +
			' * <%= pkg.license %> */'
		},

		src: {
			js: {
				src: SRC_FILES,
				lib: LIB_FILES,
				libs: LIBS_FILES,
				tests: TEST_FILES,
				json: JSON_JS_FILE
			},
			css: {
				main: LESS_FILE,
				lib: DEV_LIB_BUNDLE_LESS_FILE,
				theme: DEV_THEME_BUNDLE_LESS_FILE,
				themeLess: 'css/theme/__theme.less',
				themeCss: 'css/theme/__theme.css',
				libLess: 'css/lib/__lib.less',
				libCss: 'css/lib/__lib.css',
				coreLess: 'css/core/__core.less'
			},
			gruntfile: GRUNT_FILE,
			buildfile: BUILD_FILE,
			pkgfile: PKG_FILE
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

		xsltimportextractor: {
			options: {
				pagesPath: PAGES_PATH
			}
		},

		cssopruner: {
			compress: {
				options: {
					src: []
				}
			}
		},

		buildnum: {},
		svninfo: {}
	};
	
	var init = function (grunt) {
		// Overrides some values
		grunt.util.linefeed = '\n';
		grunt.file.preserveBOM = false;
		
		// visit config
		visitor.config(grunt, config);
		
		// custom loaders
		grunt.gruntLoad = function (task) {
			grunt.task.loadNpmTasks('grunt-' + task.split(':')[0]);
		};
		grunt.gruntContribLoad = function (task) {
			grunt.gruntLoad('contrib-' + task);
		};
		
		// Project configuration.
		grunt.initConfig(config);

		// Default tasks.
		grunt.registerTask('noop', []);
		grunt.registerTask('verbose', 'turns verbose on', function () {
			grunt.option('verbose', true);
		});
		grunt.registerTask('js-dev', [
			'jscs',
			'jshint',
			'complexity'
		]);
		grunt.registerTask('js', [
			'clean:js',
			'concat:sources',
			'uglify',
			'curl',
			'concat:libs',
			'optimize-js'
		]);
		grunt.registerTask('css-dev', [
			'csslint'
		]);
		grunt.registerTask('bundle', [
			'clean:bundle',
			'concat:lessCore',
			'concat:lessLib',
			'xmlbundle:site',
			'less:lib',
			'less:theme',
			'ftps_boot',
			'ftps_deploy:bundle',
			'ftps_cleanup'
		]);
		grunt.registerTask('css', [
			'clean:css',
			'less:production',
			'xsltimportextractor',
			'cssoprunerconcatsrc',
			'cssopruner',
			'csso'
		]);
		grunt.registerTask('dev', [
			'js-dev',
			'css-dev'
		]);
		grunt.registerTask('build', [
			'clean:bundleLess',
			'concat:lessCore',
			'concat:lessLib',
			'xmlbundle:site',
			'svninfo',
			'buildnum',
			'js',
			'css'
		]);
		grunt.registerTask('default', [
			'noop'
		]);
		
		// visit grunt
		visitor.register(grunt, config);
	};
	
	var load = function (grunt) {
		require('time-grunt')(grunt);
		var jitLoader = require('jit-grunt')(grunt, {
			ftps_boot: 'tasks/ftps_deploy.js',
			push: 'tasks/ftps_deploy.js',
			uploadfile: 'tasks/ftps_deploy.js'
		});
		jitLoader({
			customTasksDir: 'tasks'
		});
		init(grunt);
	};
	
	load(grunt);
};
