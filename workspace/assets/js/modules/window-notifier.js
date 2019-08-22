/**
 *  @author Deux Huit Huit
 *
 *  Window Notifier
 */
(function ($, undefined) {
	
	'use strict';
	var win = $(window);
	var doc = $(document);
	
	var notify = function (key, e) {
		App.mediator.notify('site.' + key, {event: e});
	};
	
	var resizeHandler = function (e) {
		notify('resize', e);
	};
	
	var orientationHandler = function (e) {
		notify('orientation', e);
		resizeHandler();
	};
	
	var scrollHandler = function (e) {
		notify('scroll', e);
		notify('postscroll', e);
	};
	
	var loadHandler = function (e) {
		notify('loaded', e);
	};
	
	var visibilityHandler = function (e) {
		var state = document.visibilityState || document.webkitVisibilityState || 'visible';
		notify('visibilitychange', e, state);
	};
	
	var readyHandler = function (e) {
		notify('ready', e);
	};
	
	var init = function () {
		$(readyHandler);
		win
			.load(loadHandler)
			.scroll(scrollHandler)
			.on('orientationchange', orientationHandler);
		if (!$.ios) {
			win.resize(resizeHandler);
		}
		doc
			.on('visibilitychange webkitvisibilitychange', visibilityHandler);
	};

	var requestScrollTop = function (key, data) {
		if (!data || !data.animated) {
			win.scrollTop(0);
			scrollHandler();
		}
	};

	var actions = function () {
		return {
			window: {
				scrollTop: requestScrollTop
			}
		};
	};
	
	var WindowNotifier = App.modules.exports('windowNotifier', {
		init: init,
		actions: actions
	});
	
})(jQuery);
