/**
 *  @author Deux Huit Huit
 *
 *  Route not found
 */
(function ($, undefined) {

	'use strict';
	
	var actions = function () {
		return {
			pages: {
				routeNotFound: function (key, data) {
					if (!!data && !!data.url && data.url !== window.location.pathname) {
						window.location = data.url;
					}
				}
			}
		};
	};
	
	var RouteNotFound = App.modules.exports('route-not-found', {
		actions: actions
	});
	
})(jQuery);
