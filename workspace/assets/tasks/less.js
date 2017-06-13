'use strict';

module.exports = function jshint (grunt) {
	grunt.gruntContribLoad(grunt.task.current.name);
	grunt.config.merge({
		less: {
			options: {
				ieCompat: false,
				strictUnits: true,
				report: true
			},
			production: {
				options: {
					sourceMap: false,
					sourceMapFilename: 'css/<%= pkg.name %>.css.map',
					sourceMappingURL: '<%= pkg.name %>.css.map'
				},
				files: {
					'css/<%= pkg.name %>.css': '<%= src.css.main %>'
				}
			},
			lib: {
				files: {
					'<%= src.css.libCss %>': '<%= src.css.lib %>'
				}
			},
			theme: {
				files: {
					'<%= src.css.themeCss %>': '<%= src.css.theme %>'
				}
			}
		}
	});
};
