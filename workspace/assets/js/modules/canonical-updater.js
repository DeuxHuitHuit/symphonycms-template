/**
 * @author Deux Huit Huit
 *
 * Canonical Updater
 *
 * Auto update the meta rel=canonical with the actual url of the page throught all navigation
 */
(function ($, undefined) {
	
	'use strict';
	
	var win = $(window);
	var canonicalList = {};
	var metaElemDom = $();
	
	var init = function () {
		//Create initial value
		var data = '';
		var metas = $('link[rel=canonical][href]', document);

		if (metas.length === 0) {
			App.log({args: ['No canonical meta found.'], fx: 'warn'});
		} else if (metas.length != 1) {
			App.log({args: ['Multiple canonical meta found.'], fx: 'error'});
		}

		metas.each(function (i, e) {
			var t = $(this);
			data = t.attr('href');

			//Store Dom Element for future use
			metaElemDom = t;
		});

		//Store initial data
		canonicalList[window.location.pathname] = data;
	};
	
	var onPageLoaded = function (key, data, e) {
		if (data.data) {

			var canonicalUrl = '';
			
			//Will keep the first found meta canonical href value
			$(data.data).each(function (i, e) {
				if ($(e).is('link')) {
					var t = $(e);
					if (t.attr('rel') && t.attr('rel') == 'canonical') {
						canonicalUrl = t.attr('href');
						return true;
					}
				}
			});

			if (!!!data.url) {
				data.url = window.location.pathname;
			}

			canonicalList[data.url] = canonicalUrl;
		}
	};
	
	var onEnter = function (key, data, e) {
		if (canonicalList[window.location.pathname]) {
			//Update meta in dom
			metaElemDom.attr('href', canonicalList[window.location.pathname]);
		}
	};
	
	var actions = function () {
		return {
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
	};
	
	var CanonicalUpdater = App.modules.exports('canonical-updater', {
		init: init,
		actions: actions
	});
	
})(jQuery);
