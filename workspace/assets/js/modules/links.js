/**
 *  @author Deux Huit Huit
 *
 *  Links modules
 *     Makes all external links added into the dom load in a new page
 *     Makes all internal links mapped to the mediator
 *
 *  ACTIONS
 *      pages.loaded
 *
 */
(function ($, undefined) {
	
	'use strict';
	var loc = window.location;
	var origin = loc.origin || (loc.protocol + '//' + loc.hostname);
	var originRegExp = new RegExp('^' + origin, 'i');
	var otherLangs = (function () {
		var h = $('html');
		var l = h.attr('lang');
		if (!l) {
			return null;
		}
		var d = h.attr('data-all-langs');
		if (!d) {
			return null;
		}
		var validLang = function (lang) {
			return !!lang && lang !== l;
		};
		var createRegxp = function (lang) {
			return new RegExp('^\/' + lang + '\/.*$', 'i');
		};
		return _.map(_.filter(d.split(','), validLang), createRegxp);
	})();
	
	var mustIgnore = function (t, e) {
		// ignore click since there are no current page
		if (!App.mediator.getCurrentPage()) {
			return true;
		}

		var href = t.attr('href');
		if (href === undefined) {
			return true;
		}

		// ignore click since it's not http
		if (/^(mailto|skype|tel|fax|ftps?|#)/im.test(href)) {
			return true;
		}

		// no keys on the keyboard
		if (!!e.metaKey || !!e.ctrlKey) {
			return true;
		}
		return false;
	};
	
	var onClickGoto = function (e) {
		var t = $(this);
		var href = t.attr('href');
		var testRegexp = function (r) {
			return r.test(href);
		};
		
		// basic validity
		if (mustIgnore(t, e)) {
			return true;
		}
		
		// query string only href
		if (/^\?.+/.test(href)) {
			href = window.location.pathname + href;
		}

		// full absolute url
		if (originRegExp.test(href)) {
			href = href.replace(originRegExp, '');
		}

		// other language url
		if (!!otherLangs && _.some(_.map(otherLangs, testRegexp))) {
			return true;
		}

		App.mediator.notify('links.gotoClicked', {
			item: t,
			url: href
		});
		
		App.mediator.goto(href);
		
		return window.pd(e);
	};
	
	var onClickToggle = function (e) {
		var t = $(this);
		var href = t.attr('href');
		var fallback = t.attr('data-toggle-fallback-url');
		
		if (mustIgnore(t, e)) {
			return true;
		}
		
		App.mediator.notify('links.toggleClicked', {
			item: t,
			url: href,
			fallback: fallback
		});
		
		App.mediator.toggle(href, fallback);
		
		return window.pd(e);
	};
	
	var init = function () {
		var workspaceExclusion = ':not([href^="/workspace"])';
		var dataAttrExclusions = ':not([data-action="full"])' +
			':not([data-action="toggle"])' +
			':not([data-action="none"])';
		var localLinks = 'a[href^="' + origin + '"]';
		var localWorkspaceExclusion = ':not(a[href^="' + origin + '/workspace"])';
		var toggleLinks = '[data-action="toggle"]';
		var absoluteLinks = 'a[href^="/"]';
		var queryStringLinks = 'a[href^="?"]';
		var click = App.device.events.click;

		// capture all click in #site
		$('#site')
			.on(click, absoluteLinks + workspaceExclusion + dataAttrExclusions, onClickGoto)
			.on(click, queryStringLinks + workspaceExclusion + dataAttrExclusions, onClickGoto)
			.on(click, localLinks + dataAttrExclusions + localWorkspaceExclusion, onClickGoto)
			.on(click, absoluteLinks + toggleLinks, onClickToggle)
			.on(click, queryStringLinks + toggleLinks, onClickToggle);
	};
	
	var Links = App.modules.exports('links', {
		init: init
	});
	
})(jQuery);
