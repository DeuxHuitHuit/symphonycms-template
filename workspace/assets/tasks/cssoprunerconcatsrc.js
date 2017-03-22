'use strict';

module.exports = function cssoprunerconcatsrc (grunt) {
	grunt.registerTask('cssoprunerconcatsrc', 'DESCRIPTION', function () {
		var options = this.options();
		var conf = grunt.config.get();
		var src = conf.cssopruner.compress.options.src;

		//merge xslt
		var xsltFiles = grunt.config.get('xsltimportextrator.files.unique');

		xsltFiles.forEach(function (item) {
			src.push(item.src);
		});

		var jsSrc = grunt.config.get('src.js.src');
		jsSrc.forEach(function (item) {
			src.push(item);
		});

		src.forEach(function (item) {
			grunt.log.writeln(item);
		});

		grunt.config.set('cssopruner.compress.options.src', src);
	});
};
