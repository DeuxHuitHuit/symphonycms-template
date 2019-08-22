/**
 *  @author Deux Huit Huit
 *
 *  auto-modal
 */
(function ($, undefined) {
	
	'use strict';
	
	var site = $('#site');
	var bgTransitionModal = $('#bg-transition-modal');
	var FOCUSABLE = [
		'a[href]',
		'area[href]',
		'input:not([disabled])',
		'select:not([disabled])',
		'textarea:not([disabled])',
		'button:not([disabled])',
		'iframe, object, embed',
		'[tabindex], [contenteditable]'
	].join(',');
	var o = {
		selectorToggle: '.js-modal-toggle'
	};
	
	var focusable = function (modal) {
		return $(FOCUSABLE).filter(function () {
			var t = $(this);
			// element not in modal or is background
			return !t.closest(modal).length || t.is(bgTransitionModal);
		});
	};
	
	var restoreFocusable = function (i, e) {
		var t = $(e);
		var tab = t.data('acc-tabindex');
		if (tab) {
			t.attr('tabindex', tab);
		} else {
			t.removeAttr('tabindex');
		}
	};
	
	var keyUp = function (e) {
		if (e.which === window.keys.escape) {
			$(this).find(o.selectorToggle).click();
		}
	};
	
	var removeFocusable = function (i, e) {
		var t = $(e);
		var tab = t.attr('tabindex');
		if (tab === '-1') {
			return;
		}
		t.data('acc-tabindex', tab || undefined);
		t.attr('tabindex', '-1');
	};
	
	var a11y = function (modal) {
		if (!modal || !modal.length) {
			return;
		}
		// Disable focus for accessibility
		focusable(modal).each(removeFocusable);
		// Re enable focus for accessibility
		modal.find(FOCUSABLE).each(restoreFocusable);
		$(document).on('keyup', keyUp);
	};
	
	var a11yReset = function (modal) {
		if (!modal || !modal.length) {
			return;
		}
		// Re enable focus for accessibility
		focusable(modal).each(restoreFocusable);
		// Disable focus for accessibility
		modal.find(FOCUSABLE).each(restoreFocusable);
		$(document).off('keyup', keyUp);
	};
	
	var toggleModal = function (item, isOn, callback) {
		if (!!callback) {
			$.removeFromTransition(item.selector);
			item.transitionEnd(function () {
				App.callback(callback);
			}, item.selector);
		}
		
		App.modules.notify('changeState.update', {
			item: item,
			state: 'visible',
			action: isOn ? 'on' : 'off'
		});
		
		if (isOn) {
			a11y(item);
		} else {
			a11yReset(item);
		}
	};
	
	var onPrepareModal = function (key, data) {
		if (!!data && !!$(data.item).length) {
			var item = $(data.item);
			
			item.addClass('noanim');
			App.modules.notify('changeState.update', {
				item: item,
				state: 'visible',
				action: 'off'
			});
			item.height();
			item.removeClass('noanim');
		}
	};
	
	var onShowModal = function (key, data) {
		if (!!data && !!$(data.item).length) {
			var item = $(data.item);
			onPrepareModal('', data);
			toggleModal(item, true, data.callback);
		}
	};
	
	var onHideModal = function (key, data) {
		if (!!data && !!$(data.item).length) {
			var item = $(data.item);
			toggleModal(item, false, data.callback);
		}
	};
	
	var toggleBg = function (isVisible, callback) {
		if (!!callback) {
			$.removeFromTransition(bgTransitionModal.selector);
			bgTransitionModal.transitionEnd(function () {
				App.callback(callback);
			}, bgTransitionModal.selector);
		}
		App.modules.notify('changeState.update', {
			item: bgTransitionModal,
			state: 'visible',
			action: isVisible ? 'on' : 'off'
		});
	};

	var showBg = function (key, data) {
		var callback = !!data ? data.callback : $.noop;
		toggleBg(true, callback);
	};

	var hideBg = function (key, data) {
		var callback = !!data ? data.callback : $.noop;
		toggleBg(false, callback);
	};

	var init = function () {
		// init a11y for modal that is already opened on load
		// how to know which modal to do?
		var page = $('.page');
		var modal = page.find('.js-modal-page');
		
		if (modal.hasClass('is-visible')) {
			a11y(modal);
		}
	};
	
	var actions = function () {
		return {
			modal: {
				show: onShowModal,
				hide: onHideModal,
				prepare: onPrepareModal,
				showBg: showBg,
				hideBg: hideBg
			}
		};
	};
	
	App.modules.exports('auto-modal', {
		actions: actions,
		init: init
	});
	
})(jQuery);