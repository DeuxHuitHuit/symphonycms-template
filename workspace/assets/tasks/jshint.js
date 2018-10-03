'use strict';

module.exports = function jshint (grunt) {
	grunt.gruntContribLoad(grunt.task.current.name);
	grunt.config.merge({
		jshint: {
			files: [
				'<%= src.js.src %>',
				'<%= src.gruntfile %>'
			],
			options: {
				esversion: 5,
				bitwise: false,
				camelcase: false,
				curly: true,
				eqeqeq: false, // allow ==
				forin: true,
				freeze: true,
				immed: false, //
				latedef: true, // late definition
				newcap: true, // capitalize ctos
				noempty: true,
				nonew: true, // no new ..()
				noarg: true,
				plusplus: false,
				quotmark: 'single',
				undef: true,
				maxparams: 5,
				maxdepth: 5,
				maxstatements: 30,
				maxlen: 100,
				nonbsp: true,

				// relax options
				regexp: true,
				strict: true,
				trailing: false,
				sub: true, // [] notation
				smarttabs: true,
				lastsemic: false, // enforce semicolons
				
				// env
				browser: true,
				
				globals: {
					jQuery: true,
					console: true,
					App: true,
					Loader: true,
					_: true,
					module: true,
					google: true
				}
			}
		}
	});
};
