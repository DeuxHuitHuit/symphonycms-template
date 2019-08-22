/**
 * @author Deux Huit Huit
 *
 * Dynamic Forms CTRL
 */
(function ($, global, undefined) {

	'use strict';
	var forms = [];
	var page = $('.page');
	var btnSubmit = $();
	var preFooter = $('.js-site-prefooter');

	var sels = {
		form: '.js-form-dyn',
		formElem: '.js-form',
		formSubmit: '.js-form-btn-submit',
		formRecaptcha: '.js-recaptcha'
	};

	var opts = {
		handlers: {
			ignoreErrors: [
				'mailchimp',
				'pingback',
				'email'
			]
		}
	};

	var onRecaptchaUpdated = function (key, data) {
		$('[name="g-recaptcha-response"]').disable();
		if (!data.lastTarget.attr('data-prevent-submit')) {
			data.lastTarget.closest(sels.formElem).submit();
		}
	};
	
	var resetRecaptcha = function (recaptchaId) {
		try {
			if (!!window.grecaptcha) {
				window.grecaptcha.reset(recaptchaId);
			}
		} catch (e) {
			App.log(e);
		}
	};
	
	var resetSingleForm = function (elem) {
		var recaptchaId = parseInt(elem.find(sels.formRecaptcha).data('recaptcha-id'));
		var comForm = elem.data('component');
		
		if (!!comForm) {
			App.mediator.notify('formDyn.reset', {
				ctn: elem,
				form: comForm
			});
			App.modules.notify('autoChangeStateInputs.reset', {
				scope: elem
			});

			comForm.enable(true);
			comForm.reset();
			btnSubmit.removeAttr('disabled');
			resetRecaptcha(recaptchaId);
		}
	};
	
	var resetForms = function (scope) {
		scope.find(sels.form).each(function () {
			resetSingleForm($(this));
		});
	};

	var onFormSuccess = function (key, data) {
		App.mediator.notify('changeState.update', {
			item: data.ctn,
			state: 'success',
			action: 'on'
		});
	};

	var onFormError = function (key, data) {
		App.mediator.notify('changeState.update', {
			item: data.ctn,
			state: 'error',
			action: 'on'
		});
	};
	
	var onFormSubmitClick = function (e) {
		window.pd(e);
		var t = $(this);
		var elemFormDyn = t.closest(sels.form);
		var recaptchaId = parseInt(elemFormDyn.find(sels.formRecaptcha).data('recaptcha-id'));
		var com = elemFormDyn.data('component');
		
		//validate all fields
		com.validate();
		
		if (com.isValid() && recaptchaId >= 0) {
			window.grecaptcha.execute(recaptchaId);
		}
	};

	var initForms = function (scope) {
		scope.find(sels.form).each(function (index, elem) {
			elem = $(elem);
			var formElem = elem.find(sels.formElem);
			var form = App.components.create('form', {
				root: elem
			});

			form.init({
				enableOnComplete: false,
				post: {
					submitting: function () {
						App.mediator.notify('formDyn.submitting', {
							ctn: elem,
							form: form
						});
					},
					complete: function () {
						App.mediator.notify('formDyn.complete', {
							ctn: elem,
							form: form
						});
						App.mediator.notify('recaptcha.forceUpdate');
					},
					error: function (result) {
						App.mediator.notify('formDyn.error', {
							ctn: elem,
							form: form,
							data: $()
						});
						App.mediator.notify('recaptcha.forceUpdate', {
							ctn: elem,
							form: form
						});
					},
					success: function (data) {
						try {
							data = $(data);
						} catch (e) {
							App.log({fx: 'error', args: e});
							data = $();
						}

						if (data.find('form-dyn result').attr('success') === 'yes') {
							var handlersErrors = false;
							data.find('form-dyn handlers > *').each(function () {
								var t = $(this);
								var name = t.get(0).nodeName.toLowerCase();
								var isIgnored = _.indexOf(opts.handlers.ignoreErrors, name) >= 0;
								if (t.attr('success') && t.attr('success') === 'no' && !isIgnored) {
									handlersErrors = true;
									return false;
								}
							});

							if (!handlersErrors) {
								App.mediator.notify('formDyn.success', {
									ctn: elem,
									form: form,
									data: data
								});
							} else {
								App.mediator.notify('formDyn.handleError', {
									ctn: elem,
									form: form,
									data: data
								});
							}

						} else {
							App.mediator.notify('formDyn.error', {
								ctn: elem,
								form: form,
								data: data
							});
						}
						App.mediator.notify('recaptcha.forceUpdate', {
							ctn: elem,
							form: form
						});
					}
				},
				fieldsOptions: {
					rules: {
						date: {
							datetime: {
								dateOnly: true,
								message: formElem.attr('data-msg-date-invalid'),
								notValid: formElem.attr('data-msg-date-invalid')
							}
						},
						document: {
							format: {
								message: formElem.attr('data-msg-doc-invalid')
							}
						},
						image: {
							format: {
								message: formElem.attr('data-msg-img-invalid')
							}
						}
					},
					onFocus: function (data) {
						App.mediator.notify('formDyn.inputFocus', _.assign({
							ctn: elem,
							form: form
						}, data));
					},
					onBlur: function (data) {
						App.mediator.notify('formDyn.inputBlur', _.assign({
							ctn: elem,
							form: form
						}, data));
					},
					onKeyup: function (data) {
						App.mediator.notify('formDyn.keyup', _.assign({
							ctn: elem,
							form: form
						}, data));
					},
					onChangeOrInput: function (data) {
						App.mediator.notify('formDyn.inputChange', _.assign({
							ctn: elem,
							form: form
						}, data));
					},
					onInited: function (data) {
						//Attach Date picker if class is present
						if (data.field.find('.js-date-picker').length) {
							var it = data.field.find('.js-date-picker');
							var dateFormat = $('html').attr('lang') == 'fr' ?
								'dd-mm-yy' :
								'mm-dd-yy';
							it.datepicker();
							it.datepicker('option', 'dateFormat', dateFormat);
						}
					}
				},
				onError: function (data) {
					App.mediator.notify('formDyn.validationError', {
						results: data.results,
						ctn: elem,
						form: form
					});
				},
				onBeforePost: function (e) {
					var cancel = false;
					App.mediator.notify('recaptcha.execute', {
						ctn: elem,
						form: form
					}, function (key, ret) {
						cancel = ret;
					});
					return cancel;
				}
			});
			elem.data('component', form);
			App.mediator.notify('formDyn.init', {
				form: form,
				ctn: elem
			});
			elem.data('component', form);
			
			btnSubmit = elem.find(sels.formSubmit);
			btnSubmit.on($.click, onFormSubmitClick);
			forms.push(form);
		});
	};

	var onPageEnter = function (key, data) {
		page = $(data.page.key());
		initForms(page);
	};

	var onArticleEnter = function (key, data) {
		var article = $(data.article);
		initForms(article);
	};
	
	var onPageLeave = function (key, data) {
		page = $(data.page.key());
		resetForms(page);
		resetForms(preFooter);
	};

	var onArticleLeave = function (key, data) {
		var article = $(data.article);
		resetForms(article);
		resetForms(preFooter);
	};
	
	var init = function () {
		initForms(preFooter);
	};

	var actions = function () {
		return {
			page: {
				enter: onPageEnter,
				leave: onPageLeave
			},
			articleChanger: {
				enter: onArticleEnter,
				leave: onArticleLeave
			},
			recaptcha: {
				updated: onRecaptchaUpdated
			},
			formDyn: {
				success: onFormSuccess,
				error: onFormError,
			}
		};
	};

	App.modules.exports('form-dyn', {
		init: init,
		actions: actions
	});

})(jQuery, window);
