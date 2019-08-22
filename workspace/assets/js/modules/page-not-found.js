/**
 *  @author Deux Huit Huit
 *
 *  Page not found
 */
(function ($, undefined) {

	'use strict';
	
	var actions = function () {
		return {
			pages: {
				notfound: function (key, data) {
					if (!!data && !!data.url && data.url !== window.location.pathname) {
						window.location = data.url;
					}
				}
			}
		};
	};
	
	var PageNotFound = App.modules.exports('page-not-found', {
		actions: actions
	});
	
})(jQuery);
