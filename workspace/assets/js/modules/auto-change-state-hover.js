/**
 *  @author Deux Huit Huit
 *
 *  Auto change state hover
 */
(function ($, undefined) {
	
	'use strict';
	var win = $(window);
	var site = $('#site');
	var BUTTON_SELECTOR = '.js-change-state-hover';
	var BUTTON_STATE_ATTR = 'data-change-state-hover';
	var BUTTON_TARGET_ATTR = 'data-change-state-hover-target';
	var BUTTON_TARGET_COMMON_ANCESTOR_ATTR = 'data-change-state-hover-target-common-ancestor';

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

	var mouseEnterLeave = function (e) {
		var t = $(this);

		var target = t.attr(BUTTON_TARGET_ATTR);
		var state = t.attr(BUTTON_STATE_ATTR);

		var item = t;

		//Valid needed info
		if (state) {

			item = findTargetItemIfAvailable(item, target);

			//Process item algo
			App.modules.notify('changeState.update', {
				item: item,
				state: state,
				action: 'toggle'
			});
		}

		return window.pd(e);
	};

	var init = function () {
		//Attach click handler
		site.on('mouseenter', BUTTON_SELECTOR, mouseEnterLeave);
		site.on('mouseleave', BUTTON_SELECTOR, mouseEnterLeave);
	};
	
	App.modules.exports('auto-change-state-on-hover', {
		init: init
	});
	
})(jQuery);
