/**
 *  @author Deux Huit Huit
 *
 *  Auto share this
 *
 */
(function ($, undefined) {
	
	'use strict';
	
	var win = $(window);
	var site = $('#site');
	
	var getCurrentUrl = function () {
		var docLoc = window.location;
		return docLoc.protocol + '//' + docLoc.host + docLoc.pathname;
	};
	
	var attachBtn = function (btn) {
		
		App.modules.notify('shareThis.applyButton', {
			service: btn.attr('data-share-service') || 'sharethis',
			title: btn.attr('data-share-title') || document.title,
			url: btn.attr('data-share-url') || getCurrentUrl(),
			type: btn.attr('data-share-type') || 'large',
			element: btn.eq(0)[0]
		});
	};
	
	var autoAttach = function (key, data) {
		$('.js-share-this-btn').each(function () {
			attachBtn($(this));
		});
	};
	
	var init = function () {
	
	};
	
	var actions = {
		articleChanger: {
			enter: autoAttach
		},
		page: {
			enter: autoAttach
		}
	};
	
	App.modules.exports('autoShareThis', {
		init: function () {},
		actions: function () {
			return actions;
		}
	});
	
})(jQuery);
