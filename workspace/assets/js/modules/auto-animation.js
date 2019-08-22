/**
 * Auto animation
 *
 * Simple module to init the animation and pause them when they are not in the viewport.
 *
 * @author Deux Huit Huit
 * @uses animation.js (framework.js's component)
 *
 * Basic usage:
 *
 * <div class="js-auto-aniamtion"
 * 		data-animation-path="/my-beautiful-path/sick-animation.json"></div>
 */
(function ($) {

	'use strict';

	var win = $(window);
	var scope = $();

	var CAN_PLAY_KEY = 'auto-animation-can-play';

	var sels = {
		item: '.js-auto-animation'
	};

	var animations = [];

	var initAll = function () {
		scope.find(sels.item).each(function () {
			var t = $(this);
			var comp = App.components.create('animation');
			comp.init(t);
			animations.push(comp);
		});
	};

	var onScroll = function () {
		var currentScroll = win.scrollTop();
		var winHeight = win.height();
		$.each(animations, function (index, comp) {
			var t = comp.get();

			if (!!t.length) {
				var offset = t.offset().top;
				var height = t.outerHeight();
				var notHigherThanViewport = currentScroll < offset + height;
				var notLowerThanViewport = currentScroll + winHeight > offset;

				t.data(CAN_PLAY_KEY, notHigherThanViewport && notLowerThanViewport);
			}
		});
	};

	var onPostScroll = function () {
		$.each(animations, function (index, comp) {
			var t = comp.get();
			if (!!t.length) {
				(!!t.data(CAN_PLAY_KEY) ? comp.play : comp.pause)();
			}
		});
	};

	var onResize = function () {
		onScroll();
		onPostScroll();
	};

	var destroyAll = function () {
		$.each(animations, function (index, comp) {
			comp.destroy();
		});
	};

	var onPageLeave = function (key, data) {
		if (!!data.canRemove) {
			destroyAll();
		}
	};

	var onArticleLeave = function () {
		destroyAll();
	};

	var onPageEnter = function (key, data) {
		scope = $(data.page.key());
		initAll();
	};

	var onArticleEnter = function (key, data) {
		scope = $(data.article);
		initAll();
	};

	var actions = function () {
		return {
			page: {
				enter: onPageEnter,
				leave: onPageLeave
			},
			articleChanger: {
				enter: onArticleEnter,
				leaving: onArticleLeave
			},
			site: {
				scroll: onScroll,
				postscroll: onPostScroll,
				resize: onResize
			}
		};
	};

	App.modules.exports('auto-animation', {
		actions: actions
	});

})(jQuery);
