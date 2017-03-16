/**
 * @author Deux Huit Huit
 *
 * Dev panel
 */

(function ($, global, undefined) {
	
	var cssClasses = [
		'dev-js-panel',
		'fixed fill',
		'z-index-max',
		'bg-color-true-white color-dark',
		'flexbox flex-center'
	].join(' ');
	
	var panel = $('<div />').attr('class', cssClasses);

	var getImportantNodes = function () {
		return 'h1, h2, h3, h4, h5, h6, footer, header, section, article';
	};

	var getJsNodes = function (prefix) {
		return '[class^="' + prefix + '"], [class*=" ' + prefix +'"]';
	};

	var getNodeName = function (prefix, t) {
		return t[0].nodeName.toLowerCase();
	};

	var getClassList = function (prefix, t) {
		var pattern = new RegExp('^' + prefix);
		var classList = t.attr('class').split(' ');
		return _.filter(classList, function (clas) {
			return pattern.test(clas);
		}).join(' ');
	};

	var specialClassesFactory = function (params) {
		var prefix = params.prefix;
		var getValue = params.getValue;
		var getSelector = params.getSelector;

		return function (state) {
			var fx = !state ? 'removeAttr' : 'attr';
			$(getSelector(prefix)).each(function () {
				var t = $(this);
				t[fx]('data-' + prefix + 'class', getValue(prefix, t));
			});
		};
	};

	var specialCases = {
		'show-js-classes': specialClassesFactory({
			prefix: 'js-',
			getValue: getClassList,
			getSelector: getJsNodes
		}),
		'show-dom': specialClassesFactory({
			prefix: 'dom-',
			getValue: getNodeName,
			getSelector: getImportantNodes
		})
	};

	var initDevPanel = function () {
		var storage = global.AppStorage.session;
		var body = $('body');
		var inner = $('<div />');
		var devClasses = [
			'show-classes-on-hover',
			'show-names-on-hover',
			'show-classes',
			'show-classes-on-active',
			'show-names',
			'show-ga',
			'show-js-classes',
			'show-dom',
			'debug'
		];

		var checkboxes = _.map(devClasses, function (clas) {
			var storeKey = '-dev-' + clas;
			var state = !!storage.get(storeKey);
			var wrap = $('<div />').attr('class', 'margin-bottom-micro');
			var label = $('<label />');
			var checkbox = $('<input />').attr('type', 'checkbox').attr('class', 'margin-right-micro');
			checkbox.addClass('dev-js-chk-' + clas);

			wrap.append(label.append(checkbox).append(clas));
			checkbox.prop('checked', state);
			checkbox.on('change', function () {
				var isChecked = checkbox.prop('checked');
				var classFx = isChecked ? 'addClass' : 'removeClass';
				storage.set(storeKey, isChecked ? '1' : '');
				body[classFx](clas);

				if (!!specialCases[clas]) {
					specialCases[clas](isChecked);
				}
			});
			if (!!state) {
				body.addClass(clas);
			}

			if (!!specialCases[clas]) {
				specialCases[clas](state);
			}
			return wrap;
		});

		panel.append(inner);
		_.each(checkboxes, function (c) {
			inner.append(c);
		});
		var attached = false;

		$(document).on('keydown', function (e) {
			if (e.which === global.keys.escape) {
				var attFx = attached ? 'detach' : 'appendTo';
				panel[attFx](attached ? undefined : body);
				attached = !attached;
			}
		});
	};

	$(initDevPanel);

	//Add custom module to keep ui in sync with the framework state
	if (App && App.modules && App.modules.exports) {

		var refreshSpecialCases = function () {
			//
			if(panel.find('.dev-js-chk-show-dom:checked').length) {
				specialCases['show-dom'](true);
			}

			if(panel.find('.dev-js-chk-show-js-classes:checked').length) {
				specialCases['show-js-classes'](true);
			}
		};

		App.modules.exports('dev-panel', {
			actions: function () {
				return {
					page: {
						enter: refreshSpecialCases
						
					},
					articleChanger: {
						enter: refreshSpecialCases
					},
					infiniteScroll: {
						pageLoaded: refreshSpecialCases
					}
				};
			}
		});
	}
	
})(jQuery, window);
