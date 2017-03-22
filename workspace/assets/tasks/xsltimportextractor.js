'use strict';

module.exports = function xsltimportextractor (grunt) {
	// Set default config
	
	grunt.registerTask('xsltimportextractor', 'DESCRIPTION', function () {
		var options = this.options();
		var libxmljs = require("libxmljs");
		var pages = grunt.file.expand(options.pagesPath);
		var files = {};
		var finalFiles = [];
		var basePath = '';
		var level = 0;

		var processPage = function (f) {
			//Template list

			var processFile = function (f) {

				var oldBasePath = basePath;

				var processImports = function (item) {
					//Lookup href
					var href = item.attr('href').value();

					processFile(href);
				};

				//Append files
				var lastSlash = f.lastIndexOf("/");
				
				if (lastSlash !== -1) {
					//Check Truncate

					if (basePath.length === 0) {
						basePath += f.substring(0, lastSlash + 1);

					} else if(f.startsWith("../")) {
						var countRemove = 0;

						f.split('/').forEach(function (ff) {
							if (ff == '..') {
								countRemove += 1;
							}
						});

						//Truncate a part
						var splitedBasePath = basePath.split('/');

						if (splitedBasePath.length > 1) {
							var newBasePath = '';
							var x = 1;

							splitedBasePath.forEach(function (item) {
								if (x == 1) {
									//always keep first ../
									newBasePath += item + '/';
									x += 1;
								} else if (splitedBasePath.length - x > countRemove) {
									newBasePath += item + '/';
									x += 1;
								}
							});

							//Fix ../ if not enought
							while(x < countRemove) {
								newBasePath += '../';
								x +=1;
							}
							basePath = newBasePath + f.substring(countRemove * 3, lastSlash + 1);
						}
					} else {
						//Append
						basePath += f.substring(0, lastSlash + 1);
					}

				} //else {
					//Do nothing
				//}

				var fixedFilePath = basePath + f.substring(lastSlash + 1);

				if (!!!files[fixedFilePath] && fixedFilePath.indexOf('ui-toolkit') === -1) {
					files[fixedFilePath] = fixedFilePath;
					level += 1;

					finalFiles.push({src:fixedFilePath, level: level});

					var xml = grunt.file.read(fixedFilePath);

					var xmlDoc = libxmljs.parseXmlString(xml);
					var imports = xmlDoc.find('//xsl:import', {xsl: 'http://www.w3.org/1999/XSL/Transform'})

					if (imports) {
						imports.forEach(processImports);
					}
					level -= 1;
				}
				basePath = oldBasePath;
			};
			processFile(f);
		};

		pages.forEach(processPage);

		//Print
		finalFiles.forEach(function (item) {
			grunt.log.write('(' + item.level + ') ');
			for (var i = 0; i < item.level; i++) {
				grunt.log.write('  ');
			}
			grunt.log.writeln(item.src);
		});
		
		grunt.config.set('xsltimportextrator.files.unique', finalFiles);
	});
};
