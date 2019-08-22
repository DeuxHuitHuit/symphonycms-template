/**
 * @author Deux Huit Huit
 *
 * Modal page to modal page transition
 *
 */
(function ($, undefined) {
	
	'use strict';
	
	var win = $(window);
	var body = $('body');
	var sitePages = $('#site-pages');
	var bgTransition = $('#bg-transition');
	var bgTransitionModal = $('#bg-transition-modal');
	var MODAL_SELECTOR = '.js-modal-page';

	var beginCompleted = false;
	var loadCompleted = false;

	var dataIn = null;
	
	/* ENTERING FUNCTIONS */
	var completeAnim = function (data, callback) {
		var leavingPage = data.currentPage;
		var enteringPage = data.nextPage;
		
		var domEnteringPage = $(enteringPage.key());
		var domLeavingPage = $(leavingPage.key());
		
		var modal = domEnteringPage.find(MODAL_SELECTOR);
		
		// Leave the current page
		leavingPage.leave(data.leaveCurrent, {
			canRemove: false
		});
		
		// Make the page hidden for assistive technology
		domLeavingPage.attr('aria-hidden', 'true').attr('role', 'presentation');
		domEnteringPage.removeAttr('aria-hidden').removeAttr('role');
		
		//deactivate toggles in enter modal
		domEnteringPage.find('a[data-action="toggle"]')
			.removeAttr('data-action')
			.attr('href', domLeavingPage.attr('data-response-url'));
				
		// Add body class
		body.addClass(enteringPage.key().substring(1));
		
		// Notify entering page
		App.modules.notify('page.entering', {page: enteringPage, route: data.route});
		
		// Animate leaving and start entering after leaving animation
		// Need a delay for get all Loaded
		domEnteringPage.ready(function () {
			domLeavingPage.hide();
			// close modal if already opened
			App.modules.notify('modal.prepare', {
				item: modal
			});
			domEnteringPage.css({
				opacity: 1,
				display: 'block',
				position: 'relative'
			}).height();
			enteringPage.enter(data.enterNext);
			App.modules.notify('modal.show', {
				item: modal,
				callback: function () {
					App.modules.notify('transition.end', {page: enteringPage, route: data.route});
					App.callback(callback);
					
					App.modules.notify('transition.finished', {
						page: enteringPage,
						route: data.route
					});
				}
			});
		});
	};
	
	var defaultBeginTransition = function (data) {
		var leavingPage = data.currentPage;
		var domLeavingPage = $(leavingPage.key());
		var callback = function () {
			beginCompleted = true;
			if (loadCompleted) {
				completeAnim(dataIn);
			}
		};
		
		beginCompleted = false;
		loadCompleted = false;
		dataIn = null;
		
		App.modules.notify('site.removeScroll');

		App.modules.notify('page.leaving', {
			page: leavingPage,
			canRemove: false
		});
		App.modules.notify('modal.isBgVisible', {});
		
		var modal = domLeavingPage.find(MODAL_SELECTOR);
		
		App.modules.notify('modal.hide', {
			item: modal,
			callback: callback
		});
	};
	
	var defaultTransition = function (data, callback) {
		dataIn = data;
		loadCompleted = true;
		App.modules.notify('site.removeScroll');
		if (beginCompleted) {
			completeAnim(data, callback);
		}
	};
	
	/*App.transitions.exports({
		from: 'page-search',
		to: 'page-actions',
		beginTransition: defaultBeginTransition,
		transition: defaultTransition,
		canAnimate: function (data) {
			return true;
		}
	});

	App.transitions.exports({
		from: 'page-actions',
		to: 'page-search',
		beginTransition: defaultBeginTransition,
		transition: defaultTransition,
		canAnimate: function (data) {
			return true;
		}
	});*/
	
})(jQuery);