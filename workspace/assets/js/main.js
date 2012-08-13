/******************************
 * @author Deux Huit Huit
 ******************************/

/**
 * Globals
 */
(function ($, undefined) {
	"use strict"; // Yeah, we are that crazy
	
	// Bad "device detection" (ua sniffing...)
	var ua = !!window.navigator && !!navigator.userAgent ? navigator.userAgent : false;
	
	$.unsupported = !$.browser || ($.browser.msie && parseInt($.browser.version, 10) < 9);
	
	$.ipad = !!ua && ua.match(/iPad/i); 
	
	$.iphone = !!ua && (ua.match(/iPhone/i)) || (ua.match(/iPod/i));
	
	$.ios = $.ipad || $.iphone;
	
	$.android = !!ua && (ua.match(/Android/i));
	
	$.mobile = $.ios || $.android || 
				(!!ua && (ua.match(/mobile/i) || ua.match(/phone/i))) || 
				!!document.location.toString().match(/.+\?mobile$/i);
	
	// viewport support
	if ($.ios) {
		$('head').append('<meta name="viewport" content="width=1024, user-scalable=no" />');
	}
	
	// mobile support
	if ($.mobile) {
		$('html').addClass('mobile');
	}
	if ($.android) {
		$('html').addClass('android');
	}
	if ($.iphone) {
		$('html').addClass('iphone');
	}
	if ($.ios) {
		$('html').addClass('ios');
	}
	
	// console support
	if (!window.console) {
		window.console = {};
		window.console.log = window.console.warn = window.console.error = window.console.info = $.noop;
	}
	
	// hsitory support
	if (!window.history.pushState) {
		window.history.pushState = $.noop;
	}
	
	// easing support
	$.easing.def = ($.mobile ? 'linear' : 'easeInOutQuad');
	
	// CSS 3 support
	//$.fn.animate.defaults.leaveTransforms = true;
	
	// prevent default macro
	window.pd = function (e) {
		if (!!e && $.isFunction(e.preventDefault)) {
			e.preventDefault();
		}
		return false;
	};
	
})(jQuery);

