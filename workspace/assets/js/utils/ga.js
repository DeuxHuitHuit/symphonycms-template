/**
 * @author Deux Huit Huit
 *
 * Google Analytics wrapper
 */

(function ($) {
	'use strict';
	
	var html = $('html');
	var lang = html.attr('lang');
	
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
		App.log({args: ['%cga(' + args.join(',') + ');', 'color:cornflowerblue']});
	};
	
	var getGa = function () {
		/* jshint ignore:start */
		if (!!window.dataLayer && !!window.dataLayer.push) {
			return function ga (gaAction, gaCat, cat, action, label, value, options, category) {
				if (gaCat === 'pageview') {
					dataLayer.push($.extend({}, cat, {
						event: gaCat,
						page: {
							requestURI: cat.page || cat.location,
							page: cat.page,
							location: cat.location,
							language: lang,
							referer: document.referrer,
							title: document.title
						}
					}));
				} else if (gaCat === 'event') {
					var args = {
						event: gaCat,
						eventCategory: category || cat,
						eventAction: action,
						eventLabel: label,
						eventValue: value,
						eventOptions: options
					};
					if ($.isPlainObject(cat)) {
						args = $.extend(true, {}, args, cat);
						args.eventCategory = args.eventCategory || args.event;
						args.event = gaCat;
					}
					dataLayer.push(args);
				}
			};
		}
		/* jshint ignore:end */
		return window.ga || log;
	};
	
	// ga facilitators
	$.sendPageView = function (opts) {
		var ga = getGa();
		var defaults = {
			page: window.location.pathname + window.location.search,
			location: window.location.href,
			hostname: window.location.hostname
		};
		var args = !opts ? defaults : $.extend(defaults, opts);
		if ($.isFunction($.formatPage)) {
			args.page = $.formatPage(args.page);
		}
		if ($.isFunction($.formatLocation)) {
			args.location = $.formatLocation(args.location);
		}
		if (!html.filter('[data-no-ga]').length) {
			ga('send', 'pageview', args);
		} else {
			log('sendPageView bypassed by attribute');
		}
	};
	
	/* jshint maxparams:6 */
	$.sendEvent = function (cat, action, label, value, options, category) {
		var ga = getGa();
		cat = cat || '';
		options = cat.options || options || {nonInteraction: 1};
		if (!html.filter('[data-no-ga]').length) {
			ga('send', 'event', cat, action, label, value, options, category);
		} else {
			log('sendEvent bypassed by attribute');
		}
	};
	/* jshint maxparams:5 */
	
	var getTextValue = function (t, key) {
		return t.attr(key) || undefined;
	};

	$.fn.sendClickEvent = function (options) {
		options = options || {};
		var t = $(this).eq(0);
		var send = true;

		var setMinimalOptions = function () {
			if (!options.action) {
				options.action = 'click';
			}

			if (!options.label) {
				options.label = $.trim(t.text());
			}

			if (!!options.event) {
				if (!options.event.gaHandled) {
					options.event.gaHandled = true;
				} else {
					send = false;
				}
			}
		};

		setMinimalOptions();
		if (!send) {
			return;
		}
		
		var o = $.extend({}, options, {
			cat: getTextValue(t, 'data-ga-cat'),
			category: getTextValue(t, 'data-ga-category'),
			action: getTextValue(t, 'data-ga-action'),
			label: getTextValue(t, 'data-ga-label'),
			value: parseInt(t.attr('data-ga-value'), 10) || undefined
		});

		var detectError = function () {
			if (!o.cat) {
				App.log({fx: 'err', args: 'No ga-cat found. Cannot continue.'});
				send = false;
			}
			
			if (!o.label) {
				App.log({fx: 'warn', args: 'No ga-label found. Reverting to text'});
			}
		};

		detectError();
		
		if (!!send) {
			$.sendEvent(o.cat, o.action, o.label, o.value, undefined, o.category);
		}
	};
	
	// auto-hook
	$(function () {
		var loc = window.location;
		var origin = loc.origin || (loc.protocol + '//' + loc.hostname);
		var internalLinksExclusion = ':not([href^="' + origin + '"])';
		var externalLinks = 'a[href^="http://"]' + internalLinksExclusion +
			', a[href^="https://"]' + internalLinksExclusion;
		var mailtoLinks = 'a[href^="mailto:"]';
		var telLinks = 'a[href^="tel:"]';
		var downloadExtensions = ['pdf', 'jpg', 'jpeg', 'png', 'doc', 'docx', 'xsl', 'xslx'];
		var downloadLinks = _.map(downloadExtensions, function (ext) {
			return 'a[href$=".' + ext + '"], ';
		}).join('') + 'a[href$="?dl"], a[download]';
		var getRefLinkLabel = function (t) {
			var url = $(t).attr('href');
			if (!url) {
				return undefined;
			}
			url = url.replace(/^mailto:/, '');
			url = url.replace(/^tel:/, '');
			url = url.replace(origin, '');
			return url;
		};
		$('#site')
		.on(App.device.events.click, externalLinks, function (e) {
			$(this).sendClickEvent({
				cat: 'link-external',
				label: getRefLinkLabel(this),
				event: e
			});
		})
		.on(App.device.events.click, downloadLinks, function (e) {
			$(this).sendClickEvent({
				cat: 'link-download',
				label: getRefLinkLabel(this),
				event: e
			});
		})
		.on(App.device.events.click, mailtoLinks, function (e) {
			$(this).sendClickEvent({
				cat: 'link-mailto',
				label: getRefLinkLabel(this),
				event: e
			});
		})
		.on(App.device.events.click, telLinks, function (e) {
			$(this).sendClickEvent({
				cat: 'link-tel',
				label: getRefLinkLabel(this),
				event: e
			});
		})
		.on(App.device.events.click, '[data-ga-cat]', function (e) {
			$(this).sendClickEvent({
				event: e
			});
		});
		if ($('body').hasClass('page-404')) {
			$.sendEvent('erreur 404', 'erreur 404', document.referrer);
		}
	});
	
})(jQuery);
