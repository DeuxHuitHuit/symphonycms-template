/**
 * @author Deux Huit Huit
 *
 */
(function ($, undefined) {
	
	'use strict';

	var win = $(window);
	var site = $('#site');
	var isPopState = false;
	var popData = null;

	var onPopState = function (key, data) {
		popData = data;
		isPopState = true;
	};

	var updateScroll = function (key, data) {
		if (data.state.scrollPos) {
			win.scrollTop(data.state.scrollPos);
			App.mediator.notify('site.scroll');
			App.mediator.notify('site.postscroll');
		}
	};

	var onPageEnter = function () {
		if (isPopState) {
			isPopState = false;
			updateScroll(null, popData);
		}
	};

	var init = function () {
		if (history.scrollRestoration) {
			history.scrollRestoration = 'manual';
		}

		site.on($.click, 'a[href^=\'#\']', function (e) {
			var newUrl = window.location.pathname + window.location.search;
			newUrl += $(this).attr('href');
			App.mediator.goto(newUrl);
			return window.pd(e);
		});
	};

	var actions = function () {
		return {
			history: {
				popState: onPopState
			},
			page: {
				enter: onPageEnter
			},
			articleChanger: {
				enter: onPageEnter
			}
		};
	};
	
	App.modules.exports('siteScrollKeeper', {
		init: init,
		actions: actions
	});
	
})(jQuery);
