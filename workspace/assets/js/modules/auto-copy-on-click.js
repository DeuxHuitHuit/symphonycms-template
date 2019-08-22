/**
 *  @author Deux Huit Huit
 *
 *  Click on copyBtn to copy what's inside the input toCopy.
 *  Put data-message-delay on copyBtn
 */
(function ($, undefined) {
	
	'use strict';

	var site = $('#site');
	var sels = {
		toCopy: '.js-text-to-copy',
		copyBtn: '.js-copy-on-click-btn',
		message: '.js-confirm-message'
	};
	var timer = null;

	var onClick = function () {
		var t = $(this);
		var closest = t.closest('.js-copy-ctn');
		var message = closest.find(sels.message);
		var delay = parseInt(t.attr('data-message-delay'), 10) || 1000;
		var toCopy = closest.find(sels.toCopy);
		var copyCount = toCopy.length;

		var copy = function (textToCopy) {
			textToCopy.select();
			document.execCommand('copy');

			App.modules.notify('changeState.update', {
				item: message,
				state: 'visible',
				action: 'on'
			});

			clearTimeout(timer);
			timer = setTimeout(function () {
				App.modules.notify('changeState.update', {
					item: message,
					state: 'visible',
					action: 'off'
				});
			}, delay);
		};

		if (copyCount === 0) {
			App.log('No item found to copy text from');
			return;
		} else if (copyCount === 1) {
			copy(toCopy);
		} else {
			App.log('Multiple items found for copy, using the first one');
			copy(toCopy.eq(0));
		}
	};

	var init = function () {
		site.on(App.device.events.click, sels.copyBtn, onClick);
	};
	
	App.modules.exports('auto-copy-on-click', {
		init: init
	});
	
})(jQuery);
