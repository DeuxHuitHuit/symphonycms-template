/**
 * @author Deux Huit Huit
 *
 * Default page implementation
 *
 */

(function ($, global, undefined) {

	'use strict';
	
	App.pages.exports('default-page', function () {
		var page;
		
		var onEnter = function (next) {
			App.callback(next);
		};
		
		var init = function () {
			page = $(this.key());
		};
		
		var actions = function () {
			return {
				
			};
		};
		
		var self = {
			init: init,
			enter: onEnter,
			actions: actions
		};
		
		return self;
	});
	
})(jQuery, window);
