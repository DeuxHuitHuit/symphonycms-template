/**
 * @author Deux Huit Huit
 *
 * Toolkit-variables-editor
 *
 */
(function ($, undefined) {
	
	'use strict';
	

	var initVariableEditor = function () {

		//Lookup data

		//Bind template

		//Save button

		/*var blob = new Blob(["<themes><theme type=\"site\"></theme></themes>"], {type: "text/plain;charset=utf-8"});
		saveAs(blob, "theme.xml");*/
	};
	
	$(initVariableEditor);

	var initCopy = function () {
		new Clipboard('.js-btn-copy');

		new Clipboard('.js-btn-copy-color', {
			text: function (trigger, e) {
				if (e.altKey) {
					return 'bg-color-' + trigger.getAttribute('data-color-name');
				} else {
					return 'color-' + trigger.getAttribute('data-color-name');
				}
			}
		});
	};

	$(initCopy)

})(jQuery);
