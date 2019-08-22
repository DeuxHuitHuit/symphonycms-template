/**
 * Form
 * @author Deux Huit Huit
 * @requires form-field.js
 */
(function ($, win, undefined) {

	'use strict';

	var defaults = {
		root: 'body',
		container: '.js-form',
		fields: '.js-form-field',
		fieldsGroupSelector: '.js-form-field-group',
		fieldsOptions: {
			
		},
		onSubmit: null,
		doSubmit: null,
		onValid: null,
		onError: null,
		disableOnSubmit: true,
		focusOnError: true,
		post: {
			
		},
		gaCat: 'conversion',
		gaLabel: 'form'
	};

	App.components.exports('form', function form (options) {
		var ctn;
		var fields = [];
		var isSubmitting = false;
		options = $.extend(true, {}, defaults, options);

		var track = function (action, label, value) {
			var cat = ctn.attr('data-ga-form-cat') || options.gaCat;
			label = label || ctn.attr('data-ga-form-label') || options.gaLabel;
			$.sendEvent(cat, action, label, value);
		};

		var reset = function () {
			ctn.get(0).reset();
			_.each(fields, function (f) {
				f.reset();
			});
		};

		var preview = function () {
			_.each(fields, function (f) {
				f.preview();
			});
		};

		var validate = function () {
			return _.map(fields, function (f) {
				return f.validate();
			});
		};

		var isValid = function (results) {
			results = results || validate();
			return (!!results.length && !_.some(results)) || !results.length;
		};

		var validateGroup = function (group) {
			var groupFields = [];

			$.each(fields, function () {
				if (this.group().is(group)) {
					groupFields.push(this);
				}
			});

			return isValid(_.map(groupFields, function (f) {
				return f.validate();
			}));
		};

		var enable = function (enabl) {
			_.each(fields, function (f) {
				f.enable(enabl);
			});
		};

		var post = function () {
			var data = {};
			var processData = !window.FormData;

			if (!!isSubmitting) {
				return;
			}
	
			if (!processData) {
				data = new FormData(ctn.get(0));
			} else {
				$.each(ctn.serializeArray(), function () {
					data[this.name] = this.value;
				});
			}

			isSubmitting = true;

			App.modules.notify('changeState.update', {
				item: ctn,
				state: 'submitting',
				action: 'on'
			});

			App.callback(options.post.submitting);

			App.loader.load({
				url: ctn.attr('action'),
				type: ctn.attr('method') || 'POST',
				data: data,
				processData: processData,
				contentType: false,
				dataType: 'text',
				error: options.post.error,
				success: options.post.success,
				complete: function () {
					App.callback(options.post.complete);
					isSubmitting = false;
					App.modules.notify('changeState.update', {
						item: ctn,
						state: 'submitting',
						action: 'off'
					});
					if (options.disableOnSubmit) {
						enable(true);
					}
				}
			});
		};

		var onSubmit = function (e) {
			var results = validate();
			App.callback(options.onSubmit);
			
			if (isValid(results)) {
				App.callback(options.onValid);
				var cancel = App.callback(options.onBeforePost, [e]);
				if (cancel === true) {
					return win.pd(e);
				}

				if (!!options.post) {
					post();
				} else {
					App.callback(options.doSubmit);
				}
				
				if (options.disableOnSubmit) {
					enable(false);
				}
				
				if (!!options.post || !!options.doSubmit) {
					return win.pd(e);
				}
			} else {
				App.callback(options.onError, {
					results: results
				});
				if (options.focusOnError) {
					results = _.filter(results);
					if (!!results.length) {
						results[0].field.getCtn().velocity('scroll', {
							mobileHA: false,
							offset: '-100px',
							complete: function () {
								results[0].field.focus();
							}
						});
					}
				}
				
				return win.pd(e);
			}
		};

		var initField = function (i, t) {
			t = $(t);
			var field = App.components.create('form-field', options.fieldsOptions);

			field.init({
				container: t,
				group: t.closest(options.fieldsGroupSelector)
			});

			fields.push(field);
		};

		var init = function (o) {
			options = $.extend(true, options, o);
			options.root = $(options.root);
			ctn = options.root.find(options.container);

			if (!win.validate) {
				App.log({
					fx: 'error',
					me: 'Component Form',
					args: 'Validate.js not found. Initialization stoped.'
				});
				return;
			}

			ctn.find(options.fields).each(initField);
			ctn.submit(onSubmit);

			if (!!options.focusOnFirst) {
				setTimeout(function () {
					fields[0].focus();
				}, 100);
			}

			// Default validators message
			win.validate.validators.presence.options = {
				message: ctn.attr('data-msg-required')
			};
			win.validate.validators.email.options = {
				message: ctn.attr('data-msg-email-invalid') || ctn.attr('data-msg-invalid')
			};
			win.validate.validators.format.options = {
				message: ctn.attr('data-msg-invalid')
			};
			win.validate.validators.numericality.options = {
				message: ctn.attr('data-msg-invalid')
			};
			win.validate.validators.url.options = {
				message: ctn.attr('data-msg-invalid')
			};
			var dateFormat = 'DD-MM-YYYY';

			if (!!window.moment) {
				win.validate.extend(win.validate.validators.datetime, {
					// must return a millisecond timestamp
					// also used to parse earlier and latest options
					parse: function (value, options) {
						if (!value) {
							return NaN;
						}
						if (win.moment.isMoment(value)) {
							return +value;
						}
						if (/[^\d-\/]/.test(value)) {
							return NaN;
						}
						var date = win.moment.utc(value, dateFormat);
						if (!date.isValid()) {
							return NaN;
						}
						// coerce to ms timestamp
						return +date;
					},
					// must return a string
					format: function (value, options) {
						if (!win.moment.isMoment(value)) {
							value = win.moment(value);
						}
						return value.format(dateFormat);
					},
					message: ctn.attr('data-msg-date-invalid') || ctn.attr('data-msg-invalid'),
					notValid: ctn.attr('data-msg-date-invalid') || ctn.attr('data-msg-invalid'),
					tooEarly: ctn.attr('data-msg-date-too-early') || ctn.attr('data-msg-invalid'),
					tooLate: ctn.attr('data-msg-date-too-late') || ctn.attr('data-msg-invalid')
				});
			}
		};

		return {
			init: init,
			enable: enable,
			reset: reset,
			preview: preview,
			post: post,
			validate: validate,
			validateGroup: validateGroup,
			isValid: isValid,
			track: track,
			getContainer: function () {
				return ctn;
			},
			getFields: function () {
				return fields;
			},
			getOptions: function () {
				return options;
			}
		};
	});

})(jQuery, window);
