/**
 * @author Deux Huit Huit
 *
 */
(function ($, undefined) {
	
	'use strict';
	var win = $(window);
	var siteLoader = $('#site-loader');
	var html = $('html');
	
	var getParam = function (p) {
		var match = new RegExp('[?&]' + p + '=([^&]*)').exec(window.location.search);
		return match && decodeURIComponent(match[1].replace(/\+/g, ' '));
	};
	
	var setCookie = function (name, value, days) {
		var date = new Date();
		date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
		var expires = '; expires=' + date.toGMTString();
		document.cookie = name + '=' + value + expires + ';path=/';
	};
	
	var storeIdInCookie = function () {
		var gclid = getParam('gclid');
		
		if (gclid) {
			var gclsrc = getParam('gclsrc');
			if (!gclsrc || gclsrc.indexOf('aw') !== -1) {
				setCookie('gclid', gclid, 90);
			}
		}
	};
	
	var setIdFromCookie = function (key, data) {
		var regEx = new RegExp('(?:^|;\\s*)gclid=([^;]*)').exec(document.cookie);
		if (!!regEx) {
			var id = !!regEx[1] ? regEx[1] : '';
			
			if (!!data.input) {
				data.input.attr('value', id);
			}
		}
	};
	
	var init = function () {
		storeIdInCookie();
	};
	
	var actions = function () {
		return {
			salesforceAdwords: {
				setId: setIdFromCookie
			}
		};
	};
	
	App.modules.exports('salesforce-adwords', {
		init: init,
		actions: actions
	});
	
})(jQuery);
