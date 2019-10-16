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
					'<%= src.css.coreLess %>',
					'<%= src.css.libLess %>',
					'<%= src.css.libCss %>',
					'<%= src.css.themeLess %>',
					'<%= src.css.themeCss %>'
				]
			},
			bundleLess: {
				src: [
					'<%= src.css.coreLess %>',
					'<%= src.css.libLess %>',
					'<%= src.css.themeLess %>'
				]
			},
			theme: {
				src: [
					'css/theme/__vars*.{less,css}',
					'css/theme/__theme*.{less,css}'
				]
			}
		}
	});
};
