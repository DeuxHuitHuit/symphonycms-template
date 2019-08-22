/**
 *  @author Deux Huit Huit
 *
 *  oEmbed Facebook provider
 *
 *  REQUIRES:
 *      https://connect.facebook.net/en_US/sdk.js#xfbml=1&amp;version=v2.3
 *      <div id="fb-root"></div> in the body
 */
(function ($, global, undefined) {

	'use strict';
	
	var XFBML = function () {
		return !!window.FB && window.FB.XFBML;
	};
	
	var init = function () {
		var abstractProvider;
		if (!$('#fb-root').length) {
			App.log({
				fx: 'error',
				args: 'The FB SDK requires <div id="fb-root"></div> in the body'
			});
		}
		App.modules.notify('oembed.providers.abstract', function (key, p) {
			abstractProvider = p;
		});
		var facebookProvider = $.extend({}, abstractProvider, {
			embed: function (container, id) {
				App.loaded(XFBML, function (XFBML) {
					XFBML.parse(container.get(0) || document, function () {
						App.callback(facebookProvider.ready);
					});
				});
			}
		});
		App.modules.notify('oembed.providers.register', {
			key: 'Facebook',
			provider: facebookProvider
		});
	};
	
	App.modules.exports('oembed-fb', {
		init: init
	});
	
})(jQuery, window);
