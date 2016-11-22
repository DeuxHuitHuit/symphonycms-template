'use strict';

module.exports = function jshint(grunt) {
	grunt.gruntLoad(grunt.task.current.name);
	grunt.config.merge({
		complexity: {
			generic: {
				src: '<%= src.js.src %>',
				options: {
					//jsLintXML: 'report.xml', // create XML JSLint-like report
					errorsOnly: false, // show only maintainability errors
					cyclomatic: 10, // 3
					halstead: 19, // 8
					maintainability: 95 //100
				}
			}
		}
	});
};
