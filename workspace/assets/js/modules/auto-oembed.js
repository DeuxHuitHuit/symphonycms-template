/**
 *  @author Deux Huit Huit
 *
 *  Auto oembed
 *      Module to manage oembed components
 */
(function ($, global, undefined) {
	
	'use strict';
	
	var win = $(window);
	var site = $('#site');
	var page = $();
	var components = [];
	var isFirstTime = true;
	var BTN_PLAY_SEL = '.js-auto-oembed-play';
	var PLAYER_SEL = '.js-auto-oembed-player';
	var CTN_SEL = '.js-auto-oembed-ctn';
	var DATA_KEY = 'auto-oembed';
	
	var destroyOembed = function (ctn) {
		ctn.find(CTN_SEL).each(function () {
			var t = $(this);
			var vPlayer = t.find(PLAYER_SEL);
			var oembed = t.data(DATA_KEY);

			App.modules.notify('changeState.update', {
				item: t,
				state: 'playing',
				action: 'off'
			});

			if (!!oembed) {
				oembed.destroy();
			}
			t.data(DATA_KEY, null);
		});
	};

	var embedOne = function (ctx, force) {
		var vPlayer = ctx.find(PLAYER_SEL);
		var autoLoad = vPlayer.attr('data-autoload');
		var oembed = ctx.data(DATA_KEY) || App.components.create('oembed', {
			container: ctx,
			player: vPlayer
		});

		if (!force && oembed.requiresVideo()) {
			if (App.device.mobile && autoLoad !== 'mobile' && autoLoad !== 'all') {
				return;
			}
			if (!App.device.mobile && autoLoad === 'none') {
				return;
			}
		}

		ctx.data(DATA_KEY, oembed);
		components.push(oembed);
		oembed.load({
			finish: function () {
				App.modules.notify('changeState.update', {
					item: ctx,
					state: 'playing',
					action: 'off'
				});
			}
		});
		return oembed;
	};
	
	var embedAll = function (ctx) {
		var scope = ctx.is(CTN_SEL) ? ctx : ctx.find(CTN_SEL);
		scope.each(function () {
			embedOne($(this));
		});
	};

	var pause = function (ctx) {
		var d = ctx.data();

		if (d && d.autoOembed) {
			d.autoOembed.pause();
		}
	};

	var pauseAll = function (ctx) {
		var scope = ctx.is(CTN_SEL) ? ctx : ctx.find(CTN_SEL);
		scope.each(function () {
			pause($(this));
		});
	};

	var onPauseAll = function (key, data) {
		if (data && data.item) {
			pauseAll(data.item);
		}
	};

	var onPlayBtnClick = function (e) {
		var t = $(this);
		var pauseAllOther = t.attr('data-auto-oembed-pause-other-on-play') === 'true';
		var vCtn = t.closest(CTN_SEL);
		var oembed = vCtn.data(DATA_KEY);

		if (pauseAllOther) {
			pauseAll($('#site'));
		}

		if (!oembed) {
			oembed = embedOne(vCtn, true);
		}

		if (!!oembed) {
			App.modules.notify('changeState.update', {
				item: vCtn,
				state: 'playing',
				action: 'on'
			});
			oembed.play();
		}

		return global.pd(e);
	};

	var onPageEnter = function (key, data) {
		page = $(data.page.key());
		if (!isFirstTime) {
			embedAll(page);
		}
	};

	var onPageLeave = function () {
		destroyOembed(page);
		page = $();
		components = [];
	};

	var onSiteLoaded = function () {
		isFirstTime = false;
		embedAll(site);
	};

	var onInfiniteScrollLoaded = function (key, data) {
		if (!!data.ctn) {
			embedAll(data.ctn);
		}
	};

	var onArticleChangerEnter = function (key, data) {
		destroyOembed(page);
		
		if (!!data.article) {
			embedAll(data.article);
		}
	};

	var init = function () {
		site.on(App.device.events.click, BTN_PLAY_SEL, onPlayBtnClick);
	};

	var actions = function () {
		return {
			page: {
				enter: onPageEnter,
				leaving: onPageLeave
			},
			site: {
				loaded: onSiteLoaded
			},
			infiniteScroll: {
				pageLoaded: onInfiniteScrollLoaded
			},
			articleChanger: {
				enter: onArticleChangerEnter
			},
			autoOembed: {
				pauseAll: onPauseAll
			}
		};
	};

	App.modules.exports('auto-oembed', {
		init: init,
		actions: actions
	});
	
})(jQuery, window);
