/**
 *  @author Deux Huit Huit
 *
 *  TransitionEnd notify
 */
(function ($, undefined) {
	
	'use strict';
	var win = $(window);

	var onCancel = function (key, data) {
		if (data && data.item) {
			$.removeFromTransition(data.item.selector);
		}
	};

	var onAttach = function (key, data) {
		if (data && data.item) {
			var notifyEnd = data.item.attr('data-transitionEnd-notify');
			if (notifyEnd && notifyEnd.length) {
				data.item.transitionEnd(function () {
					App.mediator.notify(notifyEnd, {item: data.item});
				});
			}
		}
	};
	
	var actions = function () {
		return {
			transitionEndNotify: {
				attach: onAttach,
				cancel: onCancel
			}
		};
	};
	
	App.modules.exports('transitionEnd-notify', {
		actions: actions
	});
	
})(jQuery);
