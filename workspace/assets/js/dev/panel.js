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
			'debug'
		];
		var checkboxes = _.map(devClasses, function (clas) {
			var storeKey = '-dev-' + clas;
			var wrap = $('<div />').attr('class', 'margin-bottom-micro');
			var label = $('<label />');
			var checkbox = $('<input />').attr('type', 'checkbox').attr('class', 'margin-right-micro');
			wrap.append(label.append(checkbox).append(clas));
			checkbox.prop('checked', !!storage.get(storeKey));
			checkbox.on('change', function () {
				var isChecked = checkbox.prop('checked');
				var classFx = isChecked ? 'addClass' : 'removeClass';
				storage.set(storeKey, isChecked ? '1' : '');
				body[classFx](clas);
			});
			if (!!storage.get(storeKey)) {
				body.addClass(clas);
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
