/**
 * @author Deux Huit Huit
 *
 * Article Changer
 *
 */
(function ($, w, doc, undefined) {

	'use strict';

	var animToArticleDefault = function (current, next, o) {
		

		if (!!current.length) {
			var ctn = current.closest(o.containerSelector);
			ctn.css({
				minHeight: current.height() + 'px'
			});
			
			current.fadeTo(500, 0, function () {
				current.hide();

				if (o.scrollToTop) {
					App.mediator.notify('window.scrollTop', {
						animated: false
					});
				}

				App.mediator.notify('articleChanger.entering', {
					article: next,
					ctn: ctn
				});
				
				next.fadeTo(500, 1, function () {
					ctn.css({
						minHeight: ''
					});
				});
				
				setTimeout(function () {
					o.articleEnter(current, next, o);
				}, 100);
			});
		} else {
			next.fadeTo(500, 1);
			o.articleEnter(current, next, o);
		}
	};
	
	var appendDefault = function (articleCtn, dataLoaded, pageHandle, o) {
		var article = o.findArticle(dataLoaded, pageHandle, o);
		article.hide();
		articleCtn.append(article);
		return article;
	};
	
	var findArticleDefault = function (articleCtn, pageHandle, o) {
		pageHandle = pageHandle || '';
		var selector = o.articleSelector +
			(o.trackHandle ? '[data-handle="' + pageHandle + '"]' : '');
		return $(selector, $(articleCtn));
	};
	
	var defOptions = {
		articleSelector: '.js-article',
		containerSelector: '.js-article-ctn',
		findArticle: findArticleDefault,
		appendArticle: appendDefault,
		animToArticle: animToArticleDefault,
		trackHandle: true,
		scrollToTop: false,
		articleEnter: function (oldItem, newItem, o) {
			if (!o.trackHandle) {
				oldItem.remove();
			}
			App.mediator.notify('articleChanger.enter', {
				article: newItem
			});
		}
	};
	
	App.components.exports('articleChanger', function articleChanger () {
		var o;
		var page;
		var articleCtn;
		var currentPageHandle;
		
		var init = function (p, options) {
			page = p;
			o = $.extend({}, defOptions, options);
			articleCtn = $(o.containerSelector, page);
			currentPageHandle = o.startPageHandle;
		};
		
		var navigateTo = function (newPageHandle, url) {
			var currentPage = o.findArticle(articleCtn, currentPageHandle, o);
			var loadUrl = url || window.location.href;
			var loadSucess = function (dataLoaded, textStatus, jqXHR) {
				//Append New article
				var nextPage = o.appendArticle(articleCtn, dataLoaded, newPageHandle, o);
				var loc = window.location;
				var cleanUrl = loc.href.substring(loc.hostname.length + loc.protocol.length + 2);
				
				App.mediator.notify('pageLoad.end');
				App.mediator.notify('articleChanger.loaded', {
					url: cleanUrl,
					data: dataLoaded
				});
				
				if (!nextPage.length) {
					App.log({
						args: 'Could not find new article',
						fx: 'error',
						me: 'Article Changer'
					});
				} else {
					o.animToArticle(currentPage, nextPage, o);
				}
			};

			if (!o.trackHandle || currentPageHandle !== newPageHandle) {
				
				var nextPage;
				if (o.trackHandle) {
					nextPage = o.findArticle(articleCtn, newPageHandle, o);
				}
				
				// LoadPage
				if (!nextPage || !nextPage.length) {
					App.mediator.notify('pageLoad.start', {page: page});
					App.loader.load({
						url: loadUrl,
						priority: 0, // now
						vip: true, // bypass others
						success: loadSucess,
						progress: function (e) {
							var total = e.originalEvent.total;
							var loaded = e.originalEvent.loaded;
							var percent = total > 0 ? loaded / total : 0;
							
							App.mediator.notify('pageLoad.progress', {
								event: e,
								total: total,
								loaded: loaded,
								percent: percent
							});
						},
						error: function () {
							App.mediator.notify('article.loaderror');
							App.mediator.notify('pageLoad.end');
						},
						giveup: function (e) {
							App.mediator.notify('pageLoad.end');
						}
					});
					
				} else {
					o.animToArticle(currentPage, nextPage, o);
				}
				
				currentPageHandle = newPageHandle;
			}
		};
		
		return {
			init: init,
			clear: function () {
				currentPageHandle = '';
			},
			navigateTo: navigateTo
		};
	
	});
	
})(jQuery, window, document);
