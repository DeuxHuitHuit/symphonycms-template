(function ($) {

	'use strict';

	var onSubmitting = function (key, data) {
		App.mediator.notify('changeState.update', {
			item: data.ctn,
			state: 'loading',
			action: 'on'
		});
	};

	var onComplete = function (key, data) {
		App.mediator.notify('changeState.update', {
			item: data.ctn,
			state: 'loading',
			action: 'off'
		});
		App.mediator.notify('changeState.update', {
			item: data.ctn,
			state: 'completed',
			action: 'on'
		});
	};
	
	var onReset = function (key, data) {
		App.mediator.notify('changeState.update', {
			item: data.ctn,
			state: 'loading',
			action: 'off'
		});
		App.mediator.notify('changeState.update', {
			item: data.ctn,
			state: 'completed',
			action: 'off'
		});
		App.mediator.notify('changeState.update', {
			item: data.ctn,
			state: 'success',
			action: 'off'
		});
		App.mediator.notify('changeState.update', {
			item: data.ctn,
			state: 'error',
			action: 'off'
		});
	};

	var actions = function () {
		return {
			formDyn: {
				submitting: onSubmitting,
				complete: onComplete,
				reset: onReset
			}
		};
	};

	App.modules.exports('form-dyn-loading', {
		actions: actions
	});

})(jQuery);
