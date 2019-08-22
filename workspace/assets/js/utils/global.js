/**
 * @author Deux Huit Huit
 */

(function ($, global, undefined) {
	'use strict';
	
	$.jitImage.defaults.forceCssResize = false;
	$.jitImage.defaults.parallelLoadingLimit = 3;
	$.jitImage.defaults.nonVisibleDelay = 0;
	$.jitImage.defaults.forceEvenSize = true;
	$.jitImage.defaults.fetchSmallerImages = false;
	
	$.jitImage.defaults.format = function (urlFormat, o, size) {
		var pattern = /\$([0-9])+\/([0-9]+)/;
		if (pattern.test(urlFormat.url)) {
			var captures = pattern.exec(urlFormat.url);
			var ratio = captures[1] / captures[2] || 1;
			urlFormat.url = urlFormat.url
				.replace(pattern, ~~(size.width * ratio * o.devicePixelRatio));
		}
	};
	
	global.raf = window.requestAnimationFrame || window.mozRequestAnimationFrame ||
		window.webkitRequestAnimationFrame || window.msRequestAnimationFrame ||
		window.oRequestAnimationFrame || function (fx) {
		window.setTimeout(fx, 16);
	};
	
	global.craf = window.cancelAnimationFrame || window.webkitCancelRequestAnimationFrame ||
		window.mozCancelRequestAnimationFrame || window.oCancelRequestAnimationFrame ||
		window.msCancelRequestAnimationFrame || window.clearTimeout;
	
	// default easing support
	$.easing.def = ($.mobile ? 'linear' : 'easeOutQuad');
})(jQuery, window);

/**
 * Cheap modrnzr
 */
(function ($, global, undefined) {
	'use strict';
	// add mobile css class to html
	$.each([
			'iphone',
			'ipad',
			'ios',
			'mobile',
			'android',
			'phone',
			'tablet',
			'touch',
			'chrome',
			'safari',
			'internetexplorer',
			'firefox',
			'edge'
		], function (i, c) {
		if (!!global.App.device[c]) {
			$('html').addClass(c);
		}
	});
})(jQuery, window);

/**
 * polyfill jQuery animation engine
 */
(function ($, global, undefined) {
	'use strict';
	if (!!$.fn.velocity) {
		$.fn.animate = $.fn.velocity;
		$.fn.fadeTo = function (duration, opacity, complete) {
			var display = (opacity === 0) ? 'none' : '';
			return this.velocity({opacity: opacity}, {
				duration: duration,
				complete: complete,
				display: display
			});
		};
		$.fn.fadeIn = function (duration, complete) {
			return this.velocity('fadeIn', { duration: duration, complete: complete });
		};
		$.fn.fadeOut = function (duration, complete) {
			return this.velocity('fadeOut', { duration: duration, complete: complete });
		};
		$.fn.slideUp = function (duration, complete) {
			return this.velocity('slideUp', { duration: duration, complete: complete });
		};
		$.fn.slideDown = function (duration, complete) {
			return this.velocity('slideDown', { duration: duration, complete: complete });
		};
		$.fn.stop = function (clearQueue, jumpToEnd) {
			var t = this.velocity('stop', clearQueue);
			if (jumpToEnd) {
				this.velocity('finish');
			}
			return t;
		};
		$.scrollTo = function (target, duration, options) {
			var win = $(window);
			if (!target) {
				return win;
			}
			if (typeof duration === 'number') {
				duration = {
					duration: duration
				};
			}
			if (!!options) {
				options.duration = duration.duration;
			}
			if (!options && typeof duration === 'object') {
				options = duration;
			}
			target.velocity('scroll', options);
			return win;
		};
	}
})(jQuery, window);

/**
 * Utils
 */
(function ($, global, undefined) {
	'use strict';
	global.rgb2hex = function (rgb) {
		var hex = function (x) {
			return ('0' + parseInt(x, 10).toString(16)).slice(-2);
		};
		var hexa = rgb.match(/^rgb\((\d+),\s*(\d+),\s*(\d+)\)$/);
		if (!hexa) {
			return rgb;
		}
		return hex(hexa[1]) + hex(hexa[2]) + hex(hexa[3]);
	};
	
	global.remToPx = function (value) {
		return value * parseInt($('html').css('fontSize'), 10);
	};
	
	global.mediaQueryMinWidth = function (width) {
		return window.matchMedia('(min-width: ' + width + 'px)').matches;
	};
	
	global.mediaQueryMaxWidth = function (width) {
		return window.matchMedia('(max-width: ' + width + 'px)').matches;
	};
	
	global.calculatedScrollbarWidth = function () {
		var ctn = $('<div>').css({
			position: 'absolute',
			display: 'block',
			bottom: '100%',
			right: '100%',
			width: '50px',
			height: '50px'
		});
		var div = $('<div>').css({
			width: '100%'
		});
		
		$('body').append(ctn.append(div));
		
		var w1 = div.width();
		ctn.css({
			overflowY: 'scroll'
		});
		div.css({
			width: '0%'
		}).height();
		div.css({
			width: '100%'
		}).height();
		var w2 = div.width();
		ctn.remove();
		if (w2 === 100 && w1 === 100) {
			return undefined;
		}
		return Math.round(w1 - w2);
	};
	global.scrollbarWidth = function () {
		var sbw = global.calculatedScrollbarWidth();
		var memoizedScrollBarWidth = function () {
			return sbw;
		};

		if (sbw === undefined) {
			return 0;
		}
		
		global.scrollbarWidth = memoizedScrollBarWidth;
		return memoizedScrollBarWidth();
	};
})(jQuery, window);
