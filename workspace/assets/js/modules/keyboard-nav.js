/**
 *  @author Deux Huit Huit
 *
 * Keyboard navigation:
 *  Provides a way to only show outline when the user is using the keyboard.
 *
 */
(function ($, undefined) {
	
	'use strict';
	var doc = $(document);
	var CLASS = 'keyboard-nav';
	var KD = 'keydown';
	var TI = 'tabindex';
	var root = $('html');

	var keydown = function (e) {
		if (e.which === window.App.device.keys.tab) {
			root.addClass(CLASS);
			// This ignore is needed beacause of the module method structure. We should fix this.
			/* jshint ignore:start */
			doc.off(KD, keydown).one('click', click);
			/* jshint ignore:end */
			App.mediator.notify('keyboardNav.enabled');
		}
	};

	var click = function (e) {
		root.removeClass(CLASS);
		doc.on(KD, keydown);
		App.mediator.notify('keyboardNav.disabled');
	};

	var init = function () {
		doc.on(KD, keydown);
	};
	
	var toggleTabIndex = function (key, data) {
		if (!data || !data.item) {
			return;
		}
		if (!data.item.is('.js-focusable')) {
			return;
		}
		var stack = data.item.add(data.item.find('.js-focusable-child'));
		if (data.trigger === 'after') {
			stack.removeAttr(TI);
		} else {
			stack.attr(TI, '-1');
		}
	};
	
	var actions = function () {
		return {
			autoToggleClassOnScroll: {
				executed: toggleTabIndex
			}
		};
	};
	
	App.modules.exports('keyboard-nav', {
		init: init,
		actions: actions
	});
	
})(jQuery);
