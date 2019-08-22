/**
 *  @author Deux Huit Huit
 *
 *  Recommendations module
 *
 */
(function ($, undefined) {
	
	'use strict';
	var win = $(window);
	var rateList = {};
	var SEL = '.js-recommend-ctn';
	var CON = '.js-recommend-content';
	var TEM = '.js-recommend-template';
	var RES = '.js-recommend-results';
	var CAT_ATTR = 'data-recommend-categories';
	var GRP_ATTR = 'data-recommend-group';
	var DELAY = App.debug() ? 1000 : 3000;
	var scope = $();
	var pageEnterTimeout = 0;
	var rootUrl = window.location.protocol + '//' + window.location.host;
	
	var insureArray = function (a) {
		return $.isArray(a) ? a : [a];
	};
	
	var createTemplatingObject = function (hit) {
		var category = !!hit.category ? insureArray(hit.category) : [];
		var categoryHandle = !!hit.categoryHandle ? insureArray(hit.categoryHandle) : [];
		var links = category;
		var linksHandle = categoryHandle;
		var url = hit.categoryUrl;
		return {
			title: !!hit.title ? hit.title : '',
			url: hit.url.replace(rootUrl, ''),
			links: !url ? [] : _.map(links, function (link, i) {
				return {
					url: url + linksHandle[i],
					value: link
				};
			}),
			date: !!hit.date ? hit.date : '',
			author: !!hit.author ? hit.author : '',
			img: !!hit.img ? hit.img : '',
			imgSrc: !!hit.imgSrc ? hit.imgSrc : '',
			imgJitFormat: !!hit.imgJitFormat ? hit.imgJitFormat : ''
		};
	};
	
	var comAlgolia = App.components.create('algolia-search', {
		resultsCtnSelector: RES,
		resultsContentSelector: CON,
		resultsItemTemplateSelector: TEM,
		algoliaAttributesToRetrieve: [
			'title',
			'url',
			'hightlightedContent',
			'category',
			'categoryHandle',
			'categoryUrl',
			'img',
			'imgJitFormat',
			'imgSrc',
			'rating',
			'whitelist',
			'blacklist'
		].join(','),
		algoliaAttributesToHighlight: '',
		gaCat: null, // No analytics
		recommendCallback: function (resultContent, content, o, val) {
			if (!content.nbHits && !App.debug()) {
				resultContent.closest(SEL).remove();
			}
			
			App.modules.notify('recommendations.searchCompleted');
		},
		onCreateResultsTemplatingObject: createTemplatingObject
	});
	
	var load = function () {
		var cats = _.filter((scope.attr(CAT_ATTR) || '').split(','));
		comAlgolia.init(scope);
		comAlgolia.recommend(cats, GRP_ATTR);
	};
	
	var onEnter = function (key, data, e) {
		if (!!data.page) {
			scope = $(data.page.key).find(SEL);
		} else if (!!data.article) {
			scope = $(data.article).find(SEL);
		} else {
			scope = $();
		}
		clearTimeout(pageEnterTimeout);
		pageEnterTimeout = setTimeout(load, DELAY);
	};
	
	var actions = {
		page: {
			enter: onEnter
		},
		articleChanger: {
			enter: onEnter
		}
	};
	
	var Recommendations = App.modules.exports('recommendations', {
		actions: function () {
			return actions;
		}
	});
	
})(jQuery);
