/**
 * @author Deux Huit Huit
 *
 * Auto tooltips module
 *
 * Scan certain places for words and inject a tooltip in place of the text word
 *
 */
/* jshint maxstatements:38 */
(function ($, undefined) {

	'use strict';

	var win = $(window);
	var site = $('#site');
	var page = $('.page');
	var ajaxTooltipsUrl = '/' + $('html').attr('lang') + '/ajax-tooltips/';
	
	var INITED_CLASS = 'is-tooltips-inited';
	var TOOLTIPS_TRIGGER_SELECTOR = '.js-tooltips-trigger';
	var TOOLTIPS_BUBBLE_SELECTOR = '.js-tooltips-bubble';
	var TOOLTIPS_TARGET_SELECTOR = '.js-tooltips-target';
	var TOOLTIPS_TARGET_ELEMENT_SELECTOR = 'p, li';
	var TOOLTIPS_EXCLUDED_ELEMENTS_SELECTOR = 'a, button, img, h1, h2, h3, h4, h5, h6';
	var WORD_ATTR = 'data-word';
	
	var NODE_TYPE_TEXT = 3;
	var NODE_TYPE_ELEMENT = 1;
	
	var tooltips = $();
	var ctn = $();
	var bubbles = [];
	
	var resizeTimer = 0;
	
	var track = function (action, label, value) {
		$.sendEvent('glossary', action, label, value);
	};
	
	var closeAll = function () {
		$.each(bubbles, function () {
			window.updateState($(this), false, 'tooltip');
		});
	};
	
	var calcTooltipsPosition = function (b) {
		var word = b.attr(WORD_ATTR).toLowerCase();
		var trigger = ctn.find(
			TOOLTIPS_TRIGGER_SELECTOR + '[' + WORD_ATTR + '="' + word + '"]'
		);
		var left = '';
		var top = '';
		
		if (!!trigger.length) {
			var width = b.outerWidth();
			var height = b.outerHeight();
			var offsetParent = b.offsetParent();
			
			//left position to already center the tooltip without a translate
			left = trigger.offset().left - ((width - trigger.outerWidth()) / 2);
			//on top of the word (minus arrow height)
			top = trigger.offset().top - height - 9 - offsetParent.offset().top;
			
			//check if tooltip is out of bounds
			var isOutTop = top < 0;
			var isOutLeft = left < 0;
			var isOutRight = (left + width) > win.width();
			var underTop = trigger.offset().top + trigger.outerHeight() + height;
			
			// if top is out of bounds and bottom will not be out of bounds
			// if moved, place tooltip under word
			if (isOutTop && underTop < win.height()) {
				top = underTop;
			}
			
			if (isOutLeft) {
				left = trigger.closest('div').offset().left;
			}
			
			if (isOutRight) {
				left = trigger.closest('div').offset().left - (
					width - trigger.closest('div').width()
				);
			}
			
			top = top + 'px';
			left = left + 'px';
		}
		
		b.data('fx', function () {
			b.css({
				top: top,
				left: left
			});
		});
	};
	
	var setTooltipsPosition = function (b) {
		App.callback(b.data('fx'));
		b.removeData('fx');
	};
	
	var findWordInTarget = function (word, target, tooltip) {
		var matchingPattern = new RegExp('\\b' + word + '\\b', 'ig');
		var replacePattern = new RegExp('\\b(' + word + ')\\b', 'ig');
		var nodes = target.contents();
		var wordFound = false;
		
		$.each(nodes, function () {
			var t = this;
			var nodeType = t.nodeType;
			var text = $(t).text();
			
			matchingPattern.lastIndex = 0;
			replacePattern.lastIndex = 0;
			
			if (nodeType === NODE_TYPE_TEXT && matchingPattern.test(text)) {
				var tooltipTriggerText = $('<div/>').append(
					tooltip.find(TOOLTIPS_TRIGGER_SELECTOR).clone()
				).html().replace(matchingPattern, '$1');
				var tooltipBubble = tooltip.find(TOOLTIPS_BUBBLE_SELECTOR).clone();
				var parent = $(t).parent();
				
				ctn.append(tooltipBubble);
				$(t).replaceWith(text.replace(replacePattern, tooltipTriggerText));
				parent.find('[' + WORD_ATTR + ']').attr(WORD_ATTR, word.toLowerCase());
				
				if (!!tooltipBubble.length) {
					bubbles.push(tooltipBubble);
				}
				wordFound = true;
				return false;
			} else if (nodeType === NODE_TYPE_ELEMENT &&
				!$(t).is(TOOLTIPS_EXCLUDED_ELEMENTS_SELECTOR)) {
				findWordInTarget(word, $(t), tooltip);
			}
		});
		
		return wordFound;
	};
	
	//MOUSE HOVER EVENTS
	var toggleHover = function (t, isOn) {
		var word = t.attr(WORD_ATTR).toLowerCase();
		var bubble = t.is(TOOLTIPS_BUBBLE_SELECTOR) ?
			t :
			ctn.find(TOOLTIPS_BUBBLE_SELECTOR + '[' + WORD_ATTR + '="' + word + '"]');
			
		calcTooltipsPosition(bubble);
		setTooltipsPosition(bubble);
		window.updateState(bubble, isOn, 'tooltip');
	};
	
	var onMouseenter = function () {
		var t = $(this);
		toggleHover(t, true);
		track('over', t.text());
	};
	
	var onMouseleave = function () {
		var t = $(this);
		toggleHover(t, false);
	};
	
	
	// CLICK EVENTS
	var onTriggerClick = function (e) {
		var t = $(this);
		var word = t.attr(WORD_ATTR).toLowerCase();
		var bubble = ctn.find(
			TOOLTIPS_BUBBLE_SELECTOR + '[' + WORD_ATTR + '="' + word + '"]'
		);
		
		closeAll();
		if (bubble.hasClass('is-tooltip')) {
			site.off($.click, closeAll);
		} else {
			calcTooltipsPosition(bubble);
			setTooltipsPosition(bubble);
			window.updateState(bubble, true, 'tooltip');
			site.on($.click, closeAll);
			track('click', t.text());
		}
		
		return window.pd(e);
	};
	
	var onCloseClick = function () {
		var t = $(this);
		var bubble = t.closest(TOOLTIPS_BUBBLE_SELECTOR);

		window.updateState(bubble, false, 'tooltip');
	};
	
	var initTooltips = function () {
		if (!!tooltips.length) {
			if (!ctn.hasClass(INITED_CLASS)) {
				ctn.addClass(INITED_CLASS);
				
				var targets = ctn.find(TOOLTIPS_TARGET_SELECTOR)
					.find(TOOLTIPS_TARGET_ELEMENT_SELECTOR);
					
				tooltips.each(function () {
					var tt = $(this);
					var word = tt.attr(WORD_ATTR);
					
					targets.each(function () {
						return !findWordInTarget(word, $(this), tt);
					});
				});
			}
			
			// Tooltip visible on click on touch device. otherwise, it is visible on hover
			if (!!$.touch) {
				ctn.on(
					App.device.events.click, 'button' + TOOLTIPS_TRIGGER_SELECTOR, onTriggerClick
				);
			} else {
				ctn.on(
					'mouseenter',
					'button' + TOOLTIPS_TRIGGER_SELECTOR + ', ' + TOOLTIPS_BUBBLE_SELECTOR,
					onMouseenter
				);
				ctn.on(
					'mouseleave',
					'button' + TOOLTIPS_TRIGGER_SELECTOR + ', ' + TOOLTIPS_BUBBLE_SELECTOR,
					onMouseleave
				);
			}
		}
	};

	var pageEnter = function (key, data) {
		page = $(data.page.key());
		ctn = !!page.find('.js-article').length ? page.find('.js-article') : page;
		initTooltips();
	};

	var onArticleEntering = function (key, data) {
		ctn = $(data.article);
		initTooltips();
	};
	
	var onResize = function () {
		window.craf(resizeTimer);

		resizeTimer = window.raf(closeAll);
	};
	
	var destroy = function () {
		if (!!$.touch) {
			ctn.off(App.device.events.click, 'button' + TOOLTIPS_TRIGGER_SELECTOR, onTriggerClick);
			site.off($.click, closeAll);
		} else {
			ctn.off(
				'mouseenter',
				'button' + TOOLTIPS_TRIGGER_SELECTOR + ', ' + TOOLTIPS_BUBBLE_SELECTOR,
				onMouseenter
			);
			ctn.off(
				'mouseleave',
				'button' + TOOLTIPS_TRIGGER_SELECTOR + ', ' + TOOLTIPS_BUBBLE_SELECTOR,
				onMouseleave
			);
		}
		closeAll();
		ctn = $();
		$.each(bubbles, function () {
			$(this).remove();
		});
		bubbles = [];
	};
	
	var loadTooltips = function () {
		window.Loader.load({
			url: ajaxTooltipsUrl,
			success: function (data) {
				tooltips = $($(data).find('result').html());
				initTooltips();
			},
			error: function () {
				App.log('Failed loading tooltips');
			}
		});
	};
	
	var init = function () {
		setTimeout(loadTooltips, 3000);
	};

	var actions = function () {
		return {
			site: {
				resize: onResize
			},
			page: {
				enter: pageEnter,
				leaving: destroy
			},
			articleChanger: {
				entering: onArticleEntering,
				leaving: destroy
			},
			decisionTree: {
				nodeLoaded: function (key, data) {
					destroy();
					ctn = $(data.item);
					initTooltips();
				}
			}
		};
	};

	var autoTooltips = App.modules.exports('auto-tooltips', {
		init: init,
		actions: actions
	});

})(jQuery);
