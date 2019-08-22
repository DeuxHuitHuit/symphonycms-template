/**
 * @author Deux Huit Huit
 *
 * Auto flickity module
 * Front-end Integration Hierarchy:
 *
 *  |- FLICKITY CTN : .js-auto-flickity-slider-ctn
 *  |    |- CELL-CTN : .js-auto-flickity-ctn
 *  |    |    |- CELL (REPEATED): .js-auto-flickity-cell
 *
 *  Requirements:
 *		- https://cdnjs.cloudflare.com/ajax/libs/flickity/2.1.0/flickity.pkgd.min.js
 *		- Component Flickity.js
 *
 *  You can have more info on the options of Flickity at
 *  http://flickity.metafizzy.co/
 */
(function ($, undefined) {
	
	'use strict';
	
	var win = $(window);
	var site = $('#site');
	var page = $('.page');
	
	var o = {
		sliderCtn: '.js-auto-flickity-slider-ctn',
		cellCtn: '.js-auto-flickity-ctn',
		cellSelector: '.js-auto-flickity-cell',
		navBtnSelector: '.js-auto-flickity-nav-btn',

		abortedClass: 'is-flickity-cancelled',
		initedClass: 'is-flickity-inited',
		selectedClass: 'is-selected',

		imagesLoaded: true,
		accessibility: false
	};

	var flickities = [];
	
	var unpausePlayers = function () {
		$.each(flickities, function (i, t) {
			setTimeout(function () {
				t.unpause();
			}, 1500 + (i * 200));
		});
	};
	
	var onResize = function () {
		$.each(flickities, function () {
			this.resize();
		});
	};

	var initAllSliders = function (ctn) {
		ctn.find(o.sliderCtn).find(o.cellCtn).not('.' + o.initedClass).each(function () {
			var t = $(this);
			var comp = App.components.create('flickity', o);
			comp.init(t, ctn);
			if (comp.isInited()) {
				flickities.push(comp);
			}
			
			setTimeout(function () {
				comp.resize();
			}, 500);
		});
	};
	
	var pageEnter = function (key, data) {
		page = $(data.page.key());
		initAllSliders(page);
		unpausePlayers();
	};
	
	var pageLeave = function (key, data) {
		if (data.canRemove) {
			$.each(flickities, function () {
				this.destroy();
			});
			flickities = [];
		} else {
			$.each(flickities, function () {
				this.pause();
			});
		}
		
		page = $();
	};

	var onArticleEntering = function () {
		initAllSliders(page);
		unpausePlayers();
	};
	
	var actions = function () {
		return {
			site: {
				resize: onResize
			},
			page: {
				enter: pageEnter,
				leaving: pageLeave
			},
			articleChanger: {
				entering: onArticleEntering
			},
			siteLoader: {
				finishing: unpausePlayers
			},
			popupTransition: {
				beforeEnter: function (key, data) {
					initAllSliders(data.page);
					unpausePlayers();
				}
			}
		};
	};
	
	var AutoFlickity = App.modules.exports('auto-flickity', {
		actions: actions
	});
	
})(jQuery);
