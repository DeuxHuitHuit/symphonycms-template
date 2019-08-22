/**
 *  @author Deux Huit Huit
 *
 *  Auto Tracked Page module
 *
 */
(function ($, global, undefined) {

	'use strict';
	
	var tracker = App.components.create('checkpoint-event', {
		category: 'Lecture',
		checkPoints: [25, 50, 75, 90, 100]
	});
	var win = $(window);
	var winH = win.height();
	var body = $('body');
	var bodyH = body.height();
	var scrollH = bodyH - winH;
	var DISABLED_CLASS = 'js-tracked-scroll-disabled';
	
	var onResize = function () {
		winH = win.height();
		bodyH = body.height();
		scrollH = bodyH - winH;
	};
	
	var onEnter = function (key, data) {
		var root = !!data.page ? $(data.page.key()) : data.article ? $(data.article) : $();
		tracker.init();
		setTimeout(onResize, 100);
		if (root.hasClass(DISABLED_CLASS)) {
			tracker.disable();
		} else {
			tracker.enable();
		}
	};
	
	var onLeave = function () {
		tracker.disable();
		tracker.reset();
	};
	
	var onScroll = function () {
		if (scrollH > 0) {
			tracker.track(win.scrollTop() / scrollH * 100);
		}
	};
	
	var actions = function () {
		return {
			page: {
				enter: onEnter,
				leave: onLeave
			},
			site: {
				scroll: onScroll,
				resize: onResize,
				loaded: onResize
			},
			articleChanger: {
				enter: onEnter
			}
		};
	};
	
	App.modules.exports('auto-tracked-scroll', {
		actions: actions
	});
	
})(jQuery, window);
