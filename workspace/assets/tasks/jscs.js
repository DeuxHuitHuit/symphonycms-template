'use strict';

var JSCS_FILE = '.jscsrc';

module.exports = function jscs (grunt) {
	grunt.gruntLoad(grunt.task.current.name);
	grunt.config.merge({
		jscs: {
			src: [
				'<%= src.js.src %>',
				'<%= src.gruntfile %>',
				'tasks/*.js'
			],
			options: {
				config: JSCS_FILE,
				fix: true,
				disallowDanglingUnderscores: {
					allExcept: ['_', '_currentPage', '_highlightResult']
				}
			}
		}
	});
};
