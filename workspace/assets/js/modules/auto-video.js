/**
 *  @author Deux Huit Huit
 *
 *  Auto video
 */
(function ($, undefined) {
	
	'use strict';
	var win = $(window);
	var site = $('#site');
	var page = $('.page');

	var AUTO_VIDEO_SELECTOR = '.js-auto-video';
	var BTN_PLAY_SEL = '.js-auto-video-play';
	var BTN_TOGGLE_PLAY_SEL = '.js-auto-video-toggle-play';

	var resizeTimer = 0;

	var initVideo = function (video, options) {
		//Var other options
		var minimalOptions = {};

		var vOptions = $.extend({}, minimalOptions, options);

		var v = App.components.create('video', vOptions);

		v.init(video);
		v.load();

		video.data('autoVideoComponent', v);
	};

	var togglePlay = function (ctn) {
		ctn.find(AUTO_VIDEO_SELECTOR).each(function () {
			var t = $(this);
			var d = t.data();

			if (d && d.autoVideoComponent) {
				d.autoVideoComponent.togglePlay();
			}else {
				App.log('No auto-video-component found');
			}
		});
	};

	var onTogglePlayBtnClick = function () {
		var vCtn = $(this).closest('.js-auto-video-ctn');
		togglePlay(vCtn);
	};
	
	var playVideos = function (ctn) {
		ctn.find(AUTO_VIDEO_SELECTOR).each(function () {
			var t = $(this);
			var d = t.data();

			if (d && d.autoVideoComponent) {
				var video = d.autoVideoComponent;

				video.resize();
				video.play();
			} else {
				App.log('No autoVideoComponent found');
			}
		});
	};

	var initVideos = function (ctn) {
		var btns = site.find(BTN_TOGGLE_PLAY_SEL);
		btns.off($.click, onTogglePlayBtnClick);
		btns.on($.click, onTogglePlayBtnClick);

		ctn.find(AUTO_VIDEO_SELECTOR).each(function () {
			initVideo($(this));
		});
	};

	var onResize = function () {
		window.craf(resizeTimer);

		resizeTimer = window.raf(function () {
			page.find(AUTO_VIDEO_SELECTOR).each(function () {
				var d = $(this).data();
				if (d && d.autoVideoComponent) {
					d.autoVideoComponent.resize();
				}
			});
		});
	};

	var onPageEnter = function (key, data) {
		page = $(data.page.key());

		initVideos(page);
	};

	var onArticleEnter = function (key, data) {
		initVideos(data.article);
	};

	var onPageLeave = function (key, data) {
		if (!!data.canRemove) {
			page.find(AUTO_VIDEO_SELECTOR).each(function () {
				var t = $(this);
				var ctn = t.closest('.js-auto-video-ctn');
				var d = t.data();

				if (d && d.autoVideoComponent) {
					var comp = d.autoVideoComponent;
					//Remove cyclic ref
					t.data('autoVideoComponent', null);
					comp.destroy();
				}
			});
		}
	};

	var onPlayBtnClick = function (e) {
		playVideos($(this).closest('.js-auto-video-ctn'));
		return window.pd(e);
	};

	var init = function () {
		site.on($.click, BTN_PLAY_SEL, onPlayBtnClick);
	};

	var actions = function () {
		return {
			page: {
				enter: onPageEnter,
				leaving: onPageLeave
			},
			articleChanger: {
				enter: onArticleEnter
			},
			site: {
				resize: onResize
			},
			video: {
				resize: onResize
			}
		};
	};
	
	App.modules.exports('auto-video', {
		init: init,
		actions: actions
	});
	
})(jQuery);
