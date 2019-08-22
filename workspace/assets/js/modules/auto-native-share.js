/**
 * @author Deux Huit Huit
 *
 * Auto native share form
 * Uses https://github.com/WICG/web-share
 */
(function ($, global, undefined) {

	'use strict';

	var site = $('#site');
	var sels = {
		item: '.js-native-share'
	};
	var SUPPORTED = !!window.navigator.share;
	var scope = $();

	var onClick = function (e) {
		window.navigator.share({
			title: document.title,
			url: document.location.href || ('' + document.location)
		});
		return global.pd(e);
	};


	var init = function () {
		if (SUPPORTED) {
			App.modules.notify('changeState.update', {
				item: $(sels.item),
				state: 'native-share',
				action: 'on'
			});
			site.on(App.device.events.click, sels.item, onClick);
		}
	};

	var onPageEnter = function (key, data) {
		scope = $(data.page.key());
		App.modules.notify('changeState.update', {
			item: scope.find(sels.item),
			state: 'native-share',
			action: SUPPORTED ? 'on' : 'off'
		});
	};

	var onArticleEnter = function (key, data) {
		scope = $(data.article);
		App.modules.notify('changeState.update', {
			item: scope.find(sels.item),
			state: 'native-share',
			action: SUPPORTED ? 'on' : 'off'
		});
	};

	var actions = function () {
		return {
			page: {
				enter: onPageEnter
			},
			articleChanger: {
				enter: onArticleEnter
			}
		};
	};

	App.modules.exports('auto-native-share', {
		init: init,
		actions: actions
	});

})(jQuery, window);
