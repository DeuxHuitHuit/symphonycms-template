/**
 *  @author Deux Huit Huit
 *
 *  Auto jit image
 */
(function ($, global, undefined) {
	
	'use strict';
	
	var firstTime = true;
	var site = $('#site');
	
	var onJitLoaded = function (args) {
		var t = $(args.target);
		
		if (t.hasClass('jit-image-bg-src')) {
			var bg = t.closest('.jit-image-bg');
			bg.css({
				backgroundImage: 'url(\'' + t.attr('src') + '\')'
			});
		}
	};

	var onArticleEnter = function (key, data) {
		$(data.article).find('img[data-src-format]').jitImage();
	};

	var onEnter = function (key, data) {
		if (!firstTime) {
			$(data.page.key()).find('img[data-src-format]').jitImage();
		}
		firstTime = false;
	};

	var init = function () {
		site.on('loaded.jitImage', onJitLoaded);
	};
	
	var actions = function () {
		return {
			page: {
				enter: onEnter
			},
			articleChanger: {
				enter: onArticleEnter
			}
		};
	};
	
	var AutoJitImage = App.modules.exports('auto-jit-image', {
		init: init,
		actions: actions
	});
	
})(jQuery, window);
