/**
 *  @author Deux Huit Huit
 *
 *  Auto sync property
 *      Allow to set local property with an external element target by the source attribute.
 *      The value will be keep it in sync with the element on each resize of the window and
 *      in each pageEnter.
 *
 *  JS Selector :
 *      .js-auto-sync-property:
 *
 *  DATA ATTRIBUTES :
 *      REQUIRED
 *
 *      - data-sync-property :
 *          : Property to change on the element
 *
 *      - data-sync-property-from :
 *          : JQuery Selector to identify the element used to read the value.
 *          : By default will use a scope from the #site element
 *          : (see common ancestor for alternative selection)
 *
 *      OPTIONAL :
 *
 *      - data-sync-property-with :
 *          : Property to read if different than the set property
 *
 *      - data-sync-property-from-common-ancestor :
 *          : To specify a closer scope between the target and the current element.
 *          : Will find the scope with
 *          :     element.closest({value}).find({from})
		 - data-sync-property-aggregate :
 *          : To specify the aggregate function the the module will do.
 			  If empty, it will take the value of the first item it found.
 			  The available aggregates are:
 			  	- sum: get summation of all values
 			  	- min: get smallest value
 			  	- max: get biggest value
 *
 */
(function ($, undefined) {
	
	'use strict';
	var win = $(window);
	var site = $('#site');
	
	var ITEM_SELECTOR = '.js-auto-sync-property';
	var PROPERTY_ATTR = 'data-sync-property';
	var WITH_PROPERTY_ATTR = 'data-sync-property-with';
	var SOURCE_ATTR = 'data-sync-property-from';
	var COMMON_ANCESTOR_ATTR = 'data-sync-property-from-common-ancestor';
	var AGGREGATE_ATTR = 'data-sync-property-aggregate';
	
	var getPropertyValue = function (source, property) {
		var value = 0;
		
		if (property == 'height') {
			// Ensure to get not rounded value from jquery
			value = Math.floor(parseFloat(window.getComputedStyle(source[0]).height));
		} else if (property == 'outerHeight-full') {
			value = source.outerHeight(true);
		} else if (property == 'outerWidth-full') {
			value = source.outerWidth(true);
		} else {
			value = source[property]();
		}
		
		return value;
	};
	
	var processItem = function (t) {
		var property = t.attr(PROPERTY_ATTR);

		if (!!property) {
			var sourceSelector = t.attr(SOURCE_ATTR);
			var commonAncestorSelector = t.attr(COMMON_ANCESTOR_ATTR);
			var withProperty = t.attr(WITH_PROPERTY_ATTR);
			var scope = site;
			var source = null;
			var aggregate = t.attr(AGGREGATE_ATTR);

			if (!!commonAncestorSelector) {
				if (commonAncestorSelector == 'self') {
					scope = t;
				} else {
					scope = t.closest(commonAncestorSelector);
				}
			}

			if (!!scope.length) {
				source = scope.find(sourceSelector);
			}

			// Use property if no with property specified
			if (!withProperty) {
				withProperty = property;
			}

			if (source.length) {
				var value;
				
				if (aggregate == 'sum') {
					value = 0;
					source.each(function () {
						value += getPropertyValue($(this), withProperty);
					});
				} else if (aggregate == 'min') {
					value = _.reduce(source, function (memo, current) {
						var curVal = getPropertyValue($(current), withProperty);
						if (curVal < memo) {
							return curVal;
						}
						return memo;
					}, getPropertyValue(source.first(), withProperty));
					
				} else if (aggregate == 'max') {
					value = _.reduce(source, function (memo, current) {
						var curVal = getPropertyValue($(current), withProperty);
						if (curVal > memo) {
							return curVal;
						}
						return memo;
					}, 0);
				} else {
					value = getPropertyValue(source.first(), withProperty);
				}
				
				t.css(property, value);
			}
		}
	};

	var processAllItems = function () {
		site.find(ITEM_SELECTOR).each(function (i, e) {
			var t = $(this);
			processItem(t);
		});
	};

	var onResize = function () {
		processAllItems();
	};

	var onPageEnter = function () {
		processAllItems();
		setTimeout(processAllItems, 50);
	};
	
	var init = function () {
		processAllItems();
	};
	
	var actions = function () {
		return {
			site: {
				resize: onResize
			},
			page: {
				enter: onPageEnter
			},
			articleChanger: {
				enter: onPageEnter
			},
			autoSyncProperty: {
				update: processAllItems
			}
		};
	};
	
	App.modules.exports('auto-sync-property', {
		init: init,
		actions: actions
	});
	
})(jQuery);
