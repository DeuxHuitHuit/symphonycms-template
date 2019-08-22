/**
 * @author Deux Huit Huit
 *
 * Modal page transition
 *
 */
(function ($, undefined) {
	
	'use strict';
	
	var win = $(window);
	var body = $('body');
	var sitePages = $('#site-pages');
	var bgTransition = $('#bg-transition');
	var bgTransitionModal = $('#bg-transition-modal');
	var DEFAULT_DELAY = 350;
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
		
		//deactivate toggles in enter modal
		domEnteringPage.find('a[data-action="toggle"]')
			.removeAttr('data-action')
			.attr('href', domLeavingPage.attr('data-response-url'));
		
		// Make the page hidden for assistive technology
		domLeavingPage.attr('aria-hidden', 'true').attr('role', 'presentation');
		domEnteringPage.removeAttr('aria-hidden').removeAttr('role');
		
		// Add body class
		body.addClass(enteringPage.key().substring(1));
		
		// Notify entering page
		App.modules.notify('page.entering', {page: enteringPage, route: data.route});
		
		// Animate leaving and start entering after leaving animation
		// Need a delay for get all Loaded
		domEnteringPage.ready(function () {
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
		
		beginCompleted = false;
		loadCompleted = false;
		dataIn = null;
		
		App.modules.notify('site.removeScroll');
		domLeavingPage.addClass('is-bg-modal-page');

		App.modules.notify('page.leaving', {
			page: leavingPage,
			canRemove: false
		});
		
		App.modules.notify('modal.showBg', {
			callback: function () {
				beginCompleted = true;
				if (loadCompleted) {
					completeAnim(dataIn);
				}
			}
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
	
	/* LEAVING FUNCTIONS */
	var completeLeaveAnim = function (data, callback) {
		var leavingPage = data.currentPage;
		var enteringPage = data.nextPage;
		
		var domEnteringPage = $(enteringPage.key());
		var domLeavingPage = $(leavingPage.key());
		
		var modal = domLeavingPage.find(MODAL_SELECTOR);
		
		var isModalReturn = domEnteringPage.hasClass('is-bg-modal-page');
		
		// Leave the current page
		leavingPage.leave(data.leaveCurrent, {
			canRemove: true
		});
		
		// Make the page hidden for assistive technology
		domLeavingPage.attr('aria-hidden', 'true').attr('role', 'presentation');
		domEnteringPage.removeAttr('aria-hidden').removeAttr('role');
		
		//Check if the enteringPage is the background page
		if (!isModalReturn) {
			//Remove the other pages
			var oldBgPage = sitePages.find('.is-bg-modal-page');
			if (oldBgPage.length) {
				body.removeClass(oldBgPage.attr('id'));
				oldBgPage.remove();
			}
			
			//Add the new class to the body
			body.addClass(enteringPage.key().substring(1));
		}
		
		// Notify entering page
		App.modules.notify('page.entering', {page: enteringPage, route: data.route});
		
		domEnteringPage.ready(function () {
			domLeavingPage.hide();
			domEnteringPage.css({
				opacity: 1,
				display: 'block',
				position: 'relative'
			}).height();
			enteringPage.enter(data.enterNext);
			
			App.modules.notify('modal.hideBg', {
				callback: function () {
					App.modules.notify('transition.end', {page: enteringPage, route: data.route});
					App.modules.notify('site.addScroll');
					App.modules.notify('transition.finished', {
						page: enteringPage,
						route: data.route
					});
				}
			});
			
			App.callback(callback);
		});
	};
	
	var defaultLeaveBeginTransition = function (data, callback) {
		var leavingPage = data.currentPage;
		var domLeavingPage = $(leavingPage.key());
		var modal = domLeavingPage.find(MODAL_SELECTOR);
		
		beginCompleted = false;
		loadCompleted = false;
		dataIn = null;
		
		App.modules.notify('modal.hide', {
			item: modal,
			callback: function () {
				body.removeClass(leavingPage.key().substring(1));
				App.modules.notify('page.leaving', {
					page: leavingPage,
					canRemove: true
				});
				
				beginCompleted = true;
				
				if (loadCompleted) {
					completeLeaveAnim(dataIn);
				}
			}
		});
	};
	
	var defaultLeaveTransition = function (data, callback) {
		loadCompleted = true;
		dataIn = data;
		if (beginCompleted) {
			completeLeaveAnim(data, callback);
		}
	};
	
	/*App.transitions.exports({
		from: 'page-search',
		beginTransition: defaultLeaveBeginTransition,
		transition: defaultLeaveTransition,
		canAnimate: function (data) {
			return true;
		}
	});

	App.transitions.exports({
		to: 'page-search',
		beginTransition: defaultBeginTransition,
		transition: defaultTransition,
		canAnimate: function (data) {
			return true;
		}
	});*/
	
})(jQuery);