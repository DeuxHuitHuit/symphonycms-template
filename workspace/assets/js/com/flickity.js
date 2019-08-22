/**
 * @author Deux Huit Huit
 *
 * Flickity component
 *
 * @uses jQuery.fn.data()
 *  The used keys are:
 *   1. `acc-tabindex` used to store the tabindex
 *   2. `flickity` used to store all the data-flickity-* options
 *
 * @requires https://cdnjs.cloudflare.com/ajax/libs/flickity/2.1.1/flickity.pkgd.min.js"
 */

(function ($, win, undefined) {

	'use strict';

	App.components.exports('flickity', function (options) {
		var slider = $();
		var scope = $();
		var isInited = false;

		var defaultOptions = {
			sliderCtn: '.js-flickity-slider-ctn',
			cellSelector: '.js-flickity-cell',
			navBtnSelector: '.js-flickity-nav-btn',

			abortedClass: 'is-flickity-cancelled',
			initedClass: 'is-flickity-inited',
			selectedClass: 'is-selected',
			seenClass: 'is-seen',

			dataAttrPrefix: 'flickity',
			
			aborted: null //Aborted callback
		};

		var o = $.extend({}, defaultOptions, options);

		var flickityOptions = function () {
			var opts = {};
			var dataAttrPattern = new RegExp('^' + o.dataAttrPrefix);
			opts = _.reduce(slider.data(), function (memo, value, key) {
				if (dataAttrPattern.test(key)) {
					if (_.isObject(value)) {
						return memo;
					}
					var parsedKey = key.replace(dataAttrPattern, '');
					var validKey = '';
					if (!!parsedKey && !!parsedKey[0]) {
						validKey = parsedKey[0].toLowerCase();
						if (parsedKey.length >= 2) {
							validKey += parsedKey.substr(1);
						}
						memo[validKey] = value;
					}
				}
				return memo;
			}, {});
			return $.extend({}, o, opts);
		};

		var resize = function () {
			slider.flickity('resize');
		};

		var getCurrentSlide = function () {
			var d = slider.data('flickity');
			if (!d) {
				return $();
			}
			return slider.find(o.cellSelector).eq(d.selectedIndex);
		};

		var setActiveSlideSeen = function () {
			getCurrentSlide().addClass(o.seenClass);
			slider.find(o.cellSelector + '.' + o.seenClass).each(function () {
				slider.find('.flickity-page-dots li').eq($(this).index()).addClass(o.seenClass);
			});
		};
		
		var sliderPlay = function () {
			slider.flickity('playPlayer');
			slider.attr('tabindex', slider.data('acc-tabindex') || '0');
		};
		
		var sliderPause = function () {
			slider.flickity('pausePlayer');
		};
		
		var init = function (item, s) {
			slider = item;
			scope = s;

			if (slider.find(o.cellSelector).length > 1) {

				var flickOptions = flickityOptions();

				slider.flickity(flickOptions);
				slider.flickity('resize');
				slider.addClass(o.initedClass);
				isInited = true;
				// Make dots accessible with the keyboard
				slider.find('.flickity-page-dots li').attr('tabindex', '0').keydown(function (e) {
					if (e.which === window.keys.enter) {
						var t = $(this);
						slider.flickity('select', t.index());
						t.focus();
					}
				});
				//set slide aria-label on corresponding page dot
				slider.find('.flickity-page-dots li').each(function (i) {
					var t = $(this);
					var ariaLabel = slider.find(o.cellSelector).eq(i).attr('aria-label');
					if (!!ariaLabel) {
						t.attr('aria-label', ariaLabel);
					}
				});
				// Limit focus to active slide's content only
				slider.on('blur', function () {
					slider.data('acc-tabindex', slider.attr('tabindex'));
					slider.removeAttr('tabindex');
				})
				.on('settle.flickity', function () {
					var curSlide = getCurrentSlide();
					slider.find(o.cellSelector).removeAttr('tabindex');
					slider.find('button, a').attr('tabindex', '-1');
					curSlide.add(curSlide.find('button, a')).attr('tabindex', '0');
					
					// restart autoplay slider after user action for touch devices
					if (!!flickOptions.autoPlay &&
						!!flickOptions.restartAutoplayOnMouseleave &&
						$.mobile) {
						sliderPlay();
					}
				});
				if (!!flickOptions.pageDots) {
					slider.on('settle.flickity', setActiveSlideSeen);
				}
				slider.find('img[data-src-format]').jitImage();
				if (!!flickOptions.pauseOnFocus) {
					// Make sure it is focusable
					var tab = slider.attr('tabindex');
					if (!tab) {
						slider.attr('tabindex', '0');
					}
					slider.on('focus', function (e) {
						slider.flickity('pausePlayer');
					}).on('focus', '*', function (e) {
						slider.flickity('pausePlayer');
					});
				}
				
				if (!!flickOptions.pauseOnInit) {
					slider.flickity('pausePlayer');
				}
				
				// restart autoplay slider after user action for desktop devices
				if (!!flickOptions.autoPlay &&
					!!flickOptions.restartAutoplayOnMouseleave &&
					!$.mobile) {
					slider.on('mouseleave', sliderPlay);
				}
				
				App.callback(o.inited);
			} else if (slider.find(o.cellSelector).length === 1) {
				slider.addClass(o.abortedClass);
				slider.find(o.cellSelector).addClass(o.selectedClass);
				App.callback(o.aborted);
			} else {
				App.log('No flickity found or multiple flickity in the scope');
				App.callback(o.aborted);
			}
		};

		var destroy = function () {
			if (slider.hasClass(o.initedClass) && slider.closest('body').length > 0) {
				slider.flickity('destroy');
				slider.removeClass(o.initedClass);
				slider.off('settle.flickity', setActiveSlideSeen);
				slider.off('mouseleave', sliderPlay);
				slider.off('focus').off('focus', '*');
				slider.off('blur').attr('tabindex', slider.data('acc-tabindex') || '0');
				
				slider = $();
				App.callback(o.destroyed);
			}
		};
		
		var unpausePlayer = function () {
			slider.flickity('unpausePlayer');
		};

		return {
			init: init,
			resize: resize,
			destroy: destroy,
			isInited: function () {
				return isInited;
			},
			unpause: unpausePlayer,
			pause: sliderPause
		};
	});

})(jQuery, jQuery(window));
