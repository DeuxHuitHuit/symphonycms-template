/**
 *  @author Deux Huit Huit
 *
 *  Auto toggle class on scroll
 */
(function ($, global, undefined) {
	
	'use strict';
	
	var win = $(window);
	var winHeight = win.height();
	var html = $('html');
	var htmlHeight = html.height();
	var site = $('#site');
	var elements = $();
	var curPage = $();

	var SELECTOR = '.js-auto-toggle-class-on-scroll';

	var ATTR_PREFIX = 'data-toggle-class-on-scroll-';

	var ATTR_ADD_BEFORE = ATTR_PREFIX + 'add-before';
	var ATTR_REM_BEFORE = ATTR_PREFIX + 'rem-before';
	var ATTR_ADD_AFTER = ATTR_PREFIX + 'add-after';
	var ATTR_REM_AFTER = ATTR_PREFIX + 'rem-after';
	var ATTR_REF_COMMON_ANCESTOR = ATTR_PREFIX + 'ref-common-ancestor';
	var ATTR_REF = ATTR_PREFIX + 'ref';
	var ATTR_SCREEN_OFFSET = ATTR_PREFIX + 'screen-offset';
	var ATTR_CTN = ATTR_PREFIX + 'scroll-ctn';
	var ATTR_ELEMENT_OFFSET = ATTR_PREFIX + 'element-offset';

	var scroll = function () {
		htmlHeight = html.height();
		elements.each(function () {
			var t = $(this);
			
			var clab = t.attr(ATTR_ADD_BEFORE);
			var clrb = t.attr(ATTR_REM_BEFORE);
			
			var claa = t.attr(ATTR_ADD_AFTER);
			var clra = t.attr(ATTR_REM_AFTER);
			
			var ref = $(t.attr(ATTR_REF));

			if (!!t.attr(ATTR_REF_COMMON_ANCESTOR)) {
				ref = t.closest(t.attr(ATTR_REF_COMMON_ANCESTOR))
					.find(t.attr(ATTR_REF));
			}
			

			var reelRef = ref.length ? ref : t;
			var screenOffset = t.attr(ATTR_SCREEN_OFFSET) || 0;

			var scrollCtn = win;
			
			if (!!t.attr(ATTR_CTN)) {
				scrollCtn = t.closest('.page').find(t.attr(ATTR_CTN));
			}

			var scrollPos = scrollCtn.scrollTop();

			if (!!reelRef.length) {
				var fx = function () {
					t.addClass(clab);
					t.removeClass(clrb);
					
					App.mediator.notify('autoToggleClassOnScroll.executed', {
						item: t,
						trigger: 'before',
						addedClass: clab,
						removeClass: clrb
					});
				};
				
				var refOffset = reelRef.offset().top;
				var screenOffsetInPx = winHeight * screenOffset;
				var elementOffsetInPx = 0;
				if (!!t.attr(ATTR_ELEMENT_OFFSET)) {
					site.find(t.attr(ATTR_ELEMENT_OFFSET)).each(function () {
						elementOffsetInPx += $(this).outerHeight();
					});
				}
				
				if (refOffset - screenOffsetInPx - elementOffsetInPx < scrollPos ||
					(!ref.length && // reference is itself
						scrollPos !== 0 && // we have scrolled
						scrollPos === htmlHeight - winHeight && // scrolled to end
						refOffset >= scrollPos // element is below
					)
				) {
					fx = function () {
						t.addClass(claa);
						t.removeClass(clra);
						
						App.mediator.notify('autoToggleClassOnScroll.executed', {
							item: t,
							trigger: 'after',
							addedClass: claa,
							removeClass: clra
						});
					};
				}
				t.data('autoToggleClassOnScroll', fx);
			}
		});
	};

	var scrollTimer = null;
	
	var postscroll = function () {
		window.craf(scrollTimer);
		scrollTimer = window.raf(function () {
			elements.each(function () {
				var t = $(this);
				App.callback(t.data('autoToggleClassOnScroll'));
			});
		});
	};
	
	var resizeOnly = function () {
		winHeight = Math.max(1, win.height());
		htmlHeight = Math.max(1, html.height());
	};

	var resize = function () {
		resizeOnly();
		scroll();
		postscroll();
	};

	var refreshElementsList = function () {
		elements = site.find(SELECTOR);
	};
	
	var enter = function (key, data) {
		
		curPage = $(data.page.key());
		//Check if we have other Scroll to follow
		/*curPage.find('.js-popup-inner-scroll').on('scroll', function () {
			scroll();
			postscroll();
		});*/

		refreshElementsList();
		resizeOnly();
		setTimeout(resize, 500);
	};

	var leave = function (key, data) {
		//curPage.find('.js-popup-inner-scroll').off('scroll');
	};

	var refreshAndRun = function () {
		refreshElementsList();
		scroll();
		postscroll();
	};
	
	var actions = function () {
		return {
			site: {
				scroll: scroll,
				postscroll: postscroll,
				resize: resize
			},
			page: {
				enter: enter,
				leave: leave
			},
			infiniteScroll: {
				pageLoaded: refreshElementsList
			},
			articleChanger: {
				enter: refreshAndRun
			},
			search: {
				complete: refreshAndRun
			}
		};
	};
	
	var AutoFadeOnScroll = App.modules.exports('auto-toggle-class-on-scroll', {
		actions: actions
	});
	
})(jQuery, window);
