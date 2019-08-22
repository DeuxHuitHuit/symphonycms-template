/**
 *  @author Deux Huit Huit
 *
 *  Auto scroll to id on load
 *
 *	Will scroll to a specific id after: site is loaded, page is entered (page.enter)
 *	or article is entered (articleChanger.enter)
 */
(function ($, undefined) {
	
	'use strict';
	var win = $(window);
	var html = $('html');
	var site = $('#site');
	var isFirstload = true;
	
	var scrollToIdFromUrl = function (key, data) {
		var h = window.location.href.split('#').length > 1 ?
			window.location.href.split('#')[1] : '';
		var target = !!h ? site.find('#' + h) : $();
		var duration = !!data && !!data.noDuration ? 0 : 500;
		
		if (!!target.length) {
			html.velocity('scroll', {
				duration: duration,
				offset: target.offset().top + 'px',
				mobileHA: false
			});
		}
	};
	
	var onPageEnter = function (key, data) {
		// on first load, the scroll will be done by site-Loader.finishing
		if (isFirstload) {
			isFirstload = false;
			return;
		}
		
		scrollToIdFromUrl();
	};
	
	var actions = function () {
		return {
			page: {
				enter: onPageEnter
			},
			articleChanger: {
				enter: scrollToIdFromUrl
			},
			siteLoader: {
				finishing: scrollToIdFromUrl
			}
		};
	};
	
	App.modules.exports('auto-scroll-to-id-on-load', {
		actions: actions
	});
	
})(jQuery);
