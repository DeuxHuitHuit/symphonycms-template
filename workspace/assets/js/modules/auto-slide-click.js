/**
 * @author Deux Huit Huit
 *
 * auto slide on click
 *
 * - Container: optionnal. If present, when opening an item, it will close the
 *	 other items present in the container, just like an accordeon.
 *	 <add class="js-auto-slide-click" />
 *
 * - Item: container of the trigger and slide
 *	 <add class="js-auto-slide-click-item" />
 *	 <add data-auto-slide-click-max-width="" />
 *	 <add data-auto-slide-click-min-width="" />
 *
 * - Trigger: toggle The slide. A change-state toggle is done on the trigger.
 *	 When state is "on", it will notify onToggleOn to close the other items if
 *	 <add class="js-auto-slide-click-trigger" />
 *	 <add data-auto-slide-click-state-add-class="" />
 *	 <add data-auto-slide-click-state-rem-class="" />
 *	 <add data-auto-slide-click-state-notify-on="autoSlideClick.toggleOn" />
 *
 * - Slide: Item that slides up and down
 *	 <add class="js-auto-slide-click-slide" />
 *	 <add data-auto-slide-click-state-add-class="" />
 *	 <add data-auto-slide-click-state-rem-class="" />
 */
(function ($, global, undefined) {
	
	'use strict';
	
	var win = $(window);
	var html = $('html');
	
	var CTN_SELECTOR = '.js-auto-slide-click';
	var ITEM_SELECTOR = '.js-auto-slide-click-item';
	var TRIGGER_SELECTOR = '.js-auto-slide-click-trigger';
	var SLIDE_SELECTOR = '.js-auto-slide-click-slide';
	
	var STATE = 'auto-slide-click';
	
	var TRIGGER_MAX_WIDTH_ATTR = 'data-auto-slide-click-max-width';
	var TRIGGER_MIN_WIDTH_ATTR = 'data-auto-slide-click-min-width';
	
	// close other when opening one
	var onToggleOn = function (key, data) {
		var curItem = data.item.closest(ITEM_SELECTOR);
		var ctn = data.item.closest(CTN_SELECTOR);
		var items = ctn.find(ITEM_SELECTOR).not(curItem);
		
		items.each(function () {
			var t = $(this);
			var trigger = t.find(TRIGGER_SELECTOR);
			var slide = t.find(SLIDE_SELECTOR);
			
			//trigger
			App.modules.notify('changeState.update', {
				item: trigger,
				state: STATE,
				action: 'off'
			});
			
			//tiroir
			App.modules.notify('slide.update', {
				item: slide,
				state: STATE,
				action: 'up'
			});
		});
	};
	
	var updateSlideState = function (key, data) {
		var item = data.trigger.closest(ITEM_SELECTOR);
		var slide = item.find(SLIDE_SELECTOR);

		var minWidth = item.attr(TRIGGER_MIN_WIDTH_ATTR);
		var maxWidth = item.attr(TRIGGER_MAX_WIDTH_ATTR);
		var isMinWidthValid = (!!minWidth && window.mediaQueryMinWidth(minWidth)) || !minWidth;
		var isMaxWidthValid = (!!maxWidth && window.mediaQueryMaxWidth(maxWidth)) || !maxWidth;
		
		if (isMinWidthValid && isMaxWidthValid) {
			//Process item algo
			App.modules.notify('slide.update', {
				item: slide,
				state: STATE,
				action: data.slideAction
			});
			
			App.modules.notify('changeState.update', {
				item: data.trigger,
				state: STATE,
				action: data.triggerAction
			});
		}
	};
	
	var onTriggerClick = function (e) {
		var t = $(this);
		
		updateSlideState('', {
			trigger: t,
			triggerAction: 'toggle',
			slideAction: 'toggle'
		});
		
		return window.pd(e);
	};
	
	var init = function () {
		$('#site').on(App.device.events.click, TRIGGER_SELECTOR, onTriggerClick);
	};
	
	var actions = function () {
		return {
			autoSlideClick: {
				toggleOn: onToggleOn,
				updateSlideState: updateSlideState
			}
		};
	};
	
	var autoAccordion = App.modules.exports('auto-slide-click', {
		init: init,
		actions: actions
	});
	
})(jQuery, window);
