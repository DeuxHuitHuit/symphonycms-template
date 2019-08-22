/**
 *  @author Deux Huit Huit
 *
 *  oEmbed Twitter provider
 *
 *  REQUIRES:
 *      https://platform.twitter.com/widgets.js
 */

(function ($, global, undefined) {

	'use strict';
	
	var widgets = function () {
		return !!window.twttr && window.twttr.widgets;
	};
	
	var init = function () {
		var abstractProvider;
		App.modules.notify('oembed.providers.abstract', function (key, p) {
			abstractProvider = p;
		});
		var twitterProvider = $.extend({}, abstractProvider, {
			embed: function (container, id) {
				var script = container.find('.js-oembed-script');
				var scriptDom = $($(script.contents()).text());
				container.append(scriptDom);
				App.loaded(widgets, function (widgets) {
					widgets.load(scriptDom.get(0) || document);
				});
			}
		});
		App.modules.notify('oembed.providers.register', {
			key: 'Twitter',
			provider: twitterProvider
		});
	};
	
	App.modules.exports('oembed-tw', {
		init: init
	});
	
})(jQuery, window);
