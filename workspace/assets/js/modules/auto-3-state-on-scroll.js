/**
 *  @author Deux Huit Huit
 *
 *  Auto toggle class on scroll 3 state
 
 	<add class="js-auto-3-state-on-scroll" /> REQUIRED
 		Class that represents the element that will have its states changed.
 		
 	<add data-auto-3-state-trigger="" /> REQUIRED
 		Selector for the trigger element. The offsetTop of this element
		will be used as the top reference.
 		If no trigger bottom is provided, the offsetBottom (offsetTop + outerHeight)
		of this element will be used.
 		
 	<add data-auto-3-state-trigger-common-ancestor="" /> OPTIONNAL
 		Selector For common ancestor between item and trigger
 		
 	<add data-auto-3-state-trigger-bottom="" /> OPTIONNAL
 		Selector for the trigger element.
		The offsetBottom (offsetTop + outerHeight) of this element will be
		used as the bottom reference.
 		If no trigger bottom is provided, the trigger will used as the trigger bottom.
 		
 	<add data-auto-3-state-trigger-bottom-common-ancestor="" /> OPTIONNAL
 		Selector For common ancestor between item and trigger bottom
 		
 	<add data-auto-3-state-scroll-offset-top="" /> OPTIONNAL
 		Selector for the elements that offset the scroll value for the top reference only.
 		
 	STATE ATTRIBUTES
 	<add data-initial-state-add-class="" />
 	<add data-initial-state-rem-class="" />
 	
 	<add data-middle-state-add-class="" />
 	<add data-middle-state-rem-class="" />
 	
 	<add data-final-state-add-class="" />
 	<add data-final-state-rem-class="" />
 */
(function ($, undefined) {
	
	'use strict';
	var win = $(window);
	var site = $('#site');
	var scrollTimer = 0;
	var resizeTimer = 0;
	var curY = 0;
	
	var SELECTOR = '.js-auto-3-state-on-scroll';
	var ATTR_TRIGGER = 'data-auto-3-state-trigger';
	var ATTR_TRIGGER_COMMON_ANCESTOR = 'data-auto-3-state-trigger-common-ancestor';
	var ATTR_TRIGGER_BOTTOM = 'data-auto-3-state-trigger-bottom';
	var ATTR_TRIGGER_BOTTOM_COMMON_ANCESTOR = 'data-auto-3-state-trigger-bottom-common-ancestor';
	var ATTR_OFFSET_TOP = 'data-auto-3-state-scroll-offset-top';
	
	var DATA_KEY = '3-state-fx';
	
	var elements = $();
	
	var findTargetItemIfAvailable = function (item, target, commonAncestorAttr) {
		//Find target if present
		if (target) {
			var scope = site;
			var commonAncestor = item.attr(commonAncestorAttr);

			if (commonAncestor) {
				scope = item.closest(commonAncestor);
			}
			return scope.find(target);
		} else {
			return item;
		}
	};
	
	var refreshElements = function () {
		elements = site.find(SELECTOR + '[' + ATTR_TRIGGER + ']');
	};

	var updateData = function () {
		elements.each(function () {
			var t = $(this);
			var fx = t.data(DATA_KEY);
			
			t.removeData(DATA_KEY);
			App.callback(fx);
		});
	};
	
	var getOffsetTop = function (item) {
		var offset = 0;
		var targets = site.find(item.attr(ATTR_OFFSET_TOP));
		
		targets.each(function () {
			offset += Math.floor($(this).outerHeight());
		});
		
		return offset;
	};

	var getData = function () {
		curY = Math.floor(win.scrollTop());
		
		elements.each(function () {
			var t = $(this);
			var height = Math.floor(t.outerHeight());
			var top = Math.floor(t.offset().top);
			var bot = Math.floor(top + height);
			
			// trigger
			var trigger = findTargetItemIfAvailable(
				t,
				t.attr(ATTR_TRIGGER),
				ATTR_TRIGGER_COMMON_ANCESTOR
			);
			
			if (!!trigger.length) {
				var tTop = Math.floor(trigger.offset().top);
				
				// bottom trigger
				var triggerBottom = !!t.attr(ATTR_TRIGGER_BOTTOM) ?
					findTargetItemIfAvailable(
						t,
						t.attr(ATTR_TRIGGER_BOTTOM),
						ATTR_TRIGGER_BOTTOM_COMMON_ANCESTOR
					) : trigger;
				var tBot = Math.floor(triggerBottom.offset().top + triggerBottom.outerHeight());
				
				if (height < tBot - tTop && tBot > tTop) {
					var isMiddle = tTop <= curY + getOffsetTop(t);
					var isFinal = tBot - curY <= height;
					var fx;
					
					if (!!isFinal) {
						fx = function () {
							App.modules.notify('changeState.update', {
								item: t,
								state: 'initial',
								action: 'off'
							});
							App.modules.notify('changeState.update', {
								item: t,
								state: 'middle',
								action: 'off'
							});
							
							App.modules.notify('changeState.update', {
								item: t,
								state: 'final',
								action: 'on'
							});
						};
					} else if (!!isMiddle) {
						fx = function () {
							App.modules.notify('changeState.update', {
								item: t,
								state: 'initial',
								action: 'off'
							});
							App.modules.notify('changeState.update', {
								item: t,
								state: 'final',
								action: 'off'
							});
							
							App.modules.notify('changeState.update', {
								item: t,
								state: 'middle',
								action: 'on'
							});
						};
					} else {
						fx = function () {
							App.modules.notify('changeState.update', {
								item: t,
								state: 'final',
								action: 'off'
							});
							App.modules.notify('changeState.update', {
								item: t,
								state: 'middle',
								action: 'off'
							});
							
							App.modules.notify('changeState.update', {
								item: t,
								state: 'initial',
								action: 'on'
							});
						};
					}
					
					t.data(DATA_KEY, fx);
				}
			}
		});
	};

	// SCROLL
	var onScroll = function () {
		getData();
	};

	var onPostscroll = function () {
		window.craf(scrollTimer);

		scrollTimer = window.raf(function () {
			updateData();
		});
	};

	var onResize = function () {
		window.craf(resizeTimer);

		resizeTimer = window.raf(function () {
			onScroll();
			onPostscroll();
		});
	};

	// PAGE / ARTICLE CHANGER EVENTS
	var onPageEnter = function (key, data) {
		refreshElements();
		onResize();
	};

	var onArticleEnter = function () {
		refreshElements();
		onResize();
	};
	
	var init = function () {
		
	};
	
	var actions = function () {
		return {
			site: {
				scroll: onScroll,
				postscroll: onPostscroll,
				resize: onResize
			},
			page: {
				enter: onPageEnter
			},
			articleChanger: {
				enter: onArticleEnter
			}
		};
	};
	
	App.modules.exports('auto-3-state-on-scroll', {
		init: init,
		actions: actions
	});
	
})(jQuery);
