/**
 * @author Deux Huit Huit
 *
 * Article Changer
 *
 */
(function ($, w, doc, undefined) {

	'use strict';
	var startAnimToArticleDefault = function (current, next, o, callback) {
		if (!!current.length) {
			var ctn = current.closest(o.containerSelector);
			ctn.css({
				minHeight: current.height() + 'px'
			});
			current.fadeTo(500, 0, function () {
				current.hide();
				callback(current, next, o);
			});
		} else {
			callback(current, next, o);
		}
	};

	var endAnimToArticleDefault = function (current, next, o) {
		var ctn = next.closest(o.containerSelector);
		if (o.scrollToTop) {
			App.mediator.notify('window.scrollTop', {
				animated: false
			});
		}

		App.mediator.notify('articleChanger.entering');
		next.fadeTo(500, 1, function () {
			o.articleEnter(current, next, o);
			ctn.css({
				minHeight: ''
			});
		});
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
		startAnimToArticle: startAnimToArticleDefault,
		endAnimToArticle: endAnimToArticleDefault,
		trackHandle: true,
		twoStepAnim: true,
		scrollToTop: false,
		articleEnter: function (oldItem, newItem, o) {
			if (!o.trackHandle) {
				oldItem.remove();
			}
			App.mediator.notify('articleChanger.enter', {
				item: newItem,
				article: newItem
			});
		}
	};

	App.components.exports('articleChanger', function articleChanger () {
		var o;
		var page;
		var articleCtn;
		var currentPageHandle;
		var isLoading = false;
		var isAnimating = false;
		var loadingUrl = '';

		var checkStartAnimAnd = function (current, next, o) {
			isAnimating = false;
			if (!isLoading) {
				//Complete anim
				o.endAnimToArticle(current, next, o);
			}
		};

		var init = function (p, options) {
			page = p;
			o = $.extend({}, defOptions, options);
			articleCtn = $(o.containerSelector, page);
			currentPageHandle = o.startPageHandle;
		};

		var loadUrl = '';

		var navigateTo = function (newPageHandle, url) {
			var currentPage = o.findArticle(articleCtn, currentPageHandle, o);
			loadUrl = url || window.location.href;

			/* jshint latedef:false */
			var loadSuccess = function (dataLoaded, textStatus, jqXHR) {
				//Append New article
				isLoading = false;
				if (loadUrl === loadingUrl) {
					var nextPage = o.appendArticle(articleCtn, dataLoaded, newPageHandle, o);
					var loc = window.location;
					var cleanUrl = loc.href.substring(
						loc.hostname.length +
						loc.protocol.length + 2
					);
					
					App.mediator.notify('pageLoad.end');
					App.mediator.notify('articleChanger.loaded', {url: cleanUrl, data: dataLoaded});
					
					if (!nextPage.length) {
						App.log({
							args: 'Could not find new article',
							fx: 'error',
							me: 'Article Changer'
						});
					} else {
						if (o.twoStepAnim && !isAnimating) {
							o.endAnimToArticle(currentPage, nextPage, o);
						} else {
							o.startAnimToArticle(currentPage, nextPage, o, checkStartAnimAnd);
						}
					}
				} else {
					//Launch again loading
					load();
				}
			};

			var load = function () {
				if (!isLoading) {
					App.mediator.notify('pageLoad.start', {page: page});
					isLoading = true;
					loadingUrl = loadUrl;

					App.loader.load({
						url: loadUrl,
						priority: 0, // now
						vip: true, // bypass others
						success: loadSuccess,
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
						error: function (jqXHR) {
							App.mediator.notify('pageLoad.end');
							isLoading = false;

							App.mediator.notify('articleChanger.loaderror', {
								jqXHR: jqXHR
							});
						},
						giveup: function (e) {
							App.mediator.notify('pageLoad.end');
							isLoading = false;
							App.log('Article changer load giveup');
						}
					});
				}
			};
			/* jshint latedef:true */

			if (!o.trackHandle || currentPageHandle !== newPageHandle) {
				
				var nextPage;
				if (o.trackHandle) {
					nextPage = o.findArticle(articleCtn, newPageHandle, o);
				}
				
				// LoadPage
				if (!nextPage || !nextPage.length) {
					if (o.twoStepAnim) {
						isAnimating = true;
						o.startAnimToArticle(currentPage, nextPage, o, checkStartAnimAnd);
					}
					load();
				} else {
					o.startAnimToArticle(currentPage, nextPage, o, checkStartAnimAnd);
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
