/**
 * @author Deux Huit Huit
 */
 
(function ($, global, undefined) {

	'use strict';
	
	$.jitImage.defaults.forceCssResize = false;
	$.jitImage.defaults.parallelLoadingLimit = 3;
	$.jitImage.defaults.nonVisibleDelay = 0;
	
	window.raf = window.requestAnimationFrame || window.mozRequestAnimationFrame ||  
		window.webkitRequestAnimationFrame || window.msRequestAnimationFrame ||
		window.oRequestAnimationFrame || function (fx) { window.setTimeout(fx, 16); };
		
	window.craf = window.cancelAnimationFrame || window.webkitCancelRequestAnimationFrame ||
				window.mozCancelRequestAnimationFrame || window.oCancelRequestAnimationFrame ||
				window.msCancelRequestAnimationFrame  || window.clearTimeout,
	
	window.preventNextClick = function (e) {
		var t = $(this);
		var href = t.attr('href');
		if (!!href) {
			return !/^(https?|mailto|skype|tel|ftps?)/im.test(href);
		}
		return true;
	};
	
})(jQuery, jQuery(window));