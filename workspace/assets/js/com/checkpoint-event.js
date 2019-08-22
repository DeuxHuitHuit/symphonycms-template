/**
 * @author Deux Huit Huit
 *
 * Checkpoint event
 *  Sends a analytic event when a certain gate is reached.
 */

(function ($, win, undefined) {

	'use strict';

	var defaults = {
		checkPoints: [0, 25, 50, 75, 90, 100],
		category: 'Scroll',
		action: 'scroll',
		checkPointReached: $.noop
	};

	App.components.exports('checkpoint-event', function (options) {
		var o = $.extend({}, defaults, options);
		var gate = 0;
		var enabled = true;

		var track = function (perc) {
			if (!enabled) {
				return;
			}
			if ($.isNumeric(o.checkPoints[gate]) &&
				$.isNumeric(perc) && o.checkPoints[gate] <= perc) {
				var action = o.action + ' ' + o.checkPoints[gate] + '%';
				var label = o.label || action;
				if (o.category) {
					$.sendEvent(o.category, action, label, o.checkPoints[gate]);
				}
				App.callback(o.checkPointReached, [gate, o.checkPoints[gate]]);
				gate++;
			}
		};
		
		var reset = function () {
			gate = 0;
		};
		
		var enable = function () {
			enabled = true;
		};
		
		var disable = function () {
			enabled = false;
		};
		
		var init = function (options) {
			o = $.extend(o, options);
			reset();
		};
		
		return {
			init: init,
			track: track,
			reset: reset,
			enable: enable,
			disable: disable
		};
	});

})(jQuery, jQuery(window));
