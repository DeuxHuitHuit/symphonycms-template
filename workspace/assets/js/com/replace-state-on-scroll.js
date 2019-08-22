/**
 * @author Deux Huit Huit
 *
 * replace history state on scroll
 */
(function ($, global, undefined) {
	
	'use strict';
	
	var win = $(window);
	var defaults = {
		itemSelector: '.js-replace-state-on-scroll',
		container: 'body',
		urlAttribute: 'data-canonical-url',
		titleAttribute: 'data-canonical-title',
		change: null,
		windowOffsetPercentage: 0.5
	};
	
	var ReplaceStateOnScroll = App.components.exports(
		'replace-state-on-scroll', function (options) {
		var o = $.extend({}, defaults, options);
		var items = $();
		var datum = [];
		var cur = -1;
		var winHeight = win.height();
		var seen = -1;
		
		var reset = function () {
			seen = -1;
			cur = -1;
		};
		
		var update = function () {
			winHeight = win.height();
			items = $(o.container).find(o.itemSelector);
			datum = _.map(items, function (i) {
				i = $(i);
				return {
					offset: i.offset(),
					url: i.attr(o.urlAttribute),
					title: i.attr(o.titleAttribute)
				};
			});
		};
		
		var init = function (options) {
			o = $.extend(o, options);
			reset();
			update();
		};
		
		var scroll = function () {
			var top = win.scrollTop();
			var n = _.findLastIndex(datum, function (data) {
				return data.offset.top + winHeight * o.windowOffsetPercentage <= top;
			});
			if (n === -1) {
				return;
			}
			if (cur !== n && !!datum[n]) {
				var url = datum[n].url;
				var title = datum[n].title;
				if (!!title) {
					document.title = title;
				}
				if (!!url) {
					App.modules.notify('page.replaceState', {
						title: title || document.title,
						url: url
					});
					

					App.callback(o.change, [cur, n, url]);
					if (n > seen) {
						$.sendPageView({page: url});
					}
				}
				cur = n;
				seen = Math.max(seen, n);
			}
		};
		
		return {
			init: init,
			scroll: scroll,
			update: update,
			reset: reset
		};
	});
	
})(jQuery, window);
