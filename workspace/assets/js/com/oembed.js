/**
 * @author Deux Huit Huit
 *
 * oEmbed module
 *  Component that abstract how we need to embed media coming from
 *  a oembed sources.
 *
 *  Providers must be registered via the oembed.providers.register action
 *
 *  requires checkpoint-event
 */

(function ($, win, undefined) {

	'use strict';

	var	abstractProvider = {
		embed: function (container, id) {
			var iAutoPlayParsed = parseInt(container.attr('data-autoplay'), 10);
			var iLoopParsed = parseInt(container.attr('data-loop'), 10);
			
			var iRelatedVideo = container.attr('data-rel') === '1' ? 1 : 0;
			var extra = container.attr('data-extra');
			var iframe = this.getIframe(id, iAutoPlayParsed, iLoopParsed, iRelatedVideo, extra);
			
			iframe.attr('width', '100%');
			iframe.attr('height', '100%');
			iframe.attr('frameborder', '0');
			iframe.attr('class', container.attr('data-player-class'));
			container.append(iframe);
			return iframe;
		},
		getIframe: function (id) {
			return $('<iframe allowfullscreen="" />');
		},
		getTemplateContent: function (container) {
			var content = container.find('script');
			return _.map(content.contents(), function (e) {
				return $(e).text();
			}).join('');
		},
		play: $.noop,
		pause: $.noop,
		ready: $.noop,
		progress: $.noop,
		volume: $.noop,
		finish: $.noop,
		destroy: function (element) {
			element.remove();
		},
		requiresVideo: function () {
			return false;
		}
	};
	
	var providers = {
		abstractProvider: abstractProvider
	};
	
	var oembedCom = App.components.exports('oembed', function (options) {
		var container = $(options.container);
		var player = $(options.player);
		var oembedId = player.data('oembedId');
		var oembedProviderName = player.data('oembedProvider');
		var oembedProvider = providers[oembedProviderName];
		var embededElement = $();
		
		if (!oembedProvider) {
			App.log({args: ['Provider `%s` not found.', oembedProvider], me: 'oEmbed', fx: 'warn'});
			oembedProvider = abstractProvider;
		}
		
		var load = function (params) {
			params = params || false;
			
			embededElement = oembedProvider.embed(player, oembedId, params.autoplay, params.loop);
			embededElement = embededElement || $();
			
			// Track it
			var checkpointEvent = App.components.create('checkpoint-event', {
				category: options.category || 'Video',
				action: 'view',
				label: oembedProviderName + ': ' + (player.attr('data-oembed-title') || oembedId)
			});
			checkpointEvent.init();
			oembedProvider.ready(player, function () {
				player.addClass('loaded');
				
				oembedProvider.progress(player, function (perc) {
					checkpointEvent.track(perc);
				});
				
				if (!!params.finish) {
					oembedProvider.finish(player, params.finish);
				}
			});
		};
		
		var setVolume = function (volume) {
			oembedProvider.volume(player, volume);
		};
		
		var play = function () {
			oembedProvider.play(container);
		};
		
		var pause = function () {
			if (!!oembedProvider &&
				!!oembedId &&
				!!container.find('iframe').length) {
				oembedProvider.pause(container);
			}
		};
		
		var destroy = function () {
			player.removeClass('loaded');
			oembedProvider.destroy(embededElement);
		};
		
		var requiresVideo = function () {
			return oembedProvider.requiresVideo();
		};
		
		return {
			load: load,
			play: play,
			pause: pause,
			volume: setVolume,
			destroy: destroy,
			requiresVideo: requiresVideo
		};
	});
	
	var oembedMod = App.modules.exports('oembed-providers', {
		actions: function () {
			return {
				oembed: {
					providers: {
						abstract: function () {
							return abstractProvider;
						},
						register: function (key, data) {
							if (!!providers[data.key]) {
								App.log({
									args: ['Provider `%s` already exists.', data.key],
									me: 'oEmbed',
									fx: 'error'
								});
							}
							else {
								providers[data.key] = data.provider;
							}
						}
					}
				}
			};
		}
	});
	
})(jQuery, jQuery(window));
