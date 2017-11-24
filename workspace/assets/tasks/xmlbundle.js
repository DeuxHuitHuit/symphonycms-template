'use strict';

module.exports = function xmlbundle (grunt) {
	grunt.config.merge({
		xmlbundle: {
			
		}
	});
	
	grunt.registerTask('xmlbundle',
		'DESCRIPTION', function () {
		var options = this.options();
		var libxmljs = require("libxmljs");
		var endOfLine = require('os').EOL;

		var fs = require('fs');

		var resultVar = '';
		var resultTheme = '';

		//Lookup default file
		var defaultTheme = grunt.file.read('css/vars/theme-default.xml');
		var defaultDoc = libxmljs.parseXmlString(defaultTheme);

		//Lookup theme file
		var theme = grunt.file.read('css/vars/theme.xml');
		var themeDoc = libxmljs.parseXmlString(theme);

		//Validate the theme
		var allTheme = themeDoc.find('//theme');

		if (!allTheme.length) {
			throw new Error('No theme found!');
		}

		//TODO process all theme
		allTheme.forEach(function (theme) {
			var spacings = null;
			var dimensions = null;
			var fontsSize = null;
			var letterSpacing = null;
			var lineHeight = null;
			var borderSizes = null;
			var radius = null;
			var fonts = null;
			var opacity = null;
			var durations = null;
			var ease = null;
			var themeName = '';

			resultVar = '';
			resultTheme = '';
			var prefixVar = '';

			var type = theme.attr('type').value();

			var curThemeSelector = '//theme[@type=\'' + type + '\']';

			var writeVariable = function (name, value) {
				resultVar += '@' + prefixVar + name;
				resultVar += ': ' + value;
				resultVar += ';' + endOfLine;
			};

			if (type != 'site') {
				themeName = '-' + type;
				prefixVar = type + '-';
			}

			var processColors = function () {
				var mergeColorsVariables = function () {
					var result = [];

					if (type == 'site') {
						var coreVariables = defaultDoc.find('//colors/type[@name=\'core-variables\']/*');

						coreVariables.forEach(function (item) {
							var name = item.name();
							var overrideNode = themeDoc.find(curThemeSelector + '/colors/type[@name=\'core-variables\']/' + name);
							if (overrideNode.length === 1) {
								result.push(overrideNode[0]);
							} else {
								result.push(item);
							}
						});
					}

					//Add others variables
					//Scan symbolic
					var symbolic = themeDoc.find(curThemeSelector + '/colors/type[@name=\'symbolic\']/*');
					symbolic.forEach(function (item) {
						result.push(item);
					});
					return result;
				};

				var writeColorsTheme = function () {
					var symbolic = themeDoc.find(curThemeSelector + '/colors/type[@name=\'symbolic\']/*');
					resultTheme += '#generate-color-class(@suffix: ~\'\') {' + endOfLine;
					symbolic.forEach(function (item) {
						resultTheme += '	#generate-color-class(@suffix, ~\'' +
							item.name() + '\', @' + item.name() + ');' + endOfLine;
					});
					resultTheme += '}' + endOfLine;
				};

				var writeColorsVariables = function () {
					var mergedColorsVariables = mergeColorsVariables();
					mergedColorsVariables.forEach(function (item) {
						writeVariable(item.name(), item.attr('value').value());
					});
				};

				writeColorsTheme();
				writeColorsVariables();
			};

			var processVars = function () {
				spacings = themeDoc.find(curThemeSelector + '[1]/spacing/*');
				spacings.forEach(function (item) {
					writeVariable('spacing-' + item.name(), item.attr('value').value());
				});

				dimensions = themeDoc.find(curThemeSelector + '[1]/dimensions/*');
				dimensions.forEach(function (item) {
					writeVariable('dimension-' + item.name(), item.attr('value').value());
				});

				fonts = themeDoc.find(curThemeSelector + '[1]/typographie/fonts/*');
				fonts.forEach(function (item) {
					writeVariable('font-' + item.name(), item.attr('value').value());
				});

				fontsSize = themeDoc.find(curThemeSelector + '[1]/typographie/fonts-size/*');
				fontsSize.forEach(function (item) {
					writeVariable('font-' + item.name(), item.attr('value').value());
				});

				lineHeight = themeDoc.find(curThemeSelector + '[1]/typographie/line-height/*');
				lineHeight.forEach(function (item) {
					writeVariable('line-height-' + item.name(), item.attr('value').value());
				});

				letterSpacing = themeDoc.find(curThemeSelector + '[1]/typographie/letter-spacing/*');
				letterSpacing.forEach(function (item) {
					writeVariable('letter-spacing-' + item.name(), item.attr('value').value());
				});

				opacity = themeDoc.find(curThemeSelector + '[1]/opacity/*');
				opacity.forEach(function (item) {
					writeVariable(item.name(), item.attr('value').value());
				});

				borderSizes = themeDoc.find(curThemeSelector + '[1]/border/size/*');
				borderSizes.forEach(function (item) {
					writeVariable('border-' + item.name(), item.attr('value').value());
				});

				radius = themeDoc.find(curThemeSelector + '[1]/border/radius/*');
				radius.forEach(function (item) {
					writeVariable('radius-' + item.name(), item.attr('value').value());
				});

				durations = themeDoc.find(curThemeSelector + '[1]/transition/duration/*');
				durations.forEach(function (item) {
					writeVariable('duration-' + item.name(), item.attr('value').value());
				});

				ease = themeDoc.find(curThemeSelector + '[1]/transition/ease/*');
				ease.forEach(function (item) {
					writeVariable('ease-' + item.name(), item.attr('value').value());
				});
			};

			var processFlexBasis = function () {
				resultTheme += '#generate-flex-basis-classes(@suffix: ~\'\') {' + endOfLine;
				spacings.forEach(function (item) {
					resultTheme += '	.flex-basis-' + item.name() + '@{suffix} {#flex-basis(@spacing-' +
						item.name() + ');}' + endOfLine;
				});
				dimensions.forEach(function (item) {
					resultTheme += '	.flex-basis-' + item.name() + '@{suffix} {#flex-basis(@dimension-' +
						item.name() + ');}' + endOfLine;
				});
				resultTheme += '}' + endOfLine;
			};

			var processFontSize = function () {
				resultTheme += '#generate-font-size-classes(@suffix: ~\'\') {' + endOfLine;
				fontsSize.forEach(function (item) {
					resultTheme += '	.text-' + item.name() + '@{suffix} {font-size: @font-' +
						item.name() + ';}' + endOfLine;
				});
				resultTheme += '}' + endOfLine;
			};

			var processHeight = function () {
				resultTheme += '#generate-height-classes(@suffix: ~\'\') {' + endOfLine;
				spacings.forEach(function (item) {
					resultTheme += '	#generate-all-height-class(@suffix, ~\'' + item.name() + '\',  @spacing-' +
						item.name() + ');' + endOfLine;
				});

				dimensions.forEach(function (item) {
					resultTheme += '	#generate-all-height-class(@suffix, ~\'' + item.name() + '\',  @dimension-' +
						item.name() + ');' + endOfLine;
				});
				resultTheme += '}' + endOfLine;
			};

			var processLetterSpacing = function () {
				resultTheme += '#generate-letter-spacing-classes(@suffix: ~\'\') {' + endOfLine;
				letterSpacing.forEach(function (item) {
					resultTheme += '	.letter-spacing-' + item.name() +
						'@{suffix} {letter-spacing: @letter-spacing-' +
						item.name() + ';}' + endOfLine;
				});
				resultTheme += '}' + endOfLine;
			};

			var processLineHeight = function () {
				resultTheme += '#generate-line-height-classes(@suffix: ~\'\') {' + endOfLine;
				lineHeight.forEach(function (item) {
					resultTheme += '	.line-height-' + item.name() +
						'@{suffix} {line-height: @line-height-' +
						item.name() + ';}' + endOfLine;
				});
				resultTheme += '}' + endOfLine;
			};

			var processMargin = function () {
				resultTheme += '#generate-margin-classes(@direction: ~\'\', @suffix: ~\'\') {' + endOfLine;

				spacings.forEach(function (item) {
					resultTheme += '	#generate-margin-classes-value(@direction, @suffix, ~\'' +
						item.name() +
						'\', @spacing-' +
						item.name() + ');' + endOfLine;
				});

				dimensions.forEach(function (item) {
					resultTheme += '	#generate-margin-classes-value(@direction, @suffix, ~\'' +
						item.name() +
						'\', @dimension-' +
						item.name() + ');' + endOfLine;
				});

				//Minus
				spacings.forEach(function (item) {
					resultTheme += '	#generate-margin-classes-value(@direction, @suffix, ~\'minus-' +
						item.name() +
						'\', -@spacing-' +
						item.name() + ');' + endOfLine;
				});

				dimensions.forEach(function (item) {
					resultTheme += '	#generate-margin-classes-value(@direction, @suffix, ~\'minus-' +
						item.name() +
						'\', -@dimension-' +
						item.name() + ');' + endOfLine;
				});

				resultTheme += '}' + endOfLine;

				//Two axes
				resultTheme += '#generate-margin-two-axes-classes(@direction: ~\'\', @axe1, @axe2, @suffix: ~\'\') {' + endOfLine;
				spacings.forEach(function (item) {
					resultTheme += '	#generate-margin-two-axes-class-value(@direction, @suffix, @axe1, @axe2, ~\'' +
					item.name() + '\', @spacing-' + item.name() + ');' + endOfLine;
				});

				dimensions.forEach(function (item) {
					resultTheme += '	#generate-margin-two-axes-class-value(@direction, @suffix, @axe1, @axe2, ~\'' +
					item.name() + '\', @dimension-' + item.name() + ');' + endOfLine;
				});

				//Minus
				spacings.forEach(function (item) {
					resultTheme += '	#generate-margin-two-axes-class-value(@direction, @suffix, @axe1, @axe2, ~\'minus-' +
					item.name() + '\', -@spacing-' + item.name() + ');' + endOfLine;
				});

				dimensions.forEach(function (item) {
					resultTheme += '	#generate-margin-two-axes-class-value(@direction, @suffix, @axe1, @axe2, ~\'minus-' +
					item.name() + '\', -@dimension-' + item.name() + ');' + endOfLine;
				});

				resultTheme += '}' + endOfLine;
			};

			var processPadding = function () {
				resultTheme += '#generate-padding-classes(@direction: ~\'\', @suffix: ~\'\') {' + endOfLine;

				spacings.forEach(function (item) {
					resultTheme += '	#generate-padding-classes-value(@direction, @suffix, ~\'' +
						item.name() +
						'\', @spacing-' +
						item.name() + ');' + endOfLine;
				});

				dimensions.forEach(function (item) {
					resultTheme += '	#generate-padding-classes-value(@direction, @suffix, ~\'' +
						item.name() +
						'\', @dimension-' +
						item.name() + ');' + endOfLine;
				});

				resultTheme += '}' + endOfLine;

				//two axes
				resultTheme += '#generate-padding-two-axes-classes(@direction: ~\'\', @axe1, @axe2, @suffix: ~\'\') {' + endOfLine;

				spacings.forEach(function (item) {
					resultTheme += '	#generate-padding-two-axes-class-value(@direction, @suffix, @axe1, @axe2, ~\'' +
					item.name() + '\', @spacing-' + item.name() + ');' + endOfLine;
				});

				dimensions.forEach(function (item) {
					resultTheme += '	#generate-padding-two-axes-class-value(@direction, @suffix, @axe1, @axe2, ~\'' +
					item.name() + '\', @dimension-' + item.name() + ');' + endOfLine;
				});

				resultTheme += '}' + endOfLine;
			};

			var processWidth = function () {
				resultTheme += '#generate-width-classes(@suffix: ~\'\') {' + endOfLine;
				spacings.forEach(function (item) {
					resultTheme += '	#generate-all-width-class(@suffix, ~\'' + item.name() + '\',  @spacing-' +
						item.name() + ');' + endOfLine;
				});

				dimensions.forEach(function (item) {
					resultTheme += '	#generate-all-width-class(@suffix, ~\'' + item.name() + '\',  @dimension-' +
						item.name() + ');' + endOfLine;
				});
				resultTheme += '}' + endOfLine;
			};

			var processBorderRadius = function () {
				//All
				radius.forEach(function (item) {
					resultTheme += '.border-radius-' + item.name() + ', ' +
						'.radius-' + item.name() + '{border-radius: @radius-' + item.name() + ';}' + endOfLine;
				});
				
				//Left
				radius.forEach(function (item) {
					resultTheme += '.border-radius-left-' + item.name() + ', ' +
						'.radius-left-' + item.name() + '{' + endOfLine +
						'	border-bottom-left-radius: @radius-' + item.name() + ';' + endOfLine +
						'	border-top-left-radius: @radius-' + item.name() + ';' + endOfLine + '}' + endOfLine;
				});
				//Right
				radius.forEach(function (item) {
					resultTheme += '.border-radius-right-' + item.name() + ', ' +
						'.radius-right-' + item.name() + '{' + endOfLine +
						'	border-bottom-right-radius: @radius-' + item.name() + ';' + endOfLine +
						'	border-top-right-radius: @radius-' + item.name() + ';' + endOfLine + '}' + endOfLine;
				});
				//Bottom
				radius.forEach(function (item) {
					resultTheme += '.border-radius-bottom-' + item.name() + ', ' +
						'.radius-bottom-' + item.name() + '{' + endOfLine +
						'	border-bottom-right-radius: @radius-' + item.name() + ';' + endOfLine +
						'	border-bottom-left-radius: @radius-' + item.name() + ';' + endOfLine + '}' + endOfLine;
				});
				//Top
				radius.forEach(function (item) {
					resultTheme += '.border-radius-top-' + item.name() + ', ' +
						'.radius-top-' + item.name() + '{' + endOfLine +
						'	border-top-right-radius: @radius-' + item.name() + ';' + endOfLine +
						'	border-top-left-radius: @radius-' + item.name() + ';' + endOfLine + '}' + endOfLine;
				});
			};

			var processBorderSpacing = function () {
				spacings.forEach(function (item) {
					resultTheme += '.border-spacing-' + item.name() +
						'{border-spacing: @spacing-' + item.name() + ';}' + endOfLine;
				});
			};

			var processBorderWidth = function () {
				borderSizes.forEach(function (item) {
					resultTheme += '.border-' + item.name() +
						'{border-width: @border-' + item.name() + ';}' + endOfLine;
				});

				borderSizes.forEach(function (item) {
					resultTheme += '.border-top-' + item.name() +
						'{border-top-width: @border-' + item.name() + ';}' + endOfLine;
				});

				borderSizes.forEach(function (item) {
					resultTheme += '.border-bottom-' + item.name() +
						'{border-bottom-width: @border-' + item.name() + ';}' + endOfLine;
				});

				borderSizes.forEach(function (item) {
					resultTheme += '.border-left-' + item.name() +
						'{border-left-width: @border-' + item.name() + ';}' + endOfLine;
				});

				borderSizes.forEach(function (item) {
					resultTheme += '.border-right-' + item.name() +
						'{border-right-width: @border-' + item.name() + ';}' + endOfLine;
				});
			};

			var processFonts = function () {
				fonts.forEach(function (item) {
					resultTheme += '.font-family-' + item.name() + ', .font-' + item.name() +
						'{font-family: @font-' + item.name() + ';}' + endOfLine;
				});
			};

			var processOpacity = function () {
				resultTheme += '#generate-opacity-classes (@suffix: ~\'\') {' + endOfLine;
				opacity.forEach(function (item) {
					resultTheme += '	.opacity-' + item.name() + '@{suffix}, .' + item.name() + '@{suffix}' +
						'{opacity: @' + item.name() + ';}' + endOfLine;
				});

				//Hover
				opacity.forEach(function (item) {
					resultTheme += '	.opacity-' + item.name() + '-on-hover@{suffix}, ' +
						'.' + item.name() + '-on-hover@{suffix}' +
						'{#hover({opacity: @' + item.name() + ';});}' + endOfLine;
				});

				//Selected
				opacity.forEach(function (item) {
					resultTheme += '	.opacity-' + item.name() + '-when-selected@{suffix}, ' +
						'.' + item.name() + '-when-selected@{suffix}' +
						'{&.is-selected {opacity: @' + item.name() + ';}}' + endOfLine;
				});
				resultTheme += '}' + endOfLine;
			};

			var processTopLeftRightBottom = function () {
				var axes = ['top', 'left', 'right', 'bottom'];

				resultTheme += '#generate-top-left-bottom-right-classes(@suffix: ~\'\') {' + endOfLine;

				axes.forEach(function (a) {
					//Spacing
					spacings.forEach(function (item) {
						resultTheme += '	.' + a + '-' + item.name() + '@{suffix}{' +
							a + ': @spacing-' + item.name() + ';}' + endOfLine;
					});

					//Dimensions
					dimensions.forEach(function (item) {
						resultTheme += '	.' + a + '-' + item.name() + '@{suffix}{' +
							a + ': @dimension-' + item.name() + ';}' + endOfLine;
					});

					//Minus
					spacings.forEach(function (item) {
						resultTheme += '	.' + a + '-minus-' + item.name() + '@{suffix}{' +
							a + ': -@spacing-' + item.name() + ';}' + endOfLine;
					});

					dimensions.forEach(function (item) {
						resultTheme += '	.' + a + '-minus-' + item.name() + '@{suffix}{' +
							a + ': -@dimension-' + item.name() + ';}' + endOfLine;
					});
				});

				resultTheme += '}' + endOfLine;
			};

			var processTransition = function () {
				durations.forEach(function (item) {
					resultTheme += '.transition-duration-' + item.name() +
						'{#transition-duration(@duration-' + item.name() + ');}' + endOfLine;
					//hover
					resultTheme += '.transition-duration-' + item.name() + '-on-hover' +
						'{#hover({#transition-duration(@duration-' + item.name() + ')});}' + endOfLine;

					//delay
					resultTheme += '.transition-delay-' + item.name() +
						'{#transition-delay(@duration-' + item.name() + ');}' + endOfLine;
					//delay-hover
					resultTheme += '.transition-delay-' + item.name() + '-on-hover' +
						'{#hover({#transition-delay(@duration-' + item.name() + ')});}' + endOfLine;
				});
			};

			var processEase = function () {
				ease.forEach(function (item) {
					resultTheme += '.transition-ease-' + item.name() +
						'{#transition-ease(@ease-' + item.name() + ');}' + endOfLine;

					resultTheme += '.transition-ease-' + item.name() + '-on-hover' +
						'{#hover({#transition-ease(@ease-' + item.name() + ')});}' + endOfLine;
				});
			};

			var processSquare = function () {
				spacings.forEach(function (item) {
					resultTheme += '.square-' + item.name() +
						'{width: @spacing-' + item.name() +
						'; height: @spacing-' + item.name() + ';}' +
						endOfLine;
				});
				dimensions.forEach(function (item) {
					resultTheme += '.square-' + item.name() +
						'{width: @dimension-' + item.name() +
						'; height: @dimension-' + item.name() + ';}' +
						endOfLine;
				});
			};

			processColors();
			processVars();

			processFlexBasis();
			processFontSize();
			processHeight();
			processLetterSpacing();
			processLineHeight();
			processMargin();
			processPadding();
			processWidth();
			processBorderRadius();
			processBorderSpacing();
			processBorderWidth();
			processFonts();
			processOpacity();
			processTopLeftRightBottom();
			processTransition();
			processEase();
			processSquare();


			//create final files
			//Writes vars
			fs.writeFile("css/theme/__vars" + themeName + ".less", resultVar, function (err) {
				if (err) {
					return console.log(err);
				}
			});

			//Write class
			fs.writeFile("css/theme/__theme" + themeName + ".less", resultTheme, function (err) {
				if (err) {
					return console.log(err);
				}
			});
		});
	});
};
