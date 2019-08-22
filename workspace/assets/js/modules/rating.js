/**
 *  @author Deux Huit Huit
 *
 *  Rating module
 *
 */
(function ($, undefined) {
	
	'use strict';
	var win = $(window);
	var rateList = {};
	var SEL = '.js-rate-it';
	var URL_ATTR = 'data-rating-url';
	var CAT_ATTR = 'data-rating-categories';
	var DELAY = App.debug() ? 3000 : 10000;
	var scope = $();
	var pageEnterTimeout = 0;
	
	var rate = function () {
		var url = scope.attr(URL_ATTR);
		if (!url) {
			return;
		}
		var path = window.location.pathname;
		if (!!rateList[path]) {
			return;
		}
		var key = window.location.protocol + '//' + window.location.hostname + path;
		var data = {
			'fields[0][key]': key,
			'fields[0][tag]': '',
			'action[rate]': ''
		};
		var cats = (scope.attr(CAT_ATTR) || '').split(',');
		$.each(cats, function (i, c) {
			if (!c) {
				return;
			}
			i++;
			data['fields[' + i + '][key]'] = key;
			data['fields[' + i + '][tag]'] = c;
		});
		rateList[path] = true;
		App.loader.load({
			url: url,
			type: 'POST',
			data: data,
			error: function (err) {
				App.log(err);
				rateList[path] = false;
			},
			success: function () {
				rateList[path] = true;
			}
		});
	};
	
	var onEnter = function (key, data, e) {
		if (!!data.page) {
			scope = $(data.page.key()).find(SEL);
		} else if (!!data.article) {
			scope = $(data.article).find(SEL);
		} else {
			scope = $();
		}
		clearTimeout(pageEnterTimeout);
		pageEnterTimeout = setTimeout(rate, DELAY);
	};
	
	var actions = {
		page: {
			enter: onEnter
		},
		articleChanger: {
			enter: onEnter
		}
	};
	
	var Rating = App.modules.exports('rating', {
		actions: function () {
			return actions;
		}
	});
	
})(jQuery);
