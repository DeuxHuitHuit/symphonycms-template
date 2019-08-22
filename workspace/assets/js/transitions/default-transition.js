/**
 * @author Deux Huit Huit
 *
 * Default page transition
 *
 */
(function ($, undefined) {
	
	'use strict';
	
	var win = $(window);
	var body = $('body');
	var DEFAULT_DELAY = 90;
	var beginCompleted = false;
	var loadCompleted = false;

	var dataIn = null;
	
	var completeAnim = function (data, callback) {
		var bgTransition = $('#bg-transition', body);
		var leavingPage = data.currentPage;
		var enteringPage = data.nextPage;
		
		var domEnteringPage = $(enteringPage.key());
		var domLeavingPage = $(leavingPage.key());
		
		// Leave the current page
		leavingPage.leave(data.leaveCurrent, {
			canRemove: true
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
			domLeavingPage.hide();
			domEnteringPage.css({opacity: 1, display: 'block'});
			win.scrollTop(0);
			enteringPage.enter(data.enterNext);

			bgTransition.fadeOut(DEFAULT_DELAY).promise().then(function () {
				App.modules.notify('transition.end', {page: enteringPage, route: data.route});
				App.mediator.notify('site.addScroll');
			});
			
			App.callback(callback);
		});
	};
	
	var defaultBeginTransition = function (data) {
		var bgTransition = $('#bg-transition', body);
		var leavingPage = data.currentPage;
		
		beginCompleted = false;
		loadCompleted = false;
		dataIn = null;
		bgTransition.fadeIn(DEFAULT_DELAY).promise().then(function () {
			//notify all module from leaving
			body.removeClass(leavingPage.key().substring(1));
			App.modules.notify('page.leaving', {
				page: leavingPage,
				canRemove: true
			});
			
			beginCompleted = true;
			
			if (loadCompleted) {
				completeAnim(dataIn);
			}
		});
	};
	
	var defaultTransition = function (data, callback) {
		loadCompleted = true;
		dataIn = data;
		if (beginCompleted) {
			completeAnim(data, callback);
		}
	};
	
	App.transitions.exports({
		beginTransition: defaultBeginTransition,
		transition: defaultTransition,
		canAnimate: function (data) {
			return true;
		}
	});
	
})(jQuery);
