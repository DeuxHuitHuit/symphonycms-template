/**
 *  @author Deux Huit Huit
 *
 *  oEmbed Soundcloud provider
 */

(function ($, global, undefined) {

	'use strict';
	
	var init = function () {
		var abstractProvider;
		App.modules.notify('oembed.providers.abstract', function (key, p) {
			abstractProvider = p;
		});
		var soundcloudProvider = $.extend({}, abstractProvider, {
			embed: function (container, id) {
				var html = abstractProvider.getTemplateContent(container);
				container.html(html);
				return container.children();
			}
		});
		App.modules.notify('oembed.providers.register', {
			key: 'Soundcloud',
			provider: soundcloudProvider
		});
	};
	
	App.modules.exports('oembed-sc', {
		init: init
	});
	
})(jQuery, window);
