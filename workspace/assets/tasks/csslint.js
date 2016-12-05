'use strict';

module.exports = function csslint (grunt) {
	grunt.gruntContribLoad(grunt.task.current.name);
	grunt.config.merge({
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
				'unqualified-attributes': false,
				stroke: false,
				fill: false,
				'order-alphabetical': false
			},
			src: [
				'css/<%= pkg.name %>.min.css'
			]
		}
	});
};
