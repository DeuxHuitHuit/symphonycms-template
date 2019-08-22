/**
 *  @author Deux Huit Huit
 *
 *  Auto print
 *
 */
(function ($, undefined) {
	
	'use strict';
	
	var site = $('#site');
	
	var init = function () {
		site.on(App.device.events.click, '.js-auto-print', function (e) {
			// print is sync, so we need to delay it to get stats before hand
			setTimeout(window.print, 10);
			return window.pd(e);
		});
	};
	
	App.modules.exports('auto-print', {
		init: init
	});
	
})(jQuery);
