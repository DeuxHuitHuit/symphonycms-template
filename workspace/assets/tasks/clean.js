'use strict';

module.exports = function clean (grunt) {
	grunt.gruntContribLoad(grunt.task.current.name);
	grunt.config.merge({
		clean: {
			options: {
				force: true
			},
			build: {
				src: [
					'css/<%= pkg.name %>.*',
					'js/<%= pkg.name %>.*'
				]
			},
			css: {
				src: [
					'css/<%= pkg.name %>.*'
				]
			},
			js: {
				src: [
					'js/<%= pkg.name %>.*'
				]
			},
			bundle: {
				src: [
					'<%= src.css.lib %>',
					'<%= src.css.core %>',
					'<%= src.css.bundle %>'
				]
			}
		}
	});
};
