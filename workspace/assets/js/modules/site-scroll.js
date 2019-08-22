/**
 *  @author Deux Huit Huit
 *
 *  Site scroll
 *      Site scrollBar add-remove with scrollbar size fix algo
 *      (pad, right, margin)
 *
 *  Use .js-fix-scroll
 *      -pad : Add/remove padding-right scrollbar size fix
 *      -right : Add/remove right scrollbar size fix
 *      -margin : Add/remove margin-right scrollbar size fix

 *  Strategies
 *      You can pass a strategy in the data object when notifying site addScroll/removeScroll
 *      - hideOverflow (default): Add css to limit the overflow of html and body
 *      - preventEvent: Blocks mousewheel, swipe, and some keys events to disable
 *        scrolling without changing the css

 *  Scrolling zone
 *      For the preventEvent strategy, it is possible to have a scrolling zone
 *      where the events wont be block if the zone is scrollable
 */

(function ($, undefined) {

	'use strict';
	
	var win = $(window);
	var html = $('html');

	var selectors = {
		scrollingZone: '.js-scrolling-zone',
		scrollingZoneContent: '.js-scrolling-zone-content'
	};

	var fixScroll = function (value) {
		$('.js-fix-scroll-pad').css({paddingRight: value || ''});
		$('.js-fix-scroll-right').css({right: value || ''});
		$('.js-fix-scroll-margin').css({marginRight: value || ''});
	};

	var keys = {
		ArrowDown: true,
		ArrowUp: true,
		End: true,
		Home: true,
		PageDown: true,
		PageUp: true
	};

	var getWheelDirection = function (e) {
		var delta = null;
		var direction = false;

		if (e.wheelDelta) {
			delta = e.wheelDelta / 60;
		} else if (e.detail) {
			delta = -e.detail / 2;
		}
		if (delta !== null) {
			direction = delta > 0 ? 'up' : 'down';
		}
		return direction;
	};

	var preventDefault = function (e) {
		var scrollingZone = $(e.target).closest(selectors.scrollingZone);
		var shouldPrevent = false;
		
		if (scrollingZone.length > 0) {
			var scrollingZoneHeight = scrollingZone.height() || 0;
			var scrollingZoneContent = scrollingZone.find(selectors.scrollingZoneContent);
			var scrollingZoneContentHeight = scrollingZoneContent.height() || 0;
			var scrollingStartOffset = scrollingZone.offset().top;
			var scrollingDistanceTotal = scrollingZoneContentHeight - scrollingZoneHeight;
			var scrollingDistance = -(scrollingZoneContent.offset().top - scrollingStartOffset);
			var direction = getWheelDirection(e);

			if (scrollingDistanceTotal <= 0 ||
				direction === 'down' && scrollingDistance === scrollingDistanceTotal ||
				direction === 'up' && scrollingDistance === 0) {
				shouldPrevent = true;
			}
		}
		else {
			shouldPrevent = true;
		}
		if (shouldPrevent) {
			e = e || window.event;
			if (e.preventDefault) {
				e.preventDefault();
			}
			e.returnValue = false;
		}
	};

	var preventDefaultForScrollKeys = function (e) {
		if (keys[e.key]) {
			preventDefault(e);
			return false;
		}
	};

	var strategies = {
		preventEvent: {
			add: function () {
				if (window.removeEventListener) {
					window.removeEventListener('DOMMouseScroll', preventDefault, false);
				}
				window.onmousewheel = document.onmousewheel = null;
				window.onwheel = null;
				window.ontouchmove = null;
				document.onkeydown = null;
			},
			remove: function () {
				if (window.addEventListener) {// older FF
					window.addEventListener('DOMMouseScroll', preventDefault, false);
				}
				window.onwheel = preventDefault; // modern standard
				window.onmousewheel = document.onmousewheel = preventDefault; // older browsers, IE
				window.ontouchmove = preventDefault; // mobile
				document.onkeydown = preventDefaultForScrollKeys;
			}
		},
		hideOverflow: {
			add: function () {
				html.removeClass('no-scroll');
				fixScroll(0);
			},
			remove: function () {
				if (!html.hasClass('no-scroll')) {
					var x = win.width();
					html.addClass('no-scroll');
					fixScroll(win.width() - x);
				}
			}
		}
	};

	var getStrategy = function (data) {
		return data && data.strategy ? data.strategy : 'hideOverflow';
	};

	var addScroll = function (key, data) {
		strategies[getStrategy(data)].add();
	};

	var removeScroll = function (key, data) {
		strategies[getStrategy(data)].remove();
	};

	var actions = function () {
		return {
			site: {
				removeScroll: removeScroll,
				addScroll: addScroll
			}
		};
	};

	App.modules.exports('siteScroll', {
		actions: actions
	});
	
})(jQuery);
