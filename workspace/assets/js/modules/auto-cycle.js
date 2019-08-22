/**
 *  @author Deux Huit Huit
 *
 *  Auto cycle
 */
(function ($, undefined) {

	'use strict';
	
	var win = $(window);
	var site = $('#site');
	var isFirstLoad = true;
	var page = $('.page');

	// stop videos when changinf slide
	var onCycleBefore = function (e, o, outSlide, inSlide, foward) {
		var vCtn = $(outSlide).find('.js-oembed-video-player');

		if (!!vCtn.length) {
			App.modules.notify('pauseVideo', vCtn);
		}
	};

	var onCycleAfter = function (e, o, outSlide, inSlide, foward) {
		if (!App.device.mobile) {
			$(this).cycle('resume');

			var oembedCtn = $(outSlide).find('.js-oembed-video-ctn');
			var player = oembedCtn.find('.js-oembed-video-player');

			if (!!player.hasClass('loaded')) {
				oembedCtn.removeClass('is-playing');
				player.removeClass('loaded').empty();
			}
		}
	};

	// GESTION DES VIDEOS OEMBED DANS UN CYCLE
	var onOembedFinish = function (data) {
		if (!App.device.mobile) {
			data.container.closest('.js-cycle').cycle('resume');
		}
	};

	var onOembedPlayClick = function (e) {
		var t = $(this);
		var vCtn = t.closest('.js-oembed-video-ctn');
		var vPlayer = vCtn.find('.js-oembed-video-player');
		
		if (!App.device.mobile) {
			App.modules.notify('loadVideo', {
				player: vPlayer,
				autoplay: true,
				finish: onOembedFinish
			});
		}
		
		vCtn.addClass('is-playing');
		if (!App.device.mobile) {
			t.closest('.js-cycle').cycle('pause');
		}
		
		return window.pd(e);
	};

	var loadCycleVideo = function () {
		page.find('.js-cycle-slide.video .js-oembed-video-ctn').each(function () {
			var t = $(this);
			var vPlayer = t.find('.js-oembed-video-player');
			
			App.modules.notify('loadVideo', {
				player: vPlayer,
				finish: onOembedFinish
			});
		});
	};

	var pageEnter = function (key, data) {
		page = $(data.page.key());
		
		$('.js-cycle:not(.cycle-inited)').each(function () {
			var t = $(this);
			
			if (!t.data('cycle-disable-mobile') || !App.device.mobile) {
				var o = {
					slides: t.attr('data-cycle-slides') || '>img',
					pager: t.attr('data-cycle-pager') || '> .cycle-pager',
					pagerTemplate: t.attr('data-cycle-pager-template') || '<span><span>',
					next: t.attr('data-cycle-next') || '> .cycle-next',
					prev: t.attr('data-cycle-prev') || '> .cycle-prev',
					timeout: parseInt(t.attr('data-cycle-timeout'), 10) || 4000,
					paused: App.device.mobile ? true : t.attr('data-cycle-paused') || false,
					pauseOnHover: t.attr('data-cycle-pause-on-hover') || true,
					fx: t.attr('data-cycle-fx') || 'fade',
					caption: t.attr('data-cycle-caption') || '> .cycle-caption',
					log: App.debug()
				};
				
				t.cycle(o);
				t.on('cycle-before', onCycleBefore);
				t.on('cycle-after', onCycleAfter);
				
				t.addClass('cycle-inited');
			}
		});

		if (!isFirstLoad && App.device.mobile) {
			loadCycleVideo();
		}
	};

	var onSiteLoaded = function () {
		isFirstLoad = false;
		if (App.device.mobile) {
			loadCycleVideo();
		}
		
	};
	
	var init = function () {
		site.on(
			App.device.events.click,
			'.js-cycle-slide.video .js-oembed-video-play',
			onOembedPlayClick
		);
	};
	
	var actions = function () {
		return {
			site: {
				loaded: onSiteLoaded
			},
			page: {
				enter: pageEnter
			},
			articleChanger: {
				enter: pageEnter
			}
		};
	};

	App.modules.exports('auto-cycle', {
		init: init,
		actions: actions
	});
	
})(jQuery);
