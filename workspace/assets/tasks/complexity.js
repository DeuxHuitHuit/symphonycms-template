'use strict';

module.exports = function jshint (grunt) {
	grunt.gruntLoad(grunt.task.current.name);
	grunt.config.merge({
		complexity: {
			generic: {
				src: '<%= src.js.src %>',
				options: {
					//jsLintXML: 'report.xml', // create XML JSLint-like report
					errorsOnly: false, // show only maintainability errors
					cyclomatic: 12, // 12
					halstead: 19, // 19
					maintainability: 95 //100
				}
			}
		}
	});
};
