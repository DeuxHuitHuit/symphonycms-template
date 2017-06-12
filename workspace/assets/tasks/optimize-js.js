'use strict';

module.exports = function optimizejs (grunt) {
	grunt.gruntLoad(grunt.task.current.name);
	grunt.config.merge({
		'optimize-js': {
			prod: {
				files: {
					'js/<%= pkg.name %>.min.js': [
						'js/<%= pkg.name %>.min.js'
					]
				}
			},
			options: {
				slient: false,
				sourceMap: false
			}
		}
	});
};
