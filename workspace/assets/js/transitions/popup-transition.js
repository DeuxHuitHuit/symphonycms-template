/**
 * @author Deux Huit Huit
 *
 * Popup page transition
 *
 */
(function ($, undefined) {
	
	'use strict';
	
	var win = $(window);
	var body = $('body');
	var sitePages = $('#site-pages');
	var bgTransition = $('#bg-transition');
	var bgTransitionPopup = $('#bg-transition-popup');
	var DEFAULT_DELAY = 350;
	var POPUP_SELECTOR = '.js-popup';

	var beginCompleted = false;
	var loadCompleted = false;

	var dataIn = null;
	
	/* ENTERING FUNCTIONS */
	var completeAnim = function (data, callback) {
		var leavingPage = data.currentPage;
		var enteringPage = data.nextPage;
		
		var domEnteringPage = $(enteringPage.key());
		var domLeavingPage = $(leavingPage.key());
		
		var popup = domEnteringPage.find(POPUP_SELECTOR);
		
		// Leave the current page
		leavingPage.leave(data.leaveCurrent, {
			canRemove: false
		});
		
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
			// close popup if already opened
			if (popup.hasClass('is-popup-poped')) {
				popup.addClass('noanim');
				
				App.modules.notify('popup.close', {
					popup: popup
				});
				
				popup.height();
				popup.removeClass('noanim');
			}
			
			App.modules.notify('popup.open', {
				popup: popup,
				openCallback: function () {
					domEnteringPage.css({
						opacity: 1,
						display: 'block',
						position: 'relative'
					}).height();
					enteringPage.enter(data.enterNext);
				},
				openedCallback: function () {
					App.modules.notify('transition.end', {page: enteringPage, route: data.route});
					App.callback(callback);
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
		domLeavingPage.addClass('is-bg-popup-page');

		App.modules.notify('page.leaving', {
			page: leavingPage,
			canRemove: false
		});
		
		bgTransitionPopup.fadeIn(DEFAULT_DELAY).promise().then(function () {
			beginCompleted = true;
			if (loadCompleted) {
				completeAnim(dataIn);
			}
		});
	};
	
	var defaultTransition = function (data, callback) {
		dataIn = data;
		loadCompleted = true;
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
		
		var popup = domLeavingPage.find(POPUP_SELECTOR);
		
		var isPopupReturn = domEnteringPage.hasClass('is-bg-popup-page');
		
		//Check if the enteringPage is the background page
		if (!isPopupReturn) {
			//Remove the other pages
			var oldBgPage = sitePages.find('.is-bg-popup-page');
			if (oldBgPage.length) {
				body.removeClass(oldBgPage.attr('id'));
				oldBgPage.remove();
			}
			
			//Add the new class to the body
			body.addClass(enteringPage.key().substring(1));
		}
		
		//Animate leaving and start entering after leaving animation
		//Need a delay for get all Loaded
		domEnteringPage.ready(function () {
			if (!isPopupReturn) {
				win.scrollTop(0);
			}
			
			domEnteringPage.css({opacity: 1, display: 'block'});
			body.removeClass(leavingPage.key().substring(1));
			
			App.modules.notify('page.leaving', {
				page: leavingPage,
				canRemove: true
			});
			
			//Notify intering page
			App.modules.notify('page.entering', {page: enteringPage, route: data.route});
			
			App.modules.notify('popup.close', {
				popup: popup,
				closeCallback: function () {
					App.modules.notify('site.addScroll');
				
					//Leave the current page
					leavingPage.leave(data.leaveCurrent, {
						canRemove: true
					});
					domLeavingPage.hide();

					enteringPage.enter(data.enterNext);
					App.modules.notify('transition.end', {page: enteringPage, route: data.route});
					App.callback(callback);
				}
			});
		});
	};
	
	var endLeavebegin = function () {
		beginCompleted = false;
		loadCompleted = false;
		dataIn = null;
		
		beginCompleted = true;
		if (loadCompleted) {
			completeLeaveAnim(dataIn);
		}
	};
	
	var defaultLeaveBeginTransition = function (data, callback) {
		bgTransitionPopup.fadeOut(200).promise().then(endLeavebegin);
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
