'use strict';

module.exports = function uflify (grunt) {
	grunt.gruntContribLoad(grunt.task.current.name);
	grunt.config.merge({
		uglify: {
			prod: {
				files: {
					'js/<%= pkg.name %>.min.js': [
						'js/<%= pkg.name %>.js'
					]
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
				drop_console: true,
				compress: {
					global_defs: {
						DEBUG: false
					},
					dead_code: true,
					unused: true,
					warnings: grunt.option('verbose')
				}
			}
		}
	});
};
