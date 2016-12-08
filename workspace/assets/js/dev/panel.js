/**
 * @author Deux Huit Huit
 *
 * Dev panel
 */

(function ($, global, undefined) {
	
	var initDevPanel = function () {
		var storage = global.AppStorage.session;
		var body = $('body');
		var panel = $('<div />').attr('class', 'fixed fill z-index-max bg-color-white flexbox flex-center');
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
		var getClassList = function (t) {
			var pattern = new RegExp('^' + prefix);
			var classList = t.attr('class').split(' ');
			return _.filter(classList, function (clas) {
				return pattern.test(clas);
			}).join(' ');
		};
		var getNodeName = function (t) {
			return t[0].nodeName.toLowerCase();
		};
		var getImportantNodes = function () {
			return 'h1, h2, h3, h4, h5, h6, footer, header, section, article';
		};
		var getJsNodes = function (prefix) {
			return '[class^="' + prefix + '"], [class*=" ' + prefix +'"]';
		};
		var specialClassesFactory = function (params) {
			var prefix = params.prefix;
			var getValue = params.getValue;
			var getSelector = params.getSelector;
			return function (state) {
				var fx = !state ? 'removeAttr' : 'attr';
				$(getSelector(prefix)).each(function () {
					var t = $(this);
					t[fx]('data-' + prefix + 'class', getValue(t));
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
		var checkboxes = _.map(devClasses, function (clas) {
			var storeKey = '-dev-' + clas;
			var state = !!storage.get(storeKey);
			var wrap = $('<div />').attr('class', 'margin-bottom-micro');
			var label = $('<label />');
			var checkbox = $('<input />').attr('type', 'checkbox').attr('class', 'margin-right-micro');
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
	
})(jQuery, window);
