/**
 * @author Deux Huit Huit
 *
 * jPlayer
 */
 
(function ($, win, undefined) {

	'use strict';
	
	App.components.exports('jplayer', function (o) {
		
		var container;
		var defaultOptions = {
			playerSelector: '.js-jplayer-player',
			playerContainerSelector: '.js-jplayer-container',
			onReady: null,
			onTimeupdate: null,
			backgroundColor: 'transparent',
			loop: true,
			width: 1920,
			height: 1080,
			resize: true
		};
		
		var options = $.extend({}, defaultOptions, o);
		
		//Partie pour les players video
		
		var resizeVideo = function (playerCtn) {
			var ctnWidth = playerCtn.width();
			var ctnHeight = playerCtn.height();
			var player = playerCtn.find(options.playerSelector);
			
			var newSize = $.sizing.aspectFill({
				width: ctnWidth,
				height: ctnHeight,
				preferWidth: false
			}, options.width / options.height);
			
			//Round size to avoid part of pixel
			newSize.height = Math.ceil(newSize.height);
			newSize.width = Math.ceil(newSize.width);
			
			var newPosition = $.positioning.autoPosition({
				position: 'center',
				left: 'left',
				top: 'top'
			}, $.size(ctnWidth, ctnHeight), newSize);

			player.size(newSize).css(newPosition).data({
				size: newSize,
				position: newPosition
			});

			player.jPlayer('option', {size: newSize});
		};
		
		var resizeAllVideo = function () {
			container.find(options.playerContainerSelector).each(function () {
				resizeVideo($(this));
			});
		};
		
		var loadVideo = function (ctn) {
			var player = ctn.find(options.playerSelector);
				
			player.jPlayer({
				ready: function () {
					var t = $(this);
					t.jPlayer('setMedia', {
						webmv: ctn.attr('data-video-webm'),
						m4v: ctn.attr('data-video-mp4'),
						ogv: ctn.attr('data-video-ogv')
					});
					
					if (options.resize) {
						resizeVideo(ctn);
					}
					
					App.callback(options.onReady, [ctn]);
				},
				solution: 'html',
				loop: options.loop,
				volume: 0,
				supplied: 'webmv, m4v, ogv',
				backgroundColor: options.backgroundColor,
				wmode: options.backgroundColor,
				size: {
					width: options.width,
					height: options.height
				},
				preload: options.preload || 'none',
				play: function (e) {
					App.mediator.notify('jplayer.play', {ctn: ctn});
					
				},
				timeupdate: function (e) {
					var status = e.jPlayer.status;
					
					if (!!status.currentTime) {
						App.mediator.notify('jplayer.timeupdate', {status: status, ctn: ctn});
					}
					
					App.callback(options.onTimeupdate, [ctn, status]);
				},
				ended: function () {
					App.callback(options.onEnded, [ctn]);
				}
			});
		};
		
		var loadAllVideo = function () {
			var playerCtn = container.find(options.playerContainerSelector);
			
			playerCtn.each(function () {
				var ctn = $(this);
				loadVideo(ctn);
			});
		};
		
		var destroyVideo = function (playerCtn) {
			var player = playerCtn.find(options.playerSelector);
			
			player.jPlayer('destroy');
			player.jPlayer('pauseOthers');
		};
		
		var destroyAllVideo = function () {
			container.find(options.playerContainerSelector).each(function () {
				var t = $(this);
				
				destroyVideo(t);
				t.removeClass('video-loaded').closest('.video-loaded').removeClass('video-loaded');
			});
		};
		
		var playVideo = function (playerCtn) {
			var player = playerCtn.find(options.playerSelector);
			player.jPlayer('pauseOthers');
			player.jPlayer('play');
		};
		
		var pauseVideo = function (playerCtn) {
			var player = playerCtn.find(options.playerSelector);
			
			player.jPlayer('pause');
		};
		
		var stopVideo = function (playerCtn) {
			var player = playerCtn.find(options.playerSelector);
			
			player.jPlayer('stop');
		};
		
		var setVolume = function (playerCtn, volume) {
			var player = playerCtn.find(options.playerSelector);
			
			player.jPlayer('volume', volume);
		};
		
		// c délimite ou je veux écouté mes évenement
		// (page ou site, ce qui a été spécifier lors du init)
		var init = function (c) {
			container = $(c);
		};
		
		return {
			init: init,
			loadAllVideo: loadAllVideo,
			loadVideo: loadVideo,
			destroyVideo: destroyVideo,
			destroyAllVideo: destroyAllVideo,
			playVideo: playVideo,
			pauseVideo: pauseVideo,
			stopVideo: stopVideo,
			resizeVideo: resizeVideo,
			resizeAllVideo: resizeAllVideo,
			setVolume: setVolume
		};
	});
	
})(jQuery, jQuery(window));
