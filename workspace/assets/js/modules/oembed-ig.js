/**
 *  @author Deux Huit Huit
 *
 *  oEmbed Instagram provider
 *
 *  REQUIRES:
 *      https://platform.instagram.com/en_US/embeds.js
 */

(function ($, global, undefined) {

	'use strict';
	
	var instgrm = function () {
		return !!window.instgrm && window.instgrm.Embeds;
	};
	
	var init = function () {
		var abstractProvider;
		App.modules.notify('oembed.providers.abstract', function (key, p) {
			abstractProvider = p;
		});
		var instagramProvider = $.extend({}, abstractProvider, {
			embed: function (container, id) {
				var html = abstractProvider.getTemplateContent(container);
				if (!!html) {
					container.html(html);
				}
				App.loaded(instgrm, function (Embeds) {
					Embeds.process();
				});
				return !html ? undefined : container.children();
			}
		});
		App.modules.notify('oembed.providers.register', {
			key: 'Instagram',
			provider: instagramProvider
		});
	};
	
	App.modules.exports('oembed-ig', {
		init: init
	});
	
})(jQuery, window);
