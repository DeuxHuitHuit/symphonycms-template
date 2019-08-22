/**
 *  @author Deux Huit Huit
 *
 *  Module Slide
 *
 *
 *  ATTRIBUTES :
 *      (OPTIONAL)
 *      - data-{state}-state-add-class : List of class added when state goes on
 *      - data-{state}-state-rem-class : List of class removed when state goes on
 *
 *      - data-{state}-state-follower : List of selector separated by ','
 *      - data-{state}-state-follower-common-ancestor (if not present: this will be used)
 *
 *      - data-{state}-state-notify-on: custom list of notification separated by ','
 *             called when switching state to on. Data passed : {item:this}
 *      - data-{state}-state-notify-off: custom list of notification separated by ','
 *             called when switching state to off. Data passed : {item:this}
 *
 *  NOTIFY IN :
 *      - slide.update
 *          {item,state,flag}
 *
 *
 *  NOTIFY OUT :
 *      - changeState.begin
 *          {item,state,flag}
 *      - changeState.end
 *          {item,state,flag}
 *
 */
(function ($, undefined) {
	
	'use strict';
	var win = $(window);

	var processItem = function (item, state, action, callbacks) {
		var flagClass = 'is-' + state;
		var curBoolState = item.hasClass(flagClass);
		var dur = item.attr('data-' + state + '-state-slide-duration') || 300;
		var onCallback = item.attr('data-' + state + '-state-notify-on-callback');

		callbacks = callbacks ? callbacks : {};

		if (action === 'toggle') {
			// set flag class
			App.modules.notify('changeState.update', {
				item: item,
				state: state,
				action: 'toggle'
			});
			
			var fx = !!curBoolState ? 'slideUp' : 'slideDown';
			
			item.stop(true, false)[fx](dur, function () {
				item.css({
					overflow: '',
					height: '',
					marginTop: '',
					marginBottom: '',
					paddingTop: '',
					paddingBottom: ''
				});
				
				if (fx === 'slideDown' && !!onCallback) {
					App.mediator.notify(onCallback, {
						item: item
					});
				}
			});
		} else if (action === 'up') {
			if (!!curBoolState) {
				// set flag class
				App.modules.notify('changeState.update', {
					item: item,
					state: state,
					action: 'off'
				});
				
				item.stop(true, false).slideUp(dur, function () {
					item.css({
						overflow: '',
						height: '',
						marginTop: '',
						marginBottom: '',
						paddingTop: '',
						paddingBottom: ''
					});
				});
			}
		} else if (action === 'down') {
			if (!curBoolState) {
				// set flag class
				App.modules.notify('changeState.update', {
					item: item,
					state: state,
					action: 'on'
				});
				
				item.stop(true, false).slideDown(dur, function () {
					item.css({
						overflow: '',
						height: '',
						marginTop: '',
						marginBottom: '',
						paddingTop: '',
						paddingBottom: ''
					});
					
					App.mediator.notify(onCallback, {
						item: item
					});
				});
			}
		} else {
			App.log('Action: ' + action +
				' is not recognized: Actions available are : toggle, up, down');
		}
	};

	var onUpdateState = function (key, data) {
		if (data && data.item && data.state && data.action) {
			var minWidth = data.item.attr('data-' + data.state + '-state-min-width');
			var maxWidth = data.item.attr('data-' + data.state + '-state-max-width');
			var isMinWidthValid = (!!minWidth && window.mediaQueryMinWidth(minWidth)) || !minWidth;
			var isMaxWidthValid = (!!maxWidth && window.mediaQueryMaxWidth(maxWidth)) || !maxWidth;
			
			if (isMinWidthValid && isMaxWidthValid) {
				processItem(data.item, data.state, data.action, data.callbacks);
			}
		}
	};
	
	var actions = function () {
		return {
			slide: {
				update: onUpdateState
			}
		};
	};
	
	App.modules.exports('slide', {
		actions: actions
	});
	
})(jQuery);
