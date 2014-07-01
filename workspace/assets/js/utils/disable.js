/**
 * @author Deux Huit Huit
 *
 * Disable/Enable plugin
 *
 */
(function ($, undefined) {
	
	'use strict';
	
	var DISABLED = 'disabled';

	$.fn.disable = function () {
		$(this).attr(DISABLED, DISABLED).addClass(DISABLED);
	};
	
	$.fn.enable = function () {
		$(this).removeAttr(DISABLED).removeClass(DISABLED);
	};
	
})(jQuery);