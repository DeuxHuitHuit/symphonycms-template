/**
 *  @author Deux Huit Huit
 *
 *  User id
 */
(function ($, undefined) {

	'use strict';
	
	var LENGTH = 32;
	var HIDDEN_FIELD_SEL = '.js-user-id';
	var storage = window.Storage.local;
	var KEY = 'auto-user-id';
	var uId = '';
	
	var createUid = function () {
		var i = 0;
		var uId = '';
		if (!window.Uint8Array || !window.crypto) {
			for (i = 0; i < LENGTH; ++i) {
				uId += (~~(Math.random() * 10000) % 255).toString(16);
			}
			return uId;
		}
		var randomPool = new window.Uint8Array(LENGTH);
		window.crypto.getRandomValues(randomPool);
		for (i = 0; i < randomPool.length; ++i) {
			uId += randomPool[i].toString(16);
		}
		return uId;
	};

	var init = function () {
		uId = storage.get(KEY) || '';
		if (!uId) {
			uId = createUid();
			storage.set(KEY, uId);
		}
	};

	var update = function () {
		if (!uId) {
			return;
		}
		$(HIDDEN_FIELD_SEL).val(uId);
	};

	var actions = function () {
		return {
			page: {
				enter: update
			},
			articleChanger: {
				enter: update
			}
		};
	};

	App.modules.exports('user-id', {
		init: init,
		actions: actions
	});
	
})(jQuery);
