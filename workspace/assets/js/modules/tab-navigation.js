/**
 *  @author Deux Huit Huit
 *
 */
(function ($, undefined) {

	'use strict';
	
	var tabReset = $('.js-tab-reset');
	var lastFocus = $();
	
	var resetTab = function (item) {
		item.focus();
	};
	
	var onPageEnter = function (key, data) {
		var p = $(data.page.key());
		
		if (p.hasClass('js-tab-reset-alt')) {
			lastFocus = $(document.activeElement);
			resetTab(p);
		} else {
			if (lastFocus.length && lastFocus.is(':visible')) {
				resetTab(lastFocus);
			} else {
				resetTab(tabReset);
			}
			lastFocus = $();
		}
	};
	
	var actions = function () {
		return {
			page: {
				enter: onPageEnter
			}
		};
	};

	App.modules.exports('tab-navigation', {
		actions: actions
	});
	
})(jQuery);
