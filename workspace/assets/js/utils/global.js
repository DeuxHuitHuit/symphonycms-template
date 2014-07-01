/**
 * @author Deux Huit Huit
 */
 
(function ($, global, undefined) {

	'use strict';
	
	$.jitImage.defaults.forceCssResize = false;
	$.jitImage.defaults.parallelLoadingLimit = 3;
	$.jitImage.defaults.nonVisibleDelay = 0;
	
	global.raf = window.requestAnimationFrame || window.mozRequestAnimationFrame ||  
		window.webkitRequestAnimationFrame || window.msRequestAnimationFrame ||
		window.oRequestAnimationFrame || function (fx) { window.setTimeout(fx, 16); };
		
	global.craf = window.cancelAnimationFrame || window.webkitCancelRequestAnimationFrame ||
				window.mozCancelRequestAnimationFrame || window.oCancelRequestAnimationFrame ||
				window.msCancelRequestAnimationFrame  || window.clearTimeout,
	
	global.preventNextClick = function (e) {
		var t = $(this);
		var href = t.attr('href');
		if (!!href) {
			return !/^(https?|mailto|skype|tel|ftps?)/im.test(href);
		}
		return true;
	};
	
})(jQuery, window);