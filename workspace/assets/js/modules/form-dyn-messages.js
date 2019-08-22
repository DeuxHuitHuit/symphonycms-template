(function ($) {

	'use strict';

	var html = $('html');

	var sels = {
		ctn: '.js-form-dyn-messages-ctn',
		message: '.js-form-dyn-message',
		template: '.js-form-dyn-message-template'
	};

	var resetMessage = function (msg) {
		if (!!msg.length) {
			App.modules.notify('changeState.update', {
				item: msg,
				state: 'visible',
				action: 'off'
			});
			msg.empty();
		}
	};

	var showMessage = function (form, fx) {
		var ctn = form.find(sels.ctn);
		var template = ctn.find(sels.template).filter('[data-fx="' + fx + '"]');
		var msg = ctn.find(sels.message);

		if (!!msg.length) {
			resetMessage(msg);
			msg.append($(template.html()));
			msg.outerHeight();
			App.modules.notify('changeState.update', {
				item: msg,
				state: 'visible',
				action: 'on'
			});
			html.velocity('scroll', {
				offset: msg.offset().top + 'px',
				mobileHA: false
			});
		}
	};

	var onSuccess = function (key, data) {
		showMessage(data.ctn, 'success');
	};

	var onError = function (key, data) {
		showMessage(data.ctn, 'error');
	};

	var onHandleError = function (key, data) {
		showMessage(data.ctn, 'error');
	};

	var onReset = function (key, data) {
		data.ctn.find(sels.ctn).each(function () {
			resetMessage($(this).find(sels.message));
		});
	};

	var actions = function () {
		return {
			formDyn: {
				success: onSuccess,
				error: onError,
				handleError: onHandleError,
				reset: onReset
			}
		};
	};

	App.modules.exports('form-dyn-messages', {
		actions: actions
	});

})(jQuery);
