/**
 *  @author Deux Huit Huit
 *
 *  Auto ratio size
 */
(function ($, undefined) {
	
	'use strict';
	
	var win = $(window);
	var site;
	var sitePages;
	
	var getPage = function () {
		return $('> .page:visible', sitePages);
	};
	
	var parseRatio = function (ratio) {
		if (!ratio) {
			return 1;
		}
		var r = ratio.toString().split(/[:\/]/i);
		if (!r.length) {
			return 1;
		} else if (r.length === 1) {
			return parseFloat(r[0]);
		} else if (r.length === 2) {
			return parseInt(r[0], 10) / (parseInt(r[1], 10) || 1);
		}
		return -1;
	};
	
	var defaultCallback = function () {
		App.mediator.notifyCurrentPage('autoRatio.resizeCompleted');
	};
	
	var updateElements = function (elements, callback) {
		elements.each(function () {
			var t = $(this);
			var r = parseRatio(t.attr('data-auto-ratio'));
			var fx = t.attr('data-auto-ratio-property') || 'height';
			var val;
			
			if (fx == 'width' || fx == 'max-width') {
				val = t.height();
			} else {
				val = t.width();
			}
			val = ~~Math.floor(val / r);
			
			t.css(fx, val + 'px');
			
			$('img[data-src-format]', t).jitImage();
		});
		
		App.callback(callback);
	};
	
	var onResize = function () {
		updateElements($('*[data-auto-ratio]', getPage()), defaultCallback);
	};
	
	var onPageEnter = function () {
		onResize();
	};
	
	var update = function (key, data) {
		if (data && data.elements) {
			updateElements(
				data.elements,
				(data.callback ? data.callback : defaultCallback)
			);
		} else {
			onResize();
		}
	};
	
	var init = function () {
		site = $('#site');
		sitePages = $('#site-pages', site);
		onResize();
	};
	
	var actions = function () {
		return {
			site: {
				resize: onResize
			},
			page: {
				enter: onPageEnter
			},
			autoRatioSize: {
				update: update
			},
			articleChanger: {
				enter: onPageEnter
			}
		};
	};
	
	App.modules.exports('auto-ratio-size', {
		init: init,
		actions: actions
	});
	
})(jQuery);
