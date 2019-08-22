/**
 *  @author Deux Huit Huit
 *
 *  Defered css
 */
(function ($, global, undefined) {
	
	'use strict';
	
	var actions = function () {
		return {
			site: {
				loaded: function () {
					$('link[data-href]').each(function () {
						var t = $(this);
						t.attr('href', t.attr('data-href'));
					});
				}
			}
		};
	};
	
	var DeferedCss = App.modules.exports('defered-css', {
		actions: actions
	});
	
})(jQuery, window);
