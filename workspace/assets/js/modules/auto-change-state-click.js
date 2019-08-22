/**
 *  @author Deux Huit Huit
 *
 *  Auto change state click
 */
(function ($, undefined) {
	
	'use strict';
	var win = $(window);
	var site = $('#site');
	var BUTTON_SELECTOR = '.js-change-state-click';
	var BUTTON_TARGET_ATTR = 'data-change-state-click-target';
	var BUTTON_STATE_ATTR = 'data-change-state-click';
	var BUTTON_ACTION_ATTR = 'data-change-state-action';
	var BUTTON_MAX_WIDTH_ATTR = 'data-change-state-max-width';
	var BUTTON_MIN_WIDTH_ATTR = 'data-change-state-min-width';
	var BUTTON_PREVENT_DEFAULT_ATTR = 'data-change-state-click-prevent-default';
	var BUTTON_TARGET_COMMON_ANCESTOR_ATTR = 'data-change-state-click-target-common-ancestor';

	
	var findTargetItemIfAvailable = function (item, target) {
		//Find target if present
		if (target) {
			var scope = item;
			var commonAncestor = item.attr(BUTTON_TARGET_COMMON_ANCESTOR_ATTR);

			if (commonAncestor) {
				scope = item.closest(commonAncestor);
			}
			return scope.find(target);
		} else {
			return item;
		}
	};

	var buttonClicked = function (e) {
		var t = $(this);

		var target = t.attr(BUTTON_TARGET_ATTR);
		var state = t.attr(BUTTON_STATE_ATTR);
		var action = t.attr(BUTTON_ACTION_ATTR);
		var minWidth = t.attr(BUTTON_MIN_WIDTH_ATTR);
		var maxWidth = t.attr(BUTTON_MAX_WIDTH_ATTR);

		var item = t;
		var isMinWidthValid = (!!minWidth && window.mediaQueryMinWidth(minWidth)) || !minWidth;
		var isMaxWidthValid = (!!maxWidth && window.mediaQueryMaxWidth(maxWidth)) || !maxWidth;

		//Valid needed info
		if (state && action && isMinWidthValid && isMaxWidthValid) {

			item = findTargetItemIfAvailable(item, target);

			//Process item algo
			App.modules.notify('changeState.update', {
				item: item,
				state: state,
				action: action
			});
			
			if (t.filter('[' + BUTTON_PREVENT_DEFAULT_ATTR + ']').length) {
				return window.pd(e);
			}
		}
	};

	var init = function () {
		//Attach click handler
		site.on(App.device.events.click, BUTTON_SELECTOR, buttonClicked);
	};
	
	App.modules.exports('auto-change-state-click', {
		init: init
	});
	
})(jQuery);
