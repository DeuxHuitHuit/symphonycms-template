'use strict';

module.exports = function concat (grunt) {
	grunt.gruntContribLoad(grunt.task.current.name);
	grunt.config.merge({
		concat: {
			options: {
				process: true
			},
			sources: {
				src: ['<%= src.js.src %>'],
				dest: 'js/<%= pkg.name %>.js'
			},
			libs: {
				src: [
					'<%= src.js.libs %>',
					'<%= src.js.lib %>',
					'js/core/framework.min.js',
					'js/<%= pkg.name %>.min.js'
				],
				dest: '<%= concat.libs.src[concat.libs.src.length - 1] %>',
				options: {
					process: false
				}
			},
			lessLibs: {
				src: 'css/lib/*.less',
				dest: '<%= src.css.lib %>'
			},
			lessCore: {
				src: 'css/core/*.less',
				dest: '<%= src.css.core %>'
			}
		}
	});
};
