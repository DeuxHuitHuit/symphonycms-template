/**
 *  @author Deux Huit Huit
 *
 *  oEmbed Youtube provider
 *
 *  REQUIRES:
 *      https://www.youtube.com/iframe_api
 */

(function ($, global, undefined) {

	'use strict';
	
	var YT = function () {
		return !!global.YT ? global.YT.Player : false;
	};
	
	var init = function () {
		var abstractProvider;
		App.modules.notify('oembed.providers.abstract', function (key, p) {
			abstractProvider = p;
		});
		var youtubeProvider = $.extend({}, abstractProvider, {
			getIframe: function (url, autoplay, loop, rel, extra) {
				var id = url.indexOf('v=') > 0 ?
					url.match(/v=([^\&]+)/mi)[1] :
					url.substring(url.lastIndexOf('/') + 1);
				var autoPlay = autoplay !== undefined ? autoplay : 1;
				var iframe = abstractProvider.getIframe()
					.attr('id', 'youtube-player-' + id)
					.attr('src', '//www.youtube.com/embed/' + id +
						'?feature=oembed&autoplay=' + autoPlay +
						'&mute=' + autoPlay +
						'&origin=' + document.location.origin +
						'&enablejsapi=1&version=3&html5=1&rel=' + rel + (extra || ''));
				
				App.loaded(YT, function (Player) {
					youtubeProvider.ytplayer = new Player(iframe.get(0));
				});
				
				return iframe;
			},
			
			playerLoaded: function () {
				return youtubeProvider.ytplayer && youtubeProvider.ytplayer.playVideo;
			},
			
			ready: function (container, callback) {
				App.loaded(YT, function (Player) {
					App.callback(callback, [Player]);
				});
			},
			
			play: function (container) {
				App.loaded(YT, function (Player) {
					App.loaded(youtubeProvider.playerLoaded, function () {
						youtubeProvider.ytplayer.playVideo();
					});
				});
			},
			
			pause: function (container) {
				App.loaded(YT, function (Player) {
					App.loaded(youtubeProvider.playerLoaded, function () {
						youtubeProvider.ytplayer.pauseVideo();
					});
				});
			},

			progress: function (container, callback) {
				var timeout = 0;
				var tick = function () {
					clearTimeout(timeout);
					if (!!youtubeProvider.ytplayer) {
						var duration = youtubeProvider.ytplayer.getDuration();
						var played = youtubeProvider.ytplayer.getCurrentTime();
						App.callback(callback, [Math.max(0, (played / duration) * 100 || 0)]);
					}
					timeout = setTimeout(tick, 2000);
				};
				var onStateChange = function (newState) {
					if (newState.data === global.YT.PlayerState.PLAYING) {
						tick();
					}
					else {
						clearTimeout(timeout);
						timeout = 0;
					}
				};
				App.loaded(YT, function (Player) {
					App.loaded(youtubeProvider.playerLoaded, function () {
						youtubeProvider.ytplayer.addEventListener('onStateChange', onStateChange);
					});
				});
			},

			finish: function (container, callback) {
				var onStateChange = function (newState) {
					if (newState.data === global.YT.PlayerState.ENDED) {
						App.callback(callback, {
							container: container
						});
					}
				};
				App.loaded(YT, function (Player) {
					App.loaded(youtubeProvider.playerLoaded, function () {
						youtubeProvider.ytplayer.addEventListener('onStateChange', onStateChange);
					});
				});
			},

			requiresVideo: function () {
				return true;
			}
		});
		App.modules.notify('oembed.providers.register', {
			key: 'YouTube',
			provider: youtubeProvider
		});
	};
	
	App.modules.exports('oembed-yt', {
		init: init
	});
	
})(jQuery, window);
