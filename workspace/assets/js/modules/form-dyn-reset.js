(function ($) {

	'use strict';

	var opts = {
		delay: 5000
	};

	var reset = function (key, data) {
		setTimeout(function () {
			data.form.reset();
			App.mediator.notify('formDyn.reset', {
				form: data.form,
				ctn: data.ctn,
				data: data.data
			});
		}, opts.delay);
	};

	var actions = function () {
		return {
			formDyn: {
				error: reset,
				success: reset
			}
		};
	};

	App.modules.exports('form-dyn-reset', {
		actions: actions
	});

})(jQuery);
