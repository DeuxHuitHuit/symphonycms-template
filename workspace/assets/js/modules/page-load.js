/**
 *  @author Deux Huit Huit
 *
 *  Page load
 *      Allow animating a progress bar during ajax request.
 *      Use load progress if available, reverts to good old timer if not.
 *
 */
(function ($, undefined) {

	'use strict';
	
	var INITIAL_VALUE = 0.30; // 30%
	var INCREMENT = 0.05; // 5%
	var CLOSE_DELAY = 500; // ms
	var START_DELAY = 300; // ms
	var PROGRESS_DELAY = 150; //ms
	
	var LOADING = 'page-loading';
	var SHOW = 'show';
	var START = 'start';
	var END = 'end';
	
	var html = $();
	var holder = $();
	
	var isStarted = false;
	
	var closeTimer = 0;
	var currentValue = 0;
	var progressTimer = 0;
	
	var p = function (i) {
		return ~~(i * 100) + '%';
	};
	
	var progress = function (percent) {
		clearTimeout(progressTimer);
		if (isStarted) {
			// increment current value
			var incVal = currentValue + INCREMENT;
			// use percent if greater then new incremented value
			currentValue = Math.max(incVal, percent || currentValue);
			// max out current value to 1
			currentValue = Math.min(currentValue, 1);
			// update ui
			holder.width(p(currentValue));
			// if we are running with the timer (not percent given)
			// block before hitting 100%
			if (!percent && currentValue < 1 - INCREMENT) {
				progressTimer = setTimeout(progress, PROGRESS_DELAY);
			}
		}
		App.log({
			fx: 'info',
			args: ['Progress %s %s', percent || 'timer', currentValue],
			me: 'page-load'
		});
	};
	
	var start = function () {
		clearTimeout(closeTimer);
		
		currentValue = INITIAL_VALUE;
		
		holder
			.removeClass(END)
			.removeClass(SHOW)
			.removeClass(START)
			.width(p(0))
			.height();
		holder
			.addClass(START)
			.addClass(SHOW)
			.width(p(currentValue))
			.height();
		
		html.addClass(LOADING);
		
		isStarted = true;
		
		App.log({fx: 'info', args: 'Start', me: 'page-load'});
		
		setTimeout(progress, START_DELAY);
	};
	
	var end = function () {
		holder
			.addClass(END)
			.width('100%');
			
		isStarted = false;
		
		closeTimer = setTimeout(function () {
			holder.removeClass(SHOW);
			html.removeClass(LOADING);
		}, CLOSE_DELAY);
		
		App.log({fx: 'info', args: 'End', me: 'page-load'});
	};
	
	var loadprogress = function (key, data) {
		progress(data.percent);
	};
	
	var actions = function () {
		return {
			pageLoad: {
				start: start,
				progress: loadprogress,
				end: end
			},
			pages: {
				loading: start,
				loadfatalerror: end,
				loadprogress: loadprogress,
				loaded: end,
				notfound: end
			}
		};
	};
	
	var init = function () {
		html = $('html');
		holder = $('#load-progress');
	};
	
	var PageLoad = App.modules.exports('page-load', {
		init: init,
		actions: actions
	});
	
})(jQuery);
