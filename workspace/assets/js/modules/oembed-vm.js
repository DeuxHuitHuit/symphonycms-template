/**
 *  @author Deux Huit Huit
 *
 *  oEmbed Vimeo provider
 *
 *  REQUIRES:
 *      https://f.vimeocdn.com/js/froogaloop2.min.js
 */

(function ($, global, undefined) {

	'use strict';
	
	var $f = function () {
		return global.$f;
	};
	
	var init = function () {
		var abstractProvider;
		App.modules.notify('oembed.providers.abstract', function (key, p) {
			abstractProvider = p;
		});
		var vimeoProvider = $.extend({}, abstractProvider, {
			getIframe: function (id, autoplay, loop, rel, extra) {
				autoplay = autoplay !== undefined ? autoplay : 1;
				loop = loop !== undefined ? loop : 1;
				
				return abstractProvider.getIframe()
					.attr('src', '//player.vimeo.com/video/' + id +
							'?autoplay=' + autoplay + '&loop=' + loop +
							'&muted=' + autoplay +
							'&api=1&html5=1&rel=' + rel + (extra || ''));
			},
			
			ready: function (container, callback) {
				App.loaded($f, function ($f) {
					var player = $f($('iframe', container).get(0));
					
					player.addEvent('ready', function () {
						if (container.attr('data-volume')) {
							player.api('setVolume', parseInt(container.attr('data-volume'), 10));
						}
						App.callback(callback, [player]);
					});
				});
			},
			
			play: function (container) {
				App.loaded($f, function ($f) {
					var player = $f($('iframe', container).get(0));
					
					player.api('play');
				});
			},
			
			pause: function (container) {
				App.loaded($f, function ($f) {
					var player = global.$f($('iframe', container).get(0));
					
					player.api('pause');
				});
			},

			progress: function (container, callback) {
				App.loaded($f, function ($f) {
					var player = global.$f($('iframe', container).get(0));
					player.addEvent('playProgress', function (e) {
						App.callback(callback, [e.percent * 100]);
					});
				});
			},

			finish: function (container, callback) {
				App.loaded($f, function ($f) {
					var player = global.$f($('iframe', container).get(0));
					player.addEvent('finish', function () {
						App.callback(callback, {
							container: container
						});
					});
				});
			},
			
			volume: function (container, value) {
				App.loaded($f, function ($f) {
					var player = global.$f($('iframe', container).get(0));
					player.api('setVolume', value);
				});
			},

			requiresVideo: function () {
				return true;
			}
		});
		App.modules.notify('oembed.providers.register', {
			key: 'Vimeo',
			provider: vimeoProvider
		});
	};
	
	App.modules.exports('oembed-vm', {
		init: init
	});
	
})(jQuery, window);
