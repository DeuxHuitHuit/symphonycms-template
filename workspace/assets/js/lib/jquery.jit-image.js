/*! jQuery JIT image - v1.3.1 - build 16 - 2014-12-12
* https://github.com/DeuxHuitHuit/jQuery-jit-image
* Copyright (c) 2014 Deux Huit Huit (https://deuxhuithuit.com/);
* Licensed MIT */
/*
 *  jQuery JIT image v1.2.1 - jQuery plugin
 *
 *  Copyright (c) 2013-2014 Deux Huit Huit (http://www.deuxhuithuit.com/)
 *  Licensed under the MIT LICENSE
 *  (https://raw.github.com/DeuxHuitHuit/jQuery-jit-image/master/LICENSE.txt)
 */
(function ($, defaultSelector, dataAttribute, undefined) {
	
	'use strict';
	
	// old jquery fix
	$.fn.on = $.fn.on || $.fn.bind;
	$.fn.off = $.fn.off || $.fn.unbind;
	
	var win = $(window);
	
	var instances = $();
	
	var DATA_KEY = 'jitImageOptions';
	
	var getValue = function (obj) {
		if ($.isFunction(obj)) {
			return obj.call(this);
		}
		return obj;
	};
	
	// assure params values
	dataAttribute = dataAttribute || 'data-src-format';
	defaultSelector = defaultSelector || 'img[' + getValue(dataAttribute) + ']';
	
	var loader = (function createLoader() {
		var queue = [];
		var active = 0;
		
		var checkTimeout = 0;
		var lastDirtyCheck = $.now();
		
		var processQueue = function () {
			var shouldProcess = function () {
				return !!queue.length && (active < queue[0].limit || !active);
			};
			
			if (!shouldProcess() && active > 0 && lastDirtyCheck < $.now() - 100) {
				// check for dead elements
				var newQueue = [];
				$.each(queue, function (i, q) {
					var dead = !q.elem.closest(document).length;
					if (dead) {
						active = Math.max(0, active - 1);
					} else {
						newQueue.push(q);
					}
				});
				queue = newQueue;
				lastDirtyCheck = $.now();
			}
			
			while (shouldProcess()) {
				var cur = queue.shift();
				// increment must be done before since
				// the update call may call .done already
				active++;
				cur.update();
			}
			
			checkTimeout = 0;
		};
		
		var checkQueue = function () {
			if (!checkTimeout) {
				checkTimeout = setTimeout(processQueue, 0);
			}
		};
		
		var push = function (job) {
			var found = false;
			$.each(queue, function (index, j) {
				// elem is already in the queue
				if (j.elem.is(job.elem)) {
					// replace old job with new one
					queue[index] = job;
					found = true;
					return found;
				}
			});
			if (!found) {
				queue.push(job);
			}
			checkQueue();
		};
		
		var done = function (elem, args) {
			if (active > 0) {
				active--;
			}
			checkQueue();
		};
		
		return {
			push: push,
			done: done,
			check: checkQueue,
			count: function () {
				return queue.length;
			},
			active: function () {
				return active;
			},
			queue: function () {
				return queue;
			}
		};
	})();
	
	var forceEvenValue = function (value) {
		return value + (value % 2);
	};
	
	var _getSize = function (o) {
		var size = {
			width: ~~o.container.width(),
			height: ~~o.container.height()
		};
		
		if (!!o.forceEvenSize) {
			size.width = forceEvenValue(size.width);
			size.height = forceEvenValue(size.height);
		}
		
		return size;
	};
	
	var _set = function (t, size, url, o) {
		if (!!t && !!size) {
			if (!!o.forceCssResize && !!size.width) {
				t.attr('width', size.width).width(size.width);
			} else {
				t.removeAttr('width').width('');
			}
			
			if (!!o.forceCssResize && !!size.height) {
				t.attr('height', size.height).height(size.height);
			} else {
				t.removeAttr('height').height('');
			}
			
			var unregisterEvents = function () {
				return t.off('load.jitImage')
					.off('error.jitImage');
			};
			
			var callbackCreator = function (err) {
				return function (e) {
					unregisterEvents();
					var args = [size, e, err];
					if (!!o.parallelLoadingLimit) {
						loader.done(t, args);
					}
					if ($.isFunction(o.load)) {
						o.load.apply(t, args);
					}
					t.trigger('loaded.jitImage', args);
				};
			};
			
			if (!!url && t.attr('src') !== url) {
				// register for load
				unregisterEvents()
					.on('load.jitImage', callbackCreator(false))
					.on('error.jitImage', callbackCreator(true));
				// load it
				t.attr('src', url);
				return true;
			}
		}
		return false;
	};
	
	var _getUrlFromFormat = function (t, o, size) {
		var format = t.attr(getValue(o.dataAttribute));
		var urlFormat = {
			url: format,
			height: false,
			width: false,
			formatted: false
		};
		if (!!format) {
			if (!o.bypassDefaultFormat) {
				$.each(['width', 'height'], function (i, value) {
					var pattern = o[value + 'Pattern'];
					urlFormat[value] = pattern.test(format);
					if (urlFormat[value] && size[value] !== undefined) {
						format = format.replace(pattern, ~~(size[value] * o.devicePixelRatio));
					}
				});
				
				urlFormat.url = format;
				urlFormat.formatted = urlFormat.width || urlFormat.height;
			}
			
			if ($.isFunction(o.format)) {
				o.format.call(t, urlFormat, o, size);
			}
		}
		return urlFormat;
	};
	
	var _update = function (t, o) {
		var success = false;
		if (!!o && !!t) {
			var size = o.size(o);
			var urlFormat = _getUrlFromFormat(t, o, size);
			var urlFormatSuccess = !!urlFormat && !!urlFormat.url;
			var sizeSucces = !!size && (size.height > 0 || size.width > 0);
			
			if (urlFormatSuccess && sizeSucces) {
				// fix for aspect ratio scaling
				// Only pass the size value if it was matched
				size.width = urlFormat.width ? size.width : false;
				size.height = urlFormat.height ? size.height : false;
				// set the image's url and css
				success = o.set(
					t,
					size,
					urlFormat.url,
					o
				);
				
				if (success && $.isFunction(o.updated)) {
					o.updated.call(t, urlFormat, o, size);
				}
			}
		}
		// remove from loader if not load was started
		if (!success && !!o.parallelLoadingLimit) {
			loader.done(t, [null, null, true]);
		}
	};
	
	var _updateAll = function () {
		$.each(instances, function _resize(index, element) {
			var $el = $(element);
			var data = $el.data(DATA_KEY);
			var visible = $el.is(':visible');
			var update = function () {
				_update($el, data);
			};
			
			if (!data) {
				return;
			}
			
			// No limit
			if (!data.parallelLoadingLimit) {
				// cancel any pending timeouts
				clearTimeout(data.jitTimeout);
				
				if (!!_defaults.nonVisibleDelay && !visible) {
					data.jitTimeout = setTimeout(update, _defaults.nonVisibleDelay);
				} else {
					update();
				}
			}
			// Limit concurrents image loading
			else {
				loader.push({
					elem: $el,
					visible: visible,
					update: update,
					limit: data.parallelLoadingLimit
				});
			}
		});
		// re-register event
		_registerOnce();
	};
	
	var eventTimer = null;
	
	var updateOnEvent = function (e) {
		clearTimeout(eventTimer);
		eventTimer = setTimeout(_updateAll, _defaults.eventTimeout);
	};
	
	var _defaults = {
		container: null,
		dataAttribute: dataAttribute, // can also be function
		defaultSelector: defaultSelector,
		containerDataAttribute: 'data-container', // can also be function
		size: _getSize,
		set: _set,
		widthPattern: /\$w/i,
		heightPattern: /\$h/i,
		updateEvents: 'resize orientationchange',
		eventTimeout: 50,
		load: null, // function (size, e, err)
		nonVisibleDelay: 1000,
		forceCssResize: true,
		parallelLoadingLimit: 0,
		format: null, // function (urlFormat, o, size)
		bypassDefaultFormat: false,
		updated: null, // function (urlFormat, o, size)
		forceEvenSize: false,
		useDevicePixelRatio: true,
		devicePixelRatio: 1
	};
	
	var _registerOnce = function () {
		win.one(_defaults.updateEvents, updateOnEvent);
	};
	
	$.jitImage = {
		remove: function (t) {
			// remove DATA
			t.data(DATA_KEY, null);
			// removes from instances
			instances = instances.not(t);
		},
		defaults: _defaults,
		_getSize: _getSize,
		_set: _set,
		_getUrlFromFormat: _getUrlFromFormat,
		loader: loader
	};
	
	$.fn.jitImage = function (options) {
		var t = $(this);
		
		var _each = function (index, element) {
			var t = $(element);
			// re-use old options if they exists
			var oldOptions = t.data(DATA_KEY) || {};
			var o = $.extend({}, _defaults, oldOptions, options);
			var containerAttribute = getValue(o.containerDataAttribute);
			var container = !!containerAttribute ? t.attr(containerAttribute) : null;
			var parentContainer = !!container ? 
					t.closest(container) : 
					!t.parent().length ? t : t.parent();
			
			// insure container
			// do it here since elements may have
			// different parents
			o.container = !!o.container ? $(o.container) : parentContainer;
			
			// save device pixel ratio
			if (o.useDevicePixelRatio) {
				o.devicePixelRatio = (window.devicePixelRatio || 
					window.webkitDevicePixelRatio || 1);
			}
			
			// save options
			t.data(DATA_KEY, o);
			
			var update = function () {
				_update(t, o);	
			};
			
			// No limit
			if (!o.parallelLoadingLimit) {
				// update attributes
				update();
			}
			// Limit concurents image loading
			else {
				loader.push({
					elem: t,
					visible: true,
					update: update,
					limit: o.parallelLoadingLimit
				});
			}
		};
		
		// flatten our element array
		instances = instances.add(t);
		
		// hook up each element
		return t.each(_each);
	};
	
	// Use data attribute to automatically hook up nodes
	win.load(function init() {
		if (!!_defaults.defaultSelector) {
			$(_defaults.defaultSelector).jitImage();
		}
		_registerOnce();
	});
	
})(jQuery, window.jitImageSelector, window.jitImageDataAttribute);