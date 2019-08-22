/**
 *  @author Deux Huit Huit
 *
 *  oEmbed Dailymotion provider
 *
 *  REQUIRES:
 *      https://api.dmcdn.net/all.js
 */

(function ($, global, undefined) {

	'use strict';
	
	var DM = function () {
		return !!window.DM ? window.DM.player : false;
	};
	
	var init = function () {
		var abstractProvider;
		App.modules.notify('oembed.providers.abstract', function (key, p) {
			abstractProvider = p;
		});
		var dailymotionProvider = $.extend({}, abstractProvider, {
			getIframe: function (url,autoplay, container) {
				App.loaded(DM, function (playerFactory) {
					var id = url.indexOf('/video/') > 0 ?
						url.substring(url.indexOf('/video/') + 7, url.indexOf('_')) :
						url.substring(url.lastIndexOf('/'));
					var div = $('<div/>');
					autoplay = autoplay !== undefined ? autoplay : 1;
					
					container.append(div);
					this.playerInstance = playerFactory(div.get(0), {
						video: id,
						height: '100%',
						width: '100%',
						params: {
							autoplay: autoplay,
							logo: 0,
							info: 0,
							background: '181818',
							highlight: 'b4b4b4',
							api: 1,
							html: 1
						}
					});
				});
			},
			play: function (container) {
				this.playerInstance.play();
			},
			pause: function (container) {
				this.playerInstance.pause();
			}
		});
		App.modules.notify('oembed.providers.register', {
			key: 'Dailymotion',
			provider: dailymotionProvider
		});
	};
	
	App.modules.exports('oembed-dm', {
		init: init
	});
	
})(jQuery, window);
