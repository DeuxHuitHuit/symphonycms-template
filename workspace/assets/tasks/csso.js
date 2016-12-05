'use strict';

module.exports = function csso (grunt) {
	grunt.gruntLoad(grunt.task.current.name);
	grunt.config.merge({
		csso: {
			compress: {
				options: {
					report: 'gzip',
					banner: '<%= meta.banner %>\n'
				},
				files: {
					'css/<%= pkg.name %>.min.css': [
						'css/<%= pkg.name %>.css'
					]
				}
			}
		}
	});
};
