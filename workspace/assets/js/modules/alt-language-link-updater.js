/**
 *  @author Deux Huit Huit
 *
 *  Alt language link updater
 */
(function ($, undefined) {
	
	'use strict';
	var linkSelector = '#site a.js-alt-lg-link';
	var win = $(window);
	var linkList = {};
	
	var init = function () {
		//Create initial value
		var data = {};
		$('link[rel=alternate][hreflang]', document).each(function () {
			var t = $(this);
			data[t.attr('hreflang')] = t.attr('href');
		});
		linkList[window.location.pathname] = data;
	};
	
	var onPageLoaded = function (key, data, e) {
		if (data.data) {
			var linkData = {};
			
			$(data.data).each(function (i, e) {
				if ($(e).is('link')) {
					var t = $(e);
					if (t.attr('hreflang')) {
						linkData[t.attr('hreflang')] = t.attr('href');
					}
				}
				if ($(e).is('body')) {
					return true;
				}
			});
			// add complete url
			linkList[data.url] = linkData;
			// remove query string
			if (data.url.indexOf('?') !== -1) {
				var url = data.url.split('?')[0];
				linkList[url] = linkData;
			}
		}
	};
	
	var onEnter = function (key, data, e) {
		if (linkList[window.location.pathname]) {
			//Update links
			$(linkSelector).each(function () {
				var t = $(this);
				var value = linkList[window.location.pathname][t.data('lg')];
				
				if (value) {
					t.attr('href', value);
				}
			});
		}
	};
	
	var actions = {
		pages: {
			loaded: onPageLoaded
		},
		page: {
			enter: onEnter
		},
		articleChanger: {
			loaded: onPageLoaded,
			enter: onEnter
		}
	};
	
	var AltLanguageLinkUpdater = App.modules.exports('altLanguageLinkUpdater', {
		init: init,
		actions: function () {
			return actions;
		}
	});
	
})(jQuery);
