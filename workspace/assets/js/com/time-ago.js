/**
 * @author Deux Huit Huit
 *
 * Time Ago
 *
 */
(function ($, w, doc, undefined) {

	'use strict';
	
	// French
	if ($('html').attr('lang') == 'fr') {
		jQuery.timeago.settings.strings = {
			// environ ~= about, it's optional
			prefixAgo: 'Publié il y a',
			prefixFromNow: 'd\'ici',
			seconds: 'moins d\'une minute',
			minute: 'environ une minute',
			minutes: 'environ %d minutes',
			hour: 'une heure',
			hours: '%d heures',
			day: 'un jour',
			days: '%d jours',
			month: 'un mois',
			months: '%d mois',
			year: 'un an',
			years: '%d ans'
		};
	}
	
	/* Time Ago */
	App.components.exports('timeAgo', function timeAgo () {
		
		var page;
		var NB_JOURS = 30 * 24 * 60 * 60 * 1000;
		
		var init = function (p) {
			page = p;
			$('time.js-time-ago').each(function (i, e) {
				var t = $(this);
				var d = new Date(t.attr('datetime'));
				if (new Date().getTime() - d.getTime() < NB_JOURS) {
					t.timeago();
				}
			});
		};
		
		return {
			init: init
		};
	
	});
	
})(jQuery, window, document);
