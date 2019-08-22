/**
 *  @author Deux Huit Huit
 *
 *  Cloudflare email
 *      Integration of the cloudflare email security behavior in the framework automatically
 *
 *  SELECTOR:
 *      a[href^="/cdn-cgi/l/email-protection"]
 *
 *  ACTIONS:
 *      page.enter
 *      articleChanger.enter
 */
(function ($, str, undefined) {

	'use strict';
	var SELECTOR = 'a[href^="/cdn-cgi/l/email-protection"]';
	var PATTERN = /^\[email([\u0080-\u00FF ]+)protected\]$/i;

	var process = function (a, e) {
		var j,c,s = '';

		var r = parseInt(a.substr(0, 2), 16);

		if (r) {
			for (j = 2; j < a.length; j += 2) {
				c = parseInt(a.substr(j, 2), 16) ^ r;
				s += String.fromCharCode(c);
			}

			e.attr('href', 'mailto:' + s);
			e.find('script').remove();
			
			var span = e.find('.__cf_email__');

			if (!!span.length) {
				e = span;
			}

			if (PATTERN.test(str.trim(e.text()))) {
				e.text(s);
			}
		}
	};

	var doIt = function () {
		$(SELECTOR).each(function (i, e) {
			try {
				e = $(e);
				var a = e.attr('data-cfemail');

				if (!a) {
					a = e.attr('href').split('#')[1];
				}

				if (a && a.indexOf('?') !== -1) {
					a = a.split('?')[0];
				}

				if (a) {
					process(a, e);
				}
			} catch (ex) {
				App.log(ex);
			}
		});
	};

	var actions = function () {
		return {
			page: {
				enter: doIt
			},
			articleChanger: {
				enter: doIt
			}
		};
	};
	
	App.modules.exports('cloudflare-email', {
		actions: actions
	});
	
})(jQuery, window.s, window);
