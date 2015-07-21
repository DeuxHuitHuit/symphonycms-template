/**
 * @author Deux Huit Huit
 *
 * Google Analytics wrapper
 */

(function ($) {
	'use strict';
	
	var log = function () {
		var args = [];
		$.each(arguments, function (i, a) {
			if ($.isPlainObject(a)) {
				a = JSON.stringify(a, null, 2);
			} else {
				a = '"' + a + '"';
			}
			args.push(a);
		});
		App.log({args: ['%cga(' + args.join(',') + ');', 'color:green']});
	};
	
	// ga facilitators
	$.sendPageView = function (opts) {
		var ga = window.ga || log;
		var defaults = {
			page: window.location.pathname + window.location.search,
			location: window.location.href,
			hostname: window.location.hostname
		};
		var args = !opts ? defaults : $.extend(defaults, opts);
		
		ga('send', 'pageview', args);
	};
	
	$.sendEvent = function (cat, action, label, value, options) {
		var ga = window.ga || log;
		ga('send', 'event', cat, action, label, value, options || {nonInteraction: 1});
	};
	
	$.fn.sendClickEvent = function (options) {
		options = options || {};
		var t = $(this).eq(0);
		if (!options.action) {
			options.action = 'click';
		}
		if (!options.label) {
			options.label = t.text();
		}
		var o = $.extend({}, options, {
			cat: t.attr('data-ga-cat'),
			action: t.attr('data-ga-action'),
			label: t.attr('data-ga-label'),
			value: parseInt(t.attr('data-ga-value'), 10) || undefined
		});
		if (!o.cat) {
			App.log('No ga-cat found. Cannot continue.');
			return;
		}
		if (!o.label) {
			App.log('No ga-label found. Reverting to text');
		}
		$.sendEvent(o.cat, o.action, o.label, o.value);
	};
	
	// auto-hook
	$(function () {
		$('#site').on($.click, '*[data-ga-cat]', function (e) {
			$(this).sendClickEvent({
				cat: 'click'
			});
		});
	});
	
})(jQuery);