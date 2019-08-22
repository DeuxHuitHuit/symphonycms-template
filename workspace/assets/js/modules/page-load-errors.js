/**
 *  @author Deux Huit Huit
 *
 *  Page load error
 */
(function ($, undefined) {

	'use strict';

	var defaultLoadFatalError = function (key, data) {
		if (data && data.url) {
			//Full reload url
			window.location = data.url;
		} else {
			//Should never append from the framework event
			window.location = window.location;
		}
	};
	
	var actions = function () {
		return {
			pages: {
				failedtoparse: function (key, data) {
					
				},
				loaderror: function (key, data) {
					
				},
				loadfatalerror: function (key, data) {
					defaultLoadFatalError(key, data);
				}
			},
			articleChanger: {
				loaderror: function (key, data) {
					defaultLoadFatalError(key, data);
				}
			}
		};
	};
	
	var PageLoadErrors = App.modules.exports('page-load-errors', {
		actions: actions
	});
	
})(jQuery);
