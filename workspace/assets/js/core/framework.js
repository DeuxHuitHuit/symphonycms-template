/*! framework.js - v2.0.0 - a82fa7cd51 - build 165 - 2019-05-30
 * https://github.com/DeuxHuitHuit/framework.js
 * Copyright (c) 2019 Deux Huit Huit (https://deuxhuithuit.com/);
 * MIT *//**
 * Actions
 *
 * @fileoverview Defines the App Actions
 *
 * @author Deux Huit Huit <https://deuxhuithuit.com>
 * @license MIT <https://deuxhuithuit.mit-license.org>
 *
 * @requires jQuery
 * @namespace App.actions
 */
(function ($, global, undefined) {
	'use strict';
	var keys = {};
	var innerCall = false;
	var stack = [];

	/**
	 * Find the methods that matches with the notify key
	 * @name resolve
	 * @memberof App.actions
	 * @method
	 * @param {Function|Object} actions Object of methods that can be matches with the key's value
	 * @param {String} key Action key
	 * @param {Object} data Bag of data
	 * @returns {Function} The function corresponding to the key, if it exists in actions object
	 * @private
	 */
	var resolve = function (actions, key, data) {
		if ($.isFunction(actions)) {
			actions = actions();
		}
		if (!!actions) {
			// Try the whole key
			var tempFx = actions[key];
			// If not, try JSONPath style...
			if (!$.isFunction(tempFx)) {
				var paths = keys[key] || key.split('.');
				if (paths.length < 2) {
					return;
				}
				keys[key] = paths;
				tempFx = actions;
				$.each(paths, function eachPath () {
					tempFx = tempFx[this];
					if (!$.isPlainObject(tempFx)) {
						return false; // exit
					}
					return true;
				});
			}
			if ($.isFunction(tempFx)) {
				return tempFx;
			}
		}
	};

	/**
	 * Executes all read and write operations present in the actions array.
	 * @name execute
	 * @memberof App.actions
	 * @method
	 * @param {Array} actions Array of read/write objects
	 * @param {String} key Action key
	 * @param {Object} data Bag of data
	 * @returns {undefined}
	 * @private
	 */
	var execute = function (actions, key, data, cb) {
		var sp = 0;
		var outerCall = false;
		var read = function (f) {
			if ($.isFunction(f.read)) {
				f.read(key, data);
			}
		};
		var write = function (f) {
			f.write(key, data);
		};
		if (!innerCall) {
			innerCall = true;
			outerCall = true;
		}
		if (!$.isArray(actions)) {
			actions = [actions];
		}
		if ($.isFunction(data) && !cb) {
			cb = data;
			data = undefined;
		}
		// Push all resolved actions to the stack
		actions.forEach(function eachAction (a, index) {
			var retValue = App.callback(a, [key, data]);
			if (!!cb && retValue !== undefined) {
				App.callback(cb, [index, retValue]);
			}
			if ($.isFunction(retValue)) {
				retValue = {
					read: null,
					write: retValue
				};
			}
			if ($.isPlainObject(retValue) && $.isFunction(retValue.write)) {
				if (App.debug() && !retValue.key) {
					retValue.key = key;
				}
				stack.push(retValue);
			}
		});
		// If outerCall, empty the stack
		while (outerCall && stack.length > sp) {
			// Capture current end
			var sLen = stack.length;
			// Process current range only
			for (var x = sp; x < sLen; x++) {
				read(stack[x]);
			}
			for (x = sp; x < sLen; x++) {
				write(stack[x]);
			}
			// Advance the stack pointer
			sp = sLen;
		}
		if (outerCall) {
			// clean up
			innerCall = false;
			stack = [];
		}
	};

	/** Public Interfaces **/
	global.App = $.extend(true, global.App, {
		/**
		 * @namespace actions
		 * @memberof App
		 */
		actions: {
			/**
			 * Find the methods that matches with the notify key
			 * @name resolve
			 * @memberof App.actions
			 * @method
			 * @param {Function|Object} actions Object of methods that can be matches
			 *   with the key's value
			 * @param {String} key Action key
			 * @param {Object} data Bag of data
			 * @returns {Function} The function corresponding to the key, if it exists
			 * @public
			 */
			resolve: resolve,

			/**
			 * Executes all read and write operations present in the actions array.
			 * @name execute
			 * @memberof App.actions
			 * @method
			 * @param {Array} actions Array of read/write objects
			 * @param {String} key Action key
			 * @param {Object} data Bag of data
			 * @returns {undefined}
			 * @public
			 */
			execute: execute,

			/**
			 * @name stack
			 * @memberof App.actions
			 * @method
			 * @returns {Array} All the operations currently in the stack.
			 *   Stack operations can already be executed but still in the stack.
			 * @public
			 */
			stack: function () {
				return stack;
			}
		}
	});
})(jQuery, window);

/**
 * App Callback functionnality
 *
 * @fileoverview Defines and exports callback
 *
 * @author Deux Huit Huit <https://deuxhuithuit.com>
 * @license MIT <https://deuxhuithuit.mit-license.org>
 *
 * @namespace callback
 * @memberof App
 * @requires App
 */
(function ($, global, undefined) {
	'use strict';
	
	/**
	 * Put the args value in a array if it isn't one already
	 * @name argsToArray
	 * @method
	 * @memberof callback
	 * @param {*} args
	 * @return {Array}
	 * @private
	 */
	var argsToArray = function (args) {
		var isNull = (args === null);
		var isNotUndefined = (args !== undefined);
		var isNotAnArray = !$.isArray(args);
		var noLength = !!args && !$.isNumeric(args.length);
		var isString = $.type(args) === 'string';
		var isjQuery = !!args && !!args.jquery;
		
		if (isNull || (isNotUndefined && isNotAnArray && (noLength || isString || isjQuery))) {
			// put single parameter inside an array
			args = [args];
		}
		return args;
	};
	
	/**
	 * Execute the method received with the arguments received.
	 * Returns what the method returned.
	 * @name callback
	 * @method
	 * @memberof callback
	 * @this App
	 * @param {function} fx
	 * @param {*} args
	 * @return {*}
	 * @private
	 */
	var callback = function (fx, args) {
		try {
			args = argsToArray(args);
			
			if ($.isFunction(fx)) {
				// IE8 does not allow null/undefined args
				return fx.apply(this, args || []);
				
			} else if ($.isPlainObject(fx)) {
				return fx;
			}
		} catch (err) {
			var stack = err.stack;
			var msg = (err.message || err) + '\n' + (stack || '');
			
			App.log({args: [msg, err], fx: 'error'});
		}
		return undefined;
	};
	
	/** Public Interfaces **/
	global.App = $.extend(true, global.App, {
		
		/**
		 * Execute the method received with the arguments received
		 * @name this
		 * @method
		 * @memberof callback
		 * @this App
		 * @param {function} fx
		 * @param {*} args
		 * @return undefined
		 * @public
		 */
		callback: callback
	});
	
})(jQuery, window);

/**
 * Components are factory method that will generate a instance of a component.
 *
 * @fileoverview Defines and exports components
 *
 * @author Deux Huit Huit <https://deuxhuithuit.com>
 * @license MIT <https://deuxhuithuit.mit-license.org>
 *
 * @namespace components
 * @memberof App
 * @requires App
 */
(function ($, global, undefined) {
	'use strict';
	
	/** Components **/
	var components = {};

	/**
	 * Create a default model of a component with an init function
	 * @name createAbstractComponent
	 * @method
	 * @memberof components
	 * @private
	 * @return {Object}
	 */
	var createAbstractComponent = function () {
		return {
			init: $.noop
		};
	};

	/**
	 * Merge the created component with the default model
	 * just to be sure there's an init method
	 * @name extendComponent
	 * @method
	 * @memberof components
	 * @param {Object} component
	 * @return {Object} component
	 * @private
	 */
	var extendComponent = function (component) {
		return $.extend(createAbstractComponent(), component);
	};

	/**
	 * Make sure the component is unique by key verification
	 * and stores it with all the other components
	 * @name exportComponent
	 * @method
	 * @memberof components
	 * @param {String} key unique identifier
	 * @param {Function} component model of the component
	 * @param {Boolean} override fake news
	 * @private
	 */
	var exportComponent = function (key, component, override) {
		if ($.type(key) !== 'string') {
			App.log({args: ['`key` must be a string', key], fx: 'error'});
		} else if (!!components[key] && !override) {
			App.log({args: ['Overwriting component key %s is not allowed', key], fx: 'error'});
		} else {
			components[key] = component;
			return component;
		}
		return false;
	};

	/**
	 * Create an instance of the component
	 * @name createComponent
	 * @method
	 * @memberof components
	 * @param {String} key unique identifier
	 * @param {Object} options object passed to the component's code
	 * @return {Object} Merged component with the default model and the actual component code
	 * @private
	 */
	var createComponent = function (key, options) {
		if (!components[key]) {
			App.log({args: ['Component %s is not found', key], fx: 'error'});
			return extendComponent({});
		}
		
		var c = components[key];
		
		if (!$.isFunction(c)) {
			App.log({args: ['Component %s is not a function', key], fx: 'error'});
			return extendComponent({});
		}
		
		return extendComponent(c.call(c, options));
	};
	
	/** Public Interfaces **/
	global.App = $.extend(true, global.App, {
		
		// Components
		components: {
			
			/**
			 * Get all components models
			 * @public
			 * @name models
			 * @method
			 * @memberof components
			 * @returns {Objects}
			 */
			models: function () {
				return components;
			},
			
			/**
			 * Create an instance of the component
			 * @name create
			 * @method
			 * @memberof components
			 * @param {String} key unique identifier
			 * @param {Object} options object passed to the component's code
			 * @return {Object} Merged component with the default model and the
			 *  actual component code
			 * @public
			 */
			create: createComponent,

			/**
			 * Make sure the component is unique by key verification
			 * and stores it with all the other components
			 * @name exports
			 * @method
			 * @memberof components
			 * @param {String} key unique identifier
			 * @param {Function} component model of the component
			 * @param {Boolean} override fake news
			 * @public
			 */
			exports: exportComponent
		}
	
	});
	
})(jQuery, window);

/**
 * App Debug and Log
 *
 * @fileoverview Defines and exports log and debug
 *
 * @author Deux Huit Huit <https://deuxhuithuit.com>
 * @license MIT <https://deuxhuithuit.mit-license.org>
 *
 * @namespace debug
 * @memberof App
 * @requires App
 */
(function ($, global, undefined) {
	'use strict';
	
	/** Debug **/
	var isDebuging = false;
	
	/**
	 * Set or get the debug flag for the App
	 * @name debug
	 * @method
	 * @memberof debug
	 * @param {Boolean=} value
	 * @private
	 */
	var debug = function (value) {
		if (value === true || value === false) {
			isDebuging = value;
		} else if (value === '!') {
			isDebuging = !isDebuging;
		}
		return isDebuging;
	};
	
	/**
	 * Format the passed arguments and the displayed message
	 * @name argsToObject
	 * @method
	 * @memberof debug
	 * @param {Object} arg
	 * @returns {Object} Formated object
	 * @private
	 */
	var argsToObject = function (arg) {
		// ensure that args is an array
		if (!!arg.args && !$.isArray(arg.args)) {
			arg.args = [arg.args];
		}
		
		// our copy
		var a = {
			args: arg.args || arguments,
			fx: arg.fx || 'warn',
			me: arg.me || 'App'
		},
		t1 = $.type(a.args[0]);
		
		if (t1 === 'string' || t1 === 'number' || t1 == 'boolean') {
			// append me before a.args[0]
			a.args[0] = '[' + a.me + '] ' + a.args[0];
		}
		return a;
	};
	
	var logs = [];

	/**
	 * Log the recived data with the appropriate effect (log, error, info...)
	 * @name log
	 * @method
	 * @memberof debug
	 * @param {Array} arg
	 * @private
	 */
	var log = function (arg) {
		// no args, exit
		if (!arg) {
			return this;
		}
		
		var a = argsToObject(arg);
		
		if (isDebuging) {
			// make sure fx exists
			if (!$.isFunction(console[a.fx])) {
				a.fx = 'log';
			}
			// call it
			if (!!window.console[a.fx].apply) {
				window.console[a.fx].apply(window.console, a.args);
			} else {
				$.each(a.args, function logArgs (index, arg) {
					window.console[a.fx](arg);
				});
			}
		}
		logs.push(a);
		
		return this;
	};
	
	/** Public Interfaces **/
	global.App = $.extend(true, global.App, {
		
		/**
		 * Set or get the debug flag for the App
		 * @name debug
		 * @method
		 * @memberof debug
		 * @param {Boolean=} value
		 * @public
		 */
		debug: debug
	});
	
})(jQuery, window);

/**
 * App device detector
 *
 * @fileoverview Analyse the user agent
 *
 * @author Deux Huit Huit <https://deuxhuithuit.com>
 * @license MIT <https://deuxhuithuit.mit-license.org>
 *
 * @namespace device
 * @memberof App
 * @requires App
 */
(function ($, global, undefined) {
	'use strict';
	
	/**
	 * Factory for the browser detector
	 * @name browserDetector
	 * @memberof device
	 * @method
	 * @returns {Object} accessible functions
	 * @private
	 */
	var browserDetector = (function () {

		/**
		 * Get the user agent
		 * @name getUserAgent
		 * @memberof device
		 * @method
		 * @param {String} userAgent
		 * @returns {String} user agent
		 * @private
		 */
		var getUserAgent = function (userAgent) {
			if (!userAgent) {
				return window.navigator.userAgent;
			}
			return userAgent;
		};
		
		/**
		 * Test the user agent with the given regular expression
		 * @name testUserAgent
		 * @memberof device
		 * @method
		 * @param {RegExp} regexp
		 * @param {String} userAgent
		 * @returns {Boolean} if the test passed or not
		 * @private
		 */
		var testUserAgent = function (regexp, userAgent) {
			userAgent = getUserAgent(userAgent);
			return regexp.test(userAgent);
		};
		
		var detector = {
		
			/**
			 * Check if the device is a mobile one and not an iPhone
			 * @name isTablet
			 * @memberof device
			 * @method
			 * @param {String} userAgent The browser user agent
			 * @returns {Boolean}
			 * @private
			 */
			isTablet: function (userAgent) {
				return detector.isMobile(userAgent) &&
					!detector.isPhone(userAgent);
			},
			
			/** @deprecated */
			isTablette: function (userAgent) {
				return this.isTablet(userAgent);
			},
			
			/**
			 * Check if the device is an iPhone or an iPad
			 * @name isIos
			 * @method
			 * @memberof device
			 * @param {String} userAgent The browser user agent
			 * @returns {Boolean}
			 * @private
			 */
			isIos: function (userAgent) {
				return detector.isIphone(userAgent) ||
					detector.isIpad(userAgent);
			},
			
			/**
			 * Check if the user agent contains the word 'iPhone' or 'iPod'
			 * @name isIphone
			 * @method
			 * @memberof device
			 * @param {String} userAgent The browser user agent
			 * @returns {Boolean}
			 * @private
			 */
			isIphone: function (userAgent) {
				return !detector.isIpad(userAgent) &&
					(testUserAgent(/iPhone/i, userAgent) || testUserAgent(/iPod/i, userAgent));
			},
			
			/**
			 * Check if the user agent contains the word 'iPad'
			 * @name isIpad
			 * @method
			 * @memberof device
			 * @param {String} userAgent The browser user agent
			 * @returns {Boolean}
			 * @private
			 */
			isIpad: function (userAgent) {
				return testUserAgent(/iPad/i, userAgent);
			},
			
			/**
			 * Check if the user agent contains the word 'Android'
			 * @name isAndroid
			 * @method
			 * @memberof device
			 * @param {String} userAgent The browser user agent
			 * @returns {Boolean}
			 * @private
			 */
			isAndroid: function (userAgent) {
				return testUserAgent(/Android/i, userAgent);
			},
			
			/**
			 * Check if the device runs on Android
			 * and the user agent contains the word 'mobile'
			 * @name isAndroidPhone
			 * @method
			 * @memberof device
			 * @param {String} userAgent The browser user agent
			 * @returns {Boolean}
			 * @private
			 */
			isAndroidPhone: function (userAgent) {
				return detector.isAndroid(userAgent) &&
					testUserAgent(/mobile/i, userAgent);
			},
			
			/**
			 * Check if the device is a phone
			 * @name isPhone
			 * @method
			 * @memberof isIphone
			 * @param {String} userAgent The browser user agent
			 * @returns {Boolean}
			 * @private
			 */
			isPhone: function (userAgent) {
				return !detector.isIpad(userAgent) && (
					detector.isOtherPhone(userAgent) ||
					detector.isAndroidPhone(userAgent) ||
					detector.isIphone(userAgent));
			},
			
			/**
			 * Check if the user agent contains the word 'phone'
			 * @name isOtherPhone
			 * @method
			 * @memberof device
			 * @param {String} userAgent The browser user agent
			 * @returns {Boolean}
			 * @private
			 */
			isOtherPhone: function (userAgent) {
				return testUserAgent(/phone/i, userAgent);
			},
			
			/**
			 * Check if the user agent contains the word 'mobile'
			 * of if it's another phone
			 * @name isOtherMobile
			 * @method
			 * @memberof device
			 * @param {String} userAgent The browser user agent
			 * @returns {Boolean}
			 * @private
			 */
			isOtherMobile: function (userAgent) {
				return testUserAgent(/mobile/i, userAgent) ||
					detector.isOtherPhone(userAgent);
			},
			
			/**
			 * Check if the device runs on Android, iOs or other mobile
			 * @name isMobile
			 * @method
			 * @memberof device
			 * @param {String} userAgent The browser user agent
			 * @returns {Boolean}
			 * @private
			 */
			isMobile: function (userAgent) {
				return detector.isIos(userAgent) ||
					detector.isAndroid(userAgent) ||
					detector.isOtherMobile(userAgent);
			},
			
			/**
			 * Check if the user agent contains the word 'msie' or 'trident'
			 * @name isMsie
			 * @method
			 * @memberof device
			 * @param {String} userAgent The browser user agent
			 * @returns {Boolean}
			 * @private
			 */
			isMsie: function (userAgent) {
				return testUserAgent(/msie/mi, userAgent) ||
					testUserAgent(/trident/mi, userAgent);
			},

			/**
			 * Check if the user agent contains the word 'Safari' and does not
			 * contain the word 'Chrome'
			 * @name isSafari
			 * @method
			 * @memberof device
			 * @param {String} userAgent The browser user agent
			 * @returns {Boolean}
			 * @private
			 */
			isSafari: function (userAgent) {
				return !(testUserAgent(/Chrome/i, userAgent)) &&
					testUserAgent(/Safari/i, userAgent);
			},

			/**
			 * Check if the user agent contains the word 'Firefox'
			 * @name isFirefox
			 * @method
			 * @memberof isFirefox
			 * @param {String} userAgent The browser user agent
			 * @returns {Boolean}
			 * @private
			 */
			isFirefox: function (userAgent) {
				return testUserAgent(/Firefox/i, userAgent);
			},

			/**
			 * Check if the user agent contains the word 'Edge'
			 * @name isEdge
			 * @method
			 * @memberof device
			 * @param {String} userAgent The browser user agent
			 * @returns {Boolean}
			 * @private
			 */
			isEdge: function (userAgent) {
				return testUserAgent(/Edge/i, userAgent);
			},

			/**
			 * Check if the user agent contains the word 'Chrome' and it's not Edge
			 * @name isChrome
			 * @method
			 * @memberof device
			 * @param {String} userAgent The browser user agent
			 * @returns {Boolean}
			 * @private
			 */
			isChrome: function (userAgent) {
				return testUserAgent(/Chrome/i, userAgent) && !detector.isEdge();
			}
		};
		
		// return newly created object
		return detector;
	})();
	
	/** Public Interfaces **/
	global.App = $.extend(true, global.App, {
		device: {

			/**
			 * Object with all the device detection methods
			 * @name detector
			 * @public
			 * @memberof device
			 * @returns {Object} Detector
			 */
			detector: browserDetector,

			/**
			 * Check if the device is an iPhone
			 * @name iphone
			 * @constant
			 * @public
			 * @memberof device
			 */
			iphone: browserDetector.isIphone(),

			/**
			 * Check if the device is an iPad
			 * @name ipad
			 * @constant
			 * @public
			 * @memberof device
			 */
			ipad: browserDetector.isIpad(),

			/**
			 * Check if the device run on iOs
			 * @name ios
			 * @constant
			 * @public
			 * @memberof device
			 */
			ios: browserDetector.isIos(),

			/**
			 * Check if the device run on Android
			 * @name android
			 * @constant
			 * @public
			 * @memberof device
			 */
			android: browserDetector.isAndroid(),

			/**
			 * Check if the device is a mobile
			 * @name mobile
			 * @constant
			 * @public
			 * @memberof device
			 */
			mobile: browserDetector.isMobile(),

			/**
			 * Check if the device is a phone
			 * @name phone
			 * @constant
			 * @public
			 * @memberof device
			 */
			phone: browserDetector.isPhone(),

			/**
			 * Check if the device is a tablet
			 * @name tablet
			 * @constant
			 * @public
			 * @memberof device
			 */
			tablet: browserDetector.isTablet(),

			/**
			 * Check if the browser is Chrome
			 * @name chrome
			 * @constant
			 * @public
			 * @memberof device
			 */
			chrome: browserDetector.isChrome(),

			/**
			 * Check if the browser is Firefox
			 * @name firefox
			 * @constant
			 * @public
			 * @memberof device
			 */
			firefox: browserDetector.isFirefox(),

			/**
			 * Check if the browser is Safari
			 * @name safari
			 * @constant
			 * @public
			 * @memberof device
			 */
			safari: browserDetector.isSafari(),

			/**
			 * Check if the browser is Internet Explorer
			 * @name internetexplorer
			 * @constant
			 * @public
			 * @memberof device
			 */
			internetexplorer: browserDetector.isMsie(),

			/**
			 * Check if the browser is Edge
			 * @name edge
			 * @constant
			 * @public
			 * @memberof device
			 */
			edge: browserDetector.isEdge(),

			/**
			 * @name events
			 * @constant
			 * @public
			 * @memberof device
			 * @property {String} click Click event
			 * @property {String} enter 'pointerenter' equivalent
			 * @property {String} up 'pointerup' equivalent
			 * @property {String} down 'pointerdown' equivalent
			 * @property {String} move 'pointermove' equivalent
			 * @property {String} over 'pointerover' equivalent
			 * @property {String} out 'pointerout' equivalent
			 * @property {String} leave 'pointerleave' equivalent
			 */
			events: {
				click: 'click',
				enter: 'pointerenter',
				up: 'pointerup',
				down: 'pointerdown',
				move: 'pointermove',
				over: 'pointerover',
				out: 'pointerout',
				leave: 'pointerleave'
			}
		}
	});
	
})(jQuery, window);

/**
 * Functions
 *
 * @fileoverview Defines the App Fx
 *
 * @author Deux Huit Huit <https://deuxhuithuit.com>
 * @license MIT <https://deuxhuithuit.mit-license.org>
 *
 * @requires jQuery
 * @namespace App.fx
 */
(function ($, global, undefined) {
	'use strict';
	var bindings = {};

	/**
	 * Defines a custom name property on the fx object, if debugging is enabled.
	 * Ignores any errors.
	 * @memberof App.fx
	 * @name setFxName
	 * @method
	 * @param {String} key Action key
	 * @param {Function} fx The function
	 * @private
	 */
	var setFxName = function (key, fx) {
		if (App.debug() && Object.defineProperty) {
			try {
				Object.defineProperty(fx, 'name', { value: key });
			} catch (ex) { }
		}
	};

	/**
	 * Executes all read and write operations for the key function
	 * @name notify
	 * @memberof App.fx
	 * @method
	 * @param {String} key Action key
	 * @param {Object} data Bag of data
	 * @param {Function} cb Callback executed after each App.actions.execute execution
	 * @this fx
	 * @returns this
	 * @private
	 */
	var notify = function (key, data, cb) {
		var fx = bindings[key];
		if (!fx) {
			App.log({ args: ['Function key %s did not resolve to anything', key], fx: 'warn' });
		} else {
			App.actions.execute(fx, key, data, cb);
		}
		return this;
	};

	/**
	 * Register the function and make sure his key is unique
	 * @name exportsFx
	 * @method
	 * @memberof App.fx
	 * @param {String} key Module's unique identifier
	 * @param {Function} fx The function
	 * @param {Boolean} override Flag to control overwriting a function
	 * @returns {Object} The newly created function
	 * @private
	 */
	var exportsFx = function (key, fx, override) {
		if ($.type(key) !== 'string') {
			App.log({ args: ['`key` must be a string', key], fx: 'error' });
		} else if (!!bindings[key] && !override) {
			App.log({ args: ['Overwriting function key %s is not allowed', key], fx: 'error' });
		} else if (!$.isFunction(fx)) {
			App.log({ args: ['Function key %s is not a function', key], fx: 'error' });
		} else {
			// Try to set the name of the function
			setFxName(fx);
			bindings[key] = fx;
		}
		return bindings[key];
	};

	/** Public Interfaces **/
	global.App = $.extend(true, global.App, {
		/**
		 * @namespace fx
		 * @memberof App
		 */
		fx: {
			/**
			 * Executes all read and write operations present in the actions array.
			 * @name notify
			 * @memberof App.fx
			 * @method
			 * @param {String} key Action key
			 * @param {Object} data Bag of data
			 * @param {Function} cb Callback executed after each App.actions.execute execution
			 * @this fx
			 * @returns this
			 * @public
			 */
			notify: notify,

			/**
			 * Register the function and make sure his key is unique
			 * @name exports
			 * @method
			 * @memberof App.fx
			 * @param {String} key Module's unique identifier
			 * @param {Function} fx The function
			 * @param {Boolean} override Flag to control overwriting a function
			 * @returns {Object} The newly created function
			 * @private
			 */
			exports: exportsFx
		}
	});
})(jQuery, window);

/**
 * App Loaded functionality
 *
 * @fileoverview Defines and exports loaded
 *
 * @author Deux Huit Huit <https://deuxhuithuit.com>
 * @license MIT <https://deuxhuithuit.mit-license.org>
 *
 * @namespace loaded
 * @memberof App
 * @requires App
 */
(function ($, global, undefined) {
	'use strict';

	/**
	 * Check if a resource is loaded and callback when it is.
	 * @name loaded
	 * @method
	 * @memberof loaded
	 * @param {*} v Resource to test
	 * @param {Function} fx Callback to execute when the resource is loaded
	 * @param {Integer} delay Delay between each checks in ms
	 * @param {Integer} maxRetriesCount Max checks for a resource
	 * @param {Integer} counter Memo for the recursive function
	 * @private
	 */
	var loaded = function (v, fx, delay, maxRetriesCount, counter) {
		delay = Math.max(delay || 0, 100);
		maxRetriesCount = maxRetriesCount || 10;
		counter = counter || 1;
		// get the value
		var value = App.callback(v, [counter]);
		// if the value exists
		if (!!value) {
			// call the function, with the value, but always async
			setTimeout(function () {
				App.callback(fx, [value, counter]);
			}, 0);
		} else if (counter < maxRetriesCount) {
			// recurse
			setTimeout(loaded, delay, v, fx, delay, maxRetriesCount, counter + 1);
		} else if (!!App.log) {
			App.log({
				fx: 'error',
				args: ['App.loaded timed out after %s attempts.', counter]
			});
		}
	};

	/** Public Interfaces **/
	global.App = $.extend(true, global.App, {
		/**
		 * Check if a ressource is loaded and callback when it is.
		 * @name this
		 * @method
		 * @memberof loaded
		 * @param {*} v Ressource to test
		 * @param {Function} fx Callback to execute when the ressource is loaded
		 * @param {Integer} delay Delay between each checks in ms
		 * @param {Integer} maxRetriesCount Max checks for a ressource
		 * @param {Integer} counter Memo for the recursive function
		 * @public
		 */
		loaded: loaded
	});

})(jQuery, window);

/**
 *  Assets loader: Basically a wrap around $.ajax in order
 *  to priorize and serialize resource loading.
 *
 * @fileoverview Assets Loader, wrap around $.ajax
 *
 * @author Deux Huit Huit <https://deuxhuithuit.com>
 * @license MIT <https://deuxhuithuit.mit-license.org>
 * @namespace loader
 * @memberof App
 * @requires App
 */
(function ($, global, undefined) {
	'use strict';

	// Forked: https://gist.github.com/nitriques/6583457
	(function addXhrProgressEvent () {
		var originalXhr = $.ajaxSettings.xhr;
		$.ajaxSetup({
			progress: $.noop,
			upload: $.noop,
			xhr: function () {
				var self = this;
				var req = originalXhr();
				if (req) {
					if ($.isFunction(req.addEventListener)) {
						req.addEventListener('progress', function (e) {
							self.progress($.Event(e)); // make sure it's jQuery-ize
						}, false);
					}
					if (!!req.upload && $.isFunction(req.upload.addEventListener)) {
						req.upload.addEventListener('progress', function (e) {
							self.upload($.Event(e)); // make sure it's jQuery-ize
						}, false);
					}
				}
				return req;
			}
		});
	})();
	
	var assets = []; // FIFO
	
	var loaderIsWorking = false;
	
	var currentUrl = null;
	
	/**
	 * Check if a given url is loading (Only GET request)
	 * @name isLoading
	 * @method
	 * @memberof loader
	 * @param {Object} url Url object to check
	 * @returns {Boolean}
	 * @private
	 */
	var isLoading = function (url) {
		if (!$.isPlainObject(url)) {
			url = {url: url};
		}
		if (!!url.method && url.method !== 'GET') {
			return false;
		}
		return !!currentUrl && currentUrl === url.url;
	};
	
	/**
	 * Check if a given url is in the queue
	 * @name inQueue
	 * @method
	 * @memberof loader
	 * @param {Object} url Url object to check
	 * @returns {Boolean}
	 * @private
	 */
	var inQueue = function (url) {
		var foundIndex = -1;
		$.each(assets, function eachAsset (index, asset) {
			if (asset.url === url) {
				foundIndex = index;
				return false; // early exit
			}
			return true;
		});
		return foundIndex;
	};
	
	/**
	 * Return the appropriate storage engine for the given url
	 * @name getStorageEngine
	 * @method
	 * @memberof loader
	 * @param {Object} url Url object to check
	 * @private
	 */
	var getStorageEngine = function (url) {
		if (url.cache === true) {
			url.cache = 'session';
		}
		return global.App.storage && global.App.storage[url.cache];
	};
	
	// This breaks the call dependency cycle
	var recursiveLoad = $.noop;
	var loadAsset = $.noop;
	
	var defaultParameters = function (asset) {
		return {
			progress: function (e) {
				// callback
				App.callback(asset.progress, [e]);
			},
			success: function (data, textStatus, jqXHR) {
				// clear pointer
				currentUrl = null;
				
				// register next
				recursiveLoad();
				
				// callback
				App.callback(asset.success, [data, textStatus, jqXHR]);
				
				// store in cache
				if (!!asset.cache) {
					var storage = getStorageEngine(asset);
					if (!!storage) {
						storage.set(asset.url, data);
					}
				}
			},
			error: function (jqXHR, textStatus, errorThrown) {
				var maxRetriesFactor = !!asset.vip ? 2 : 1;
				
				// clear pointer
				currentUrl = null;
				
				App.log({
					fx: 'error',
					args: ['Error loading url %s: %s', asset.url, textStatus + ' ' + errorThrown],
					me: 'Loader'
				});
				
				// if no vip access is granted
				//if (!asset.vip) {
				// decrease priority
				// this avoids looping for a unload-able asset
				asset.priority += ++asset.retries; // out of bounds checking is done later
				//}
				
				// Check the error code:
				// No need to replay client errors (4xx)
				var clientError = jqXHR.status >= 400 && jqXHR.status < 500;
				if (!!clientError) {
					// Early exit
					App.callback(asset.clienterror, [jqXHR.status, jqXHR, textStatus, errorThrown]);

				// if we already re-tried  less than x times
				} else if (asset.retries <= (asset.maxRetries * maxRetriesFactor)) {
					// push it back into the queue and retry
					loadAsset(asset);
				} else {
					// we give up!
					App.callback(asset.giveup, [jqXHR, textStatus, errorThrown]);
				}
				
				// next
				recursiveLoad();
				
				// callback
				App.callback(asset.error, [jqXHR, textStatus, errorThrown]);
			}
		};
	};
	
	/**
	 * Load the first item in the queue
	 * @name loadOneAsset
	 * @method
	 * @private
	 * @memberof loader
	 */
	var loadOneAsset = function () {
		// grab first item
		var asset = assets.shift();
		// extend it
		var param = $.extend({}, asset, defaultParameters(asset));
		// actual loading
		$.ajax(param);
		// set the pointer
		currentUrl = param.url;
	};
	
	/**
	 * Trigger loadOneAsset as long as there's entries in the queue
	 * @name recursiveLoad
	 * @method
	 * @memberof loader
	 * @private
	 */
	recursiveLoad = function () {
		if (!!assets.length) {
			// start next one
			setTimeout(loadOneAsset, 0);
		} else {
			// work is done
			loaderIsWorking = false;
		}
	};
	
	/**
	 * Validate and format url's data
	 * @name valideUrlArags
	 * @method
	 * @memberof loader
	 * @private
	 * @param {Object} url Url object
	 * @param {Integer} priority Priority of the url
	 * @returns {Object} Url object
	 */
	var validateUrlArgs = function (url, priority) {
		// ensure we are dealing with an object
		if (!$.isPlainObject(url)) {
			url = {url: url};
		}
		
		// pass the priority param into the object
		if ($.isNumeric(priority) && Math.abs(priority) < assets.length) {
			url.priority = priority;
		}
		
		// ensure that the priority is valid
		if (!$.isNumeric(url.priority) || Math.abs(url.priority) > assets.length) {
			url.priority = assets.length;
		}
		
		// ensure we have a value for the retries
		if (!$.isNumeric(url.retries)) {
			url.retries = 0;
		}
		if (!$.isNumeric(url.maxRetries)) {
			url.maxRetries = 2;
		}
		
		return url;
	};
	
	/**
	 * Trigger the loading if nothing is happening
	 * @name launchLoad
	 * @method
	 * @private
	 * @memberof loader
	 */
	var launchLoad = function () {
		// start now if nothing is loading
		if (!loaderIsWorking) {
			loaderIsWorking = true;
			loadOneAsset();
			App.log({fx: 'info', args: 'Load worker has been started', me: 'Loader'});
		}
	};
	
	/**
	 * Get the value from the cache if it's available
	 * @name getValueFromCache
	 * @method
	 * @memberof loader
	 * @param {Object} url Url object
	 * @returns {Boolean}
	 * @private
	 */
	var getValueFromCache = function (url) {
		var storage = getStorageEngine(url);
		if (!!storage) {
			var item = storage.get(url.url);
			if (!!item) {
				// if the cache-hit is valid
				if (App.callback(url.cachehit, [item]) !== false) {
					// return the cache
					App.callback(url.success, [item]);
					return true;
				}
			}
		}
		return false;
	};
	
	/**
	 * Update a request priority in the queue
	 * @name updatePriority
	 * @method
	 * @memberof loader
	 * @private
	 * @param {Object} url Url object
	 * @param {Integer} index
	 */
	var updatePriority = function (url, index) {
		// promote if new priority is different
		var oldAsset = assets[index];
		if (oldAsset.priority != url.priority) {
			// remove
			assets.splice(index, 1);
			// add
			assets.splice(url.priority, 1, url);
		}
		App.log({
			args: [
				'Url %s was shifted from %s to %s',
				url.url,
				oldAsset.priority, url.priority
			],
			me: 'Loader'
		});
	};
	
	/**
	 * Put the request in the queue and trigger the load
	 * @name loadAsset
	 * @method
	 * @memberof loader
	 * @private
	 * @param {Object} url Url Object
	 * @param {Integer} priority
	 * @this App
	 * @returns this
	 */
	loadAsset = function (url, priority) {
		if (!url) {
			App.log({fx: 'error', args: 'No url given', me: 'Loader'});
			return this;
		}
		
		url = validateUrlArgs(url, priority);
		
		// ensure that asset is not current
		if (isLoading(url)) {
			App.log({fx: 'error', args: ['Url %s is already loading', url.url], me: 'Loader'});
			return this;
		}
		
		// check cache
		if (!!url.cache) {
			if (getValueFromCache(url)) {
				return this;
			}
		}
		
		var index = inQueue(url.url);
		
		// ensure that asset is not in the queue
		if (!~index) {
			// insert in array
			assets.splice(url.priority, 1, url);
			App.log({
				fx: 'info',
				args: ['Url %s has been insert at %s', url.url, url.priority],
				me: 'Loader'
			});
			
		} else {
			updatePriority(url, index);
		}
		
		launchLoad();
		
		return this;
	};
	
	global.App = $.extend(true, global.App, {
		loader: {
			/**
			 * Put the request in the queue and trigger the load
			 * @name load
			 * @method
			 * @memberof loader
			 * @public
			 * @param {Object} url Url Object
			 * @param {Integer} priority
			 * @this App
			 * @returns this
			 */
			load: loadAsset,

			/**
			 * Check if a given url is loading (Only GET request)
			 * @name isLoading
			 * @method
			 * @memberof loader
			 * @param {Object} url Url object to check
			 * @returns {Boolean}
			 * @public
			 */
			isLoading: isLoading,

			/**
			 * Check if a given url is in the queue
			 * @name inQueue
			 * @method
			 * @memberof loader
			 * @param {Object} url Url object to check
			 * @returns {Boolean}
			 * @public
			 */
			inQueue: inQueue,

			/**
			 * Get the flag if the loader is working or not
			 * @name working
			 * @method
			 * @memberof loader
			 * @public
			 * @returns {Boolean}
			 */
			working: function () {
				return loaderIsWorking;
			}
		}
	});
	
})(jQuery, window);

/**
 * App  Log
 *
 * @fileoverview Defines and exports log
 *
 * @author Deux Huit Huit <https://deuxhuithuit.com>
 * @license MIT <https://deuxhuithuit.mit-license.org>
 *
 * @namespace log
 * @memberof App
 * @requires App
 */
(function ($, global, undefined) {
	'use strict';

	/**
	 * Format the passed arguments and the displayed message
	 * @name argsToObject
	 * @method
	 * @memberof debug
	 * @param {Object} arg
	 * @returns {Object} Formated object
	 * @private
	 */
	var argsToObject = function (arg) {
		// ensure that args is an array
		if (!!arg.args && !$.isArray(arg.args)) {
			arg.args = [arg.args];
		}

		// our copy
		var a = {
			args: arg.args || arguments,
			fx: arg.fx || 'warn',
			me: arg.me || 'App'
		},
			t1 = $.type(a.args[0]);

		if (t1 === 'string' || t1 === 'number' || t1 == 'boolean') {
			// append me before a.args[0]
			a.args[0] = '[' + a.me + '] ' + a.args[0];
		}
		return a;
	};

	var logs = [];

	/**
	 * Log the recived data with the appropriate effect (log, error, info...)
	 * @name log
	 * @method
	 * @memberof debug
	 * @param {Array} arg
	 * @private
	 */
	var log = function (arg) {
		// no args, exit
		if (!arg) {
			return this;
		}

		var a = argsToObject(arg);

		if (App.debug()) {
			// make sure fx exists
			if (!$.isFunction(console[a.fx])) {
				a.fx = 'log';
			}
			// call it
			if (!!window.console[a.fx].apply) {
				window.console[a.fx].apply(window.console, a.args);
			} else {
				$.each(a.args, function logArgs (index, arg) {
					window.console[a.fx](arg);
				});
			}
		}
		logs.push(a);

		return this;
	};

	/** Public Interfaces **/
	global.App = $.extend(true, global.App, {

		/**
		 * Log the recived data with the appropriate effect (log, error, info...)
		 * @name this
		 * @method
		 * @memberof log
		 * @param {Array} arg
		 * @public
		 */
		log: log,

		/**
		 * Get all the logs
		 * @name logs
		 * @method
		 * @memberof log
		 * @returns {Array} All the logs
		 * @public
		 */
		logs: function () {
			return logs;
		}
	});

})(jQuery, window);

/**
 * Mediator controls the current page and modules
 *
 * @fileoverview Defines the App Mediator
 *
 * @author Deux Huit Huit <https://deuxhuithuit.com>
 * @license MIT <https://deuxhuithuit.mit-license.org>
 *
 * @requires jQuery
 * @namespace App.mediator
 */
(function ($, global, undefined) {
	'use strict';

	/**
	 * Returns the current document.location value, without the protocol and host
	 * @name getCurrentUrl
	 * @memberof App
	 * @method
	 * @returns {String} The url
	 * @private
	 */
	var getCurrentUrl = function () {
		return document.location.href.substring(
			document.location.protocol.length + 2 + document.location.host.length
		);
	};

	/** Mediator **/
	var mediatorIsLoadingPage = false;
	var currentRouteUrl = getCurrentUrl();

	//Store ref to the current page object
	var currentPage = null;

	//Store ref to the previous page object
	var previousPage = null;
	var previousUrl = '';

	/**
	 * Check if the mediator is loading a page
	 * @name validateMediatorState
	 * @memberof App
	 * @method
	 * @returns {Boolean}
	 * @private
	 */
	var validateMediatorState = function () {
		if (mediatorIsLoadingPage) {
			App.log({
				args: 'Mediator is busy waiting for a page load.',
				fx: 'error'
			});
		}

		return !mediatorIsLoadingPage;
	};

	/**
	 * Check if the page is valid or not
	 * @name validateNextPage
	 * @memberof App
	 * @method
	 * @param {Object} nextPage PageObject
	 * @returns {Boolean}
	 * @private
	 */
	var validateNextPage = function (nextPage) {
		var result = true;

		if (!nextPage) {
			result = false;
		}

		return result;
	};

	/**
	 * Check if we can enter the next page
	 * @name canEnterNextPage
	 * @memberof App
	 * @method
	 * @param {Object} nextPage Next page instence
	 * @returns {Boolean}
	 * @private
	 */
	var canEnterNextPage = function (nextPage) {
		var result = true;

		if (!nextPage.canEnter()) {
			App.log({ fx: 'error', args: ['Cannot enter page %s.', nextPage.key()] });
			result = false;
		}

		return result;
	};

	/**
	 * Check if we can leave the current page
	 * @name canLeaveCurrentPage
	 * @memberof App
	 * @method
	 * @returns {Boolean}
	 * @private
	 */
	var canLeaveCurrentPage = function () {
		var result = false;

		if (!currentPage) {
			App.log({ args: 'No current page set.', fx: 'error' });
		} else if (!currentPage.canLeave()) {
			App.log({ args: ['Cannot leave page %s.', currentPage.key()], fx: 'error' });
		} else {
			result = true;
		}

		return result;
	};

	//Actions

	/**
	 * Resolves the call to key only for the current page
	 * @name resolvePageAction
	 * @memberof App
	 * @method
	 * @param {String} key Notify key
	 * @param {Object} data Bag of data
	 * @this {Object} Mediator
	 * @returns {Object} A read/write object, if it exists
	 * @private
	 */
	var resolvePageAction = function (key, data) {
		if (!!currentPage) {
			return App.actions.resolve(currentPage.actions, key, data);
		} else {
			App.log({ args: 'Can not notify page: No current page set.', fx: 'error' });
		}
	};

	/**
	 * Resolves and executes the action on the page and all modules
	 * @name notifyAll
	 * @memberof App
	 * @method
	 * @param {String} key Notify key
	 * @param {Object} data Bag of data
	 * @param {Function} cb Callback executed after each App.actions.execute execution
	 * @this Mediator
	 * @returns this
	 * @see AER in http://addyosmani.com/largescalejavascript/
	 * @private
	 */
	var notifyAll = function (key, data, cb) {
		var actions = [];
		// resolve action from current page only
		var pa = resolvePageAction(key, data);
		if (!!pa) {
			actions.push(pa);
		}
		// resolve action from all modules
		actions = actions.concat(App.modules.resolve(key, data));
		// Execute everything
		App.actions.execute(actions, key, data, cb);
		return this;
	};

	/**
	 * Resolves and executes the action on the page
	 * @name notifyPage
	 * @memberof App
	 * @method
	 * @param {String} key Notify key
	 * @param {Object} data Bag of data
	 * @param {Function} cb Callback executed after each App.actions.execute execution
	 * @this Mediator
	 * @returns this
	 */
	var notifyPage = function (key, data, cb) {
		var pa = resolvePageAction(key, data);
		if (!!pa) {
			App.actions.execute([pa], key, data, cb);
		}
		return this;
	};

	/**
	 * Change the current page to the requested route
	 * Do nothing if the current page is already the requested route
	 * @name gotoPage
	 * @memberof App
	 * @method
	 * @param {String} obj Page requested
	 * @param {String} previousPoppedUrl Url
	 * @fires App#page:leave
	 * @fires App#page:enter
	 * @fires App#pages:failedtoparse
	 * @fires App#pages:loaded
	 * @fires App#pages:loadfatalerror
	 * @fires App#pages:loaderror
	 * @fires App#pages:requestBeginPageTransition
	 * @fires App#pages:navigateToCurrent
	 * @fires App#pages:requestPageTransition
	 * @fires App#pages:routeNotFound
	 * @fires App#pages:loadprogress
	 * @fires App#pages:notfound
	 * @fires App#page:leaving
	 * @fires App#page:entering
	 * @this App
	 * @private
	 */
	var gotoPage = function (obj, previousPoppedUrl) {
		var nextPage;
		var route = '';

		/**
		 * Try to parse the data in jQuery to be sure it's valid
		 * @param {String} data response data
		 * @returns {jQuery}
		 */
		var safeParseData = function (data) {
			try {
				return $(data);
			}
			catch (ex) {
				App.log({ args: [ex.message], fx: 'error' });
				/**
				 * @event App#pages:failedtoparse
				 * @type {object}
				 * @property {object} data
				 * @property {string} route
				 * @property {object} nextPage PageObject
				 * @property {object} currentPage PageObject
				 */
				App.modules.notify('pages.failedtoparse', {
					data: data,
					route: route,
					nextPage: nextPage,
					currentPage: currentPage
				});
			}
			return $();
		};

		/**
		 * Initiate the transition and leave/enter page logic
		 */
		var enterLeave = function () {
			//Keep currentPage pointer for the callback in a new variable
			//The currentPage pointer will be cleared after the next call
			var leavingPage = currentPage;

			/**
			 * Block all interaction with the framework and notify the page leave
			 */
			var leaveCurrent = function () {
				currentPage = null; // clean currentPage pointer,this will block all interactions

				//set leaving page to be previous one
				previousPage = leavingPage;
				previousUrl = !!previousPoppedUrl ? previousPoppedUrl : getCurrentUrl();
				//clear leavingPage
				leavingPage = null;

				/**
				 * @event App#page:leave
				 * @type {object}
				 * @property {object} page PageObject
				 */
				App.modules.notify('page.leave', { page: previousPage });
			};

			/**
			 * Set the current page to the new one
			 */
			var enterNext = function () {
				// set the new Page as the current one
				currentPage = nextPage;

				/**
				 * @event App#page:enter
				 * @type {object}
				 * @property {object} page PageObject
				 */
				App.modules.notify('page.enter', { page: nextPage, route: route });
				// Put down the flag since we are finished
				mediatorIsLoadingPage = false;
			};

			var pageTransitionData = {
				currentPage: currentPage,
				nextPage: nextPage,
				leaveCurrent: leaveCurrent,
				enterNext: enterNext,
				route: route,
				isHandled: false
			};

			/**
			 * @event App#pages:requestPageTransition
			 * @type {object}
			 * @property {object} pageTransitionData
			 */
			App.modules.notify('pages.requestPageTransition', pageTransitionData);

			if (!nextPage.isInited) {
				nextPage.init();
				nextPage.isInited = true;
			}

			//if not, return to classic code
			if (!pageTransitionData.isHandled) {
				//Leave to page the transition job

				/**
				 * @event App#page:leaving
				 * @type {object}
				 * @property {object} page PageObject
				 */
				App.modules.notify('page.leaving', { page: leavingPage });

				//Leave the current page
				leavingPage.leave(leaveCurrent);

				/**
				 * @event App#page:entering
				 * @type {object}
				 * @property {object} page PageObject
				 * @property {string} route url
				 */
				App.modules.notify('page.entering', { page: nextPage, route: route });

				nextPage.enter(enterNext);
			}
		};

		/**
		 * Verify that the data is valid an append the loaded content inside the App's root
		 * @param {String} data requested data
		 * @param {String} textStatus Current request status
		 * @param {Object} jqXHR request instance
		 */
		var loadSuccess = function (data, textStatus, jqXHR) {
			var htmldata = safeParseData(data);

			// get the node
			var node = htmldata.find(nextPage.key());

			// get the root node
			var elem = $(App.root());

			// Check for redirects
			var responseUrl = htmldata.find(App.root() + ' > [data-response-url]')
				.attr('data-response-url');

			if (!!responseUrl && responseUrl != obj.split('#')[0]) {

				var redirectedPage = nextPage;

				// Find the right page
				nextPage = App.pages.getPageForRoute(responseUrl);

				/**
				 * Offer a bail out door
				 * @event App#pages:redirected
				 * @type {Object}
				 * @property {String} route Url
				 * @property {String} requestedRoute Url
				 * @property {Object} nextPage PageObject
				 * @property {Object} currentPage PageObject
				 * @property {Object} redirectedPage PageObject
				 */
				App.modules.notify('pages.redirected', {
					currentPage: currentPage,
					nextPage: nextPage,
					redirectedPage: redirectedPage,
					requestedRoute: route,
					responseRoute: responseUrl
				});

				/**
				 * Cancel current transition
				 * @event App#pages:requestCancelPageTransition
				 * @type {Object}
				 * @property {String} route Url
				 * @property {Object} nextPage PageObject
				 * @property {Object} currentPage PageObject
				 */
				App.modules.notify('pages.requestCancelPageTransition', {
					currentPage: currentPage,
					nextPage: nextPage,
					route: route
				});

				if (!validateNextPage(nextPage)) {
					/**
					 * @event App#pages:routeNotFound
					 * @type {object}
					 * @property {String} url Url
					 * @property {Boolean} isRedirect PageObject
					 * @property {Object} page PageObject
					 */
					App.modules.notify('pages.routeNotFound', {
						page: currentPage,
						url: obj,
						isRedirect: true
					});
					App.log({ args: ['Redirected route "%s" was not found.', obj], fx: 'error' });
					return;
				} else {
					node = htmldata.find(nextPage.key());
					if (nextPage === currentPage) {
						/**
						 * @event App#pages:navigateToCurrent
						 * @type {object}
						 * @property {String} url Url
						 * @property {Boolean} isRedirect PageObject
						 * @property {Object} page PageObject
						 */
						App.modules.notify('pages.navigateToCurrent', {
							page: nextPage,
							route: route,
							isRedirect: true
						});
						App.log('Redirected next page is the current one');
					} else {
						/**
						 * Start new transition
						 * @event App#pages:requestBeginPageTransition
						 * @type {object}
						 * @property {String} route Url
						 * @property {Boolean} isRedirect PageObject
						 * @property {Object} nextPage PageObject
						 * @property {Object} currentPage PageObject
						 */
						App.modules.notify('pages.requestBeginPageTransition', {
							currentPage: currentPage,
							nextPage: nextPage,
							route: responseUrl,
							isRedirect: true
						});

					}
				}
			}

			if (!node.length) {
				App.log({
					args: ['Could not find "%s" in xhr data.', nextPage.key()],
					fx: 'error'
				});

				// free the mediator
				mediatorIsLoadingPage = false;

				/**
				 * @event App#pages:notfound
				 * @type {Object}
				 * @property {String} data Loaded raw content
				 * @property {String} url request url
				 * @property {Object} xhr Request object instence
				 * @property {String} status Status of the request
				 */
				App.modules.notify('pages.notfound', {
					data: data,
					url: obj,
					xhr: jqXHR,
					status: textStatus
				});

			} else {
				// append it to the doc, hidden
				elem.append(node.css({ opacity: 0 }));

				// init page
				nextPage.init();
				nextPage.isInited = true;

				node.hide();

				/**
				 * @event App#pages:loaded
				 * @type {Object}
				 * @property {jQuery} elem Loaded content
				 * @property {String} data Loaded raw content
				 * @property {String} url request url
				 * @property {Object} page PageObject
				 * @property {jQuery} node Page element
				 * @property {Object} xhr Request object instence
				 * @property {String} status Status of the request
				 */
				App.modules.notify('pages.loaded', {
					elem: elem,
					data: data,
					url: obj,
					page: nextPage,
					node: node,
					xhr: jqXHR,
					status: textStatus
				});

				// actual goto
				enterLeave();
			}
		};

		/**
		 * Dispatch a notify for the progress event
		 * @name progress
		 * @method
		 * @memberof App
		 * @private
		 * @param {Event} e Request progress event
		 */
		var progress = function (e) {
			var total = e.originalEvent.total;
			var loaded = e.originalEvent.loaded;
			var percent = total > 0 ? loaded / total : 0;

			/**
			 * @event App#pages:loadprogress
			 * @type {Object}
			 * @property {Object} event Request progress event
			 * @property {String} url Request url
			 * @property {Integer} total Total bytes
			 * @property {Integer} loaded Total bytes loaded
			 * @property {Integer} percent
			 */
			App.mediator.notify('pages.loadprogress', {
				event: e,
				url: obj,
				total: total,
				loaded: loaded,
				percent: percent
			});
		};

		if (validateMediatorState() && canLeaveCurrentPage()) {
			if ($.type(obj) === 'string') {
				nextPage = App.pages.getPageForRoute(obj);
				route = obj;
			} else {
				nextPage = obj;
			}

			if (!validateNextPage(nextPage)) {
				/**
				 * @event App#pages:routeNotFound
				 * @type {Object}
				 * @property {Object} page PageObject
				 * @property {String} url Request url
				 */
				App.modules.notify('pages.routeNotFound', {
					page: currentPage,
					url: obj
				});
				App.log({ args: ['Route "%s" was not found.', obj], fx: 'error' });
			} else {
				if (canEnterNextPage(nextPage)) {
					if (nextPage === currentPage) {
						/**
						 * @event App#pages:navigateToCurrent
						 * @type {Object}
						 * @property {Object} page PageObject
						 * @property {String} route Request url
						 */
						App.modules.notify('pages.navigateToCurrent', {
							page: nextPage,
							route: route
						});
						App.log('Next page is the current one');

					} else {

						/**
						 * @event App#pages:loading
						 * @type {Object}
						 * @property {Object} page PageObject
						 */
						App.modules.notify('pages.loading', {
							page: nextPage
						});

						/**
						 * @event App#pages:requestBeginPageTransition
						 * @type {Object}
						 * @property {Object} currentPage PageObject
						 * @property {Object} nextPage PageObject
						 * @property {String} route Request url
						 */
						App.modules.notify('pages.requestBeginPageTransition', {
							currentPage: currentPage,
							nextPage: nextPage,
							route: route
						});

						// Load from xhr or use cache copy
						if (!nextPage.loaded()) {
							// Raise the flag to mark we are in the process
							// of loading a new page
							mediatorIsLoadingPage = true;

							App.loader.load({
								url: obj, // the *actual* route
								priority: 0, // now
								vip: true, // don't queue on fail
								success: loadSuccess,
								progress: progress,
								error: function (e) {
									/**
									 * @event App#pages:loaderror
									 * @type {Object}
									 * @property {Object} event Request event
									 * @property {String} url Request url
									 */
									App.modules.notify('pages.loaderror', {
										event: e,
										url: obj
									});
								},
								giveup: function (e) {
									// Free the mediator
									mediatorIsLoadingPage = false;

									App.log({ args: 'Giving up!', me: 'Loader', fx: 'error' });

									/**
									 * @event App#pages:loadfatalerror
									 * @type {Object}
									 * @property {Object} event Request event
									 * @property {String} url Request url
									 */
									App.modules.notify('pages.loadfatalerror', {
										event: e,
										url: obj
									});
								}
							});
						} else {
							enterLeave();

							/**
							 * @event App#pages:loaded
							 * @type {Object}
							 * @property {jQuery} elem Root element
							 * @property {Object} event Request event
							 * @property {String} url Request url
							 */
							App.modules.notify('pages.loaded', {
								elem: $(App.root()),
								url: obj,
								page: nextPage
							});
						}
					}
				} else {
					App.log({ args: ['Route "%s" is invalid.', obj], fx: 'error' });
				}
			}
		}
		return this;
	};

	/**
	 * Open the wanted page,
	 * return to the precedent page if the requested on is already open
	 * or fallback to a default one
	 * @name togglePage
	 * @memberof App
	 * @method
	 * @fires App#page:toggleNoPreviousUrl
	 * @param {String} route Url
	 * @param {String} fallback Url used for as a fallback
	 * @private
	 */
	var togglePage = function (route, fallback) {
		if (!!currentPage && validateMediatorState()) {
			var
				nextPage = App.pages.getPageForRoute(route);

			if (validateNextPage(nextPage) && canEnterNextPage(nextPage)) {
				if (nextPage !== currentPage) {
					gotoPage(route);
				} else if (!!previousUrl && previousUrl !== getCurrentUrl()) {
					gotoPage(previousUrl);
				} else if (!!fallback) {
					gotoPage(fallback);
				} else {
					/**
					 * @event App#page:toggleNoPreviousUrl
					 * @type {object}
					 * @property {object} currentPage PageObject
					 */
					App.modules.notify('page.toggleNoPreviousUrl', { currentPage: nextPage });
				}
			}
		}
		return this;
	};

	/**
	 * Properly sets the current page on first load
	 * @name initPage
	 * @memberof App.mediator
	 * @method
	 * @param {Object} page the loaded and inited page object
	 * @fires App#page:entering
	 * @fires App#page:enter
	 * @private
	 */
	var initPage = function (page) {
		// find if this is our current page
		// current route found ?
		if (!!~App.pages.matchRoute(currentRouteUrl, page.routes())) {
			if (!!currentPage) {
				App.log({
					args: ['Previous current page will be changed', {
						currentPage: currentPage,
						previousPage: previousPage,
						newCurrentPage: page
					}],
					fx: 'warning'
				});
			}
			// initialize page variable
			currentPage = page;
			previousPage = previousPage || page;

			/**
			 * @event App#page:entering
			 * @type {object}
			 * @property {Object} page PageObject
			 * @property {String} route Url
			 */
			App.modules.notify('page.entering', {
				page: currentPage,
				route: currentRouteUrl
			});
			// enter the page right now
			currentPage.enter(function currentPageEnterCallback () {
				/**
				 * @event App#page:enter
				 * @type {object}
				 * @property {Object} page PageObject
				 * @property {String} route Url
				 */
				App.modules.notify('page.enter', {
					page: currentPage,
					route: currentRouteUrl
				});
			});
		}
	};

	/** Public Interfaces **/
	global.App = $.extend(true, global.App, {
		/**
		 * @namespace mediator
		 * @memberof App
		 */
		mediator: {
			/**
			 * Get the current url string
			 * @name getCurrentUrl
			 * @memberof App.mediator
			 * @method
			 * @returns {string} The current url
			 * @public
			 */
			getCurrentUrl: getCurrentUrl,

			/**
			 * Get the currentPage object
			 * @name getCurrentPage
			 * @memberof App.mediator
			 * @method
			 * @returns {Object} PageObject
			 * @public
			 */
			getCurrentPage: function () {
				return currentPage;
			},

			/**
			 * Set the currentPage object
			 * @name setCurrentPage
			 * @memberof App.mediator
			 * @method
			 * @param {Object} page The PageObject
			 * @private
			 */
			setCurrentPage: function (page) {
				currentPage = page;
			},

			/**
			 * Get the previous url string
			 * @name getPreviousUrl
			 * @memberof App.mediator
			 * @method
			 * @returns {string} The previous url
			 * @public
			 */
			getPreviousUrl: function () {
				return previousUrl;
			},

			/**
			 * Get the previousPage object
			 * @name getPreviousPage
			 * @memberof App.mediator
			 * @method
			 * @returns {Object} PageObject
			 * @public
			 */
			getPreviousPage: function () {
				return previousPage;
			},

			/**
			 * Resolves and execute the action on the page and all modules
			 * @name notify
			 * @memberof App.mediator
			 * @method
			 * @param {String} key Notify key
			 * @param {Object} data Bag of data
			 * @param {Function} cb Callback executed after each App.actions.execute execution
			 * @this Mediator
			 * @returns this
			 * @see AER in http://addyosmani.com/largescalejavascript/
			 * @public
			 */
			notify: notifyAll,

			/**
			 * Resolves and executes the action on the page
			 * @name notifyCurrentPage
			 * @memberof App.mediator
			 * @method
			 * @param {String} key Notify key
			 * @param {Object} data Bag of data
			 * @param {Function} cb Callback executed after each App.actions.execute execution
			 * @this {Object} Mediator
			 * @returns this
			 * @public
			 */
			notifyCurrentPage: notifyPage,

			/**
			 * Change the current page to the requested route
			 * Do nothing if the current page is already the requested route
			 * @name goto
			 * @memberof App.mediator
			 * @method
			 * @param {String} obj Page requested
			 * @param {String} previousPoppedUrl Url
			 * @fires App#page:leave
			 * @fires App#page:enter
			 * @fires App#pages:failedtoparse
			 * @fires App#pages:loaded
			 * @fires App#pages:loadfatalerror
			 * @fires App#pages:loaderror
			 * @fires App#pages:requestBeginPageTransition
			 * @fires App#pages:navigateToCurrent
			 * @fires App#pages:requestPageTransition
			 * @fires App#pages:routeNotFound
			 * @fires App#pages:loadprogress
			 * @fires App#pages:notfound
			 * @fires App#page:leaving
			 * @fires App#page:entering
			 * @this App
			 */
			goto: gotoPage,

			/**
			 * Open the wanted page,
			 * return to the precedent page if the requested on is already open
			 * or fallback to a default one
			 * @name toggle
			 * @memberof App.mediator
			 * @method
			 * @fires App#page:toggleNoPreviousUrl
			 * @param {String} route Url
			 * @param {String} fallback Url used for as a fallback
			 * @public
			 */
			toggle: togglePage,

			/**
			 * Properly sets the current page on first load
			 * @name init
			 * @memberof App.mediator
			 * @method
			 * @param {Object} page the loaded and inited page object
			 * @fires App#page:entering
			 * @fires App#page:enter
			 * @public
			 */
			init: initPage
		}
	});

})(jQuery, window);

/**
 * Module are singleton that lives across pages
 *
 * @fileoverview Defines and exports components
 *
 * @author Deux Huit Huit <https://deuxhuithuit.com>
 * @license MIT <https://deuxhuithuit.mit-license.org>
 *
 * @namespace modules
 * @memberof App
 * @requires App
 */
(function ($, global, undefined) {
	'use strict';
	
	/** Modules **/
	var modules = {};
	
	/**
	 * Create a basic module with the minimum required methods
	 * @name createAbstractModule
	 * @method
	 * @memberof modules
	 * @returns {Object}
	 * @private
	 */
	var createAbstractModule = function () {
		return {
			actions: $.noop,
			init: $.noop
		};
	};
	
	/**
	 * Merge the module with the basic one
	 * to be sure the minimum required methods are present
	 * @name createModule
	 * @method
	 * @memberof modules
	 * @param {Object} module ModuleObject
	 * @private
	 */
	var createModule = function (module) {
		return $.extend(createAbstractModule(), module);
	};
	
	/**
	 * Register the module and make sure his key is unique
	 * @name exportModule
	 * @method
	 * @memberof modules
	 * @param {String} key Module's unique identifier
	 * @param {Object} module The module object
	 * @param {Boolean} override Flag to control overwriting a module
	 * @returns {Object} The newly created module
	 * @private
	 */
	var exportModule = function (key, module, override) {
		if ($.type(key) !== 'string') {
			App.log({args: ['`key` must be a string', key], fx: 'error'});
		} else if (!!modules[key] && !override) {
			App.log({args: ['Overwriting module key %s is not allowed', key], fx: 'error'});
		} else {
			modules[key] = createModule(module);
		}
		return modules[key];
	};

	/**
	 * Resolves the key action on all modules
	 * @name resolveActions
	 * @method
	 * @memberof modules
	 * @param {String} key Notify key
	 * @param {Object} data Bag of data
	 * @returns {Array} Array of read/write objects for all modules
	 * @private
	 */
	var resolveActions = function (key, data) {
		return Object.keys(modules).map(function resolveAction (k) {
			return App.actions.resolve(modules[k].actions, key, data);
		}).filter(function (a) {
			return !!a;
		});
	};

	/**
	 * Resolves and execute the action on all modules
	 * @name notifyModules
	 * @method
	 * @memberof modules
	 * @param {String} key Notify key
	 * @param {Object} data Bag of data
	 * @param {Function} cb Callback executed after each App.actions.execute executions
	 * @this App
	 * @returns this
	 * @private
	 */
	var notifyModules = function (key, data, cb) {
		var actions = resolveActions(key, data);
		App.actions.execute(actions, key, data, cb);
		return this;
	};
	
	/** Public Interfaces **/
	global.App = $.extend(true, global.App, {
		/**
		 * @namespace modules
		 * @memberof App
		 */
		modules: {
			
			/**
			 * Returns all the modules
			 * @name models
			 * @method
			 * @memberof modules
			 * @returns {Object} All modules models
			 * @public
			 */
			models: function () {
				return modules;
			},
			
			/**
			 * Register the module and make sure his key is unique
			 * @name exports
			 * @method
			 * @memberof modules
			 * @param {String} key Module's unique identifier
			 * @param {Object} module The module object
			 * @param {Boolean} override Flag to control overwriting a module
			 * @returns {Object} The newly created module
			 * @public
			 */
			exports: exportModule,
			
			/**
			 * Resolves and execute the action on all modules
			 * @name notify
			 * @method
			 * @memberof modules
			 * @param {String} key Notify key
			 * @param {Object} data Bag of data
			 * @param {Function} cb Callback executed after each App.actions.execute executions
			 * @this App
			 * @returns this
			 * @public
			 */
			notify: notifyModules,

			/**
			 * Resolves the key action on all modules
			 * @name resolve
			 * @method
			 * @memberof modules
			 * @param {String} key Notify key
			 * @param {Object} data Bag of data
			 * @returns {Array} Array of read/write objects for all modules
			 * @public
			 */
			resolve: resolveActions
		}
	
	});
	
})(jQuery, window);

/**
 * Pages are controller that are activated on a url basis.
 *
 * @fileoverview Defines and exports pages
 *
 * @author Deux Huit Huit <https://deuxhuithuit.com>
 * @license MIT <https://deuxhuithuit.mit-license.org>
 *
 * @namespace pages
 * @memberof App
 * @requires App
 */
(function ($, global, undefined) {
	'use strict';
	
	var pageModels = {};
	var pageInstances = {};

	/**
	 * Creates and a new factory function based on the
	 * given parameters
	 * @name createPageModel
	 * @memberof pages
	 * @method
	 * @param {String} key The unique key for this page model
	 * @param {pageParam|pageCreator} model A page object that conforms with the pageParam type
	 *   or a pageCreator function that returns a page object.
	 * @param {Boolean} [override=false] Allows overriding an existing page model
	 *
	 * @returns {pageModel} The newly built factory function
	 * @private
	 */
	var createPageModel = function (key, model, override) {
		var ftrue = function () {
			return true;
		};
		
		var enterLeave = function (next) {
			App.callback(next);
		};

		/**
		 * Page Param
		 * @memberof pages
		 * @typedef {Object} pageParam
		 * @param {Function} actions @returns {object}
		 * @param {Function} init
		 * @param {Function} enter
		 * @param {Function} leave
		 * @param {Function} canEnter @returns {boolean}
		 * @param {Function} canLeave @returns {boolean}
		 */
		var base = {
			actions: $.noop,
			init: $.noop,
			enter: enterLeave,
			leave: enterLeave,
			canEnter: ftrue,
			canLeave: ftrue
		};
		
		/**
		 * Page Model is a Factory function for page instances.
		 * @name factory
		 * @memberof pages
		 * @method
		 * @param {Object} pageData PageObject
		 * @returns page
		 * @private
		 */
		var factory = function (pageData) {
			var modelRef;
			
			if ($.isPlainObject(model)) {
				modelRef = model;
			} else if ($.isFunction(model)) {
				modelRef = model.call(this, key, pageData, override);
				if (!$.isPlainObject(modelRef)) {
					App.log({
						args: [
							'The exported page model function must return an object, ' +
							'`%s` given (%s)', $.type(modelRef), modelRef
						],
						fx: 'error'
					});
					return null;
				}
			} else {
				App.log({
					args: [
						'The exported page model must be an object or a function, ' +
						'`%s` given (%s)', $.type(model), model
					],
					fx: 'error'
				});
				return null;
			}
			
			var getKey = function () {
				return pageData.key;
			};
			
			var routes = function () {
				return pageData.routes;
			};
			
			var loaded = function () {
				return !!$(getKey()).length;
			};
			
			// recuperate extra params...
			var data = function () {
				return pageData;
			};
			
			// insure this can't be overriden
			var overwrites = {
				key: getKey, // css selector
				loaded: loaded,
				routes: routes,
				data: data
			};
			
			// New deep copy object
			return $.extend(true, {}, base, modelRef, overwrites);
		};
		
		return factory;
	};
	
	/**
	 * Creates a page with the specified model.
	 * @name createPage
	 * @memberof pages
	 * @method
	 * @param {Object} pageData An data bag for your page
	 * @param {String} keyModel The page model's unique key
	 * @param {Boolean} [override=false] Allows overriding an existing page instance
	 * @returns {?page} Null if something goes wrong
	 * @private
	 */
	var createPage = function (pageData, keyModel, override) {
		//Find the page model associated
		var pageModel = pageModels[keyModel];
		var pageInst;
		
		if (!pageModel) {
			App.log({args: ['Model `%s` not found', keyModel], fx: 'error'});
		} else {
			//Check to not overide an existing page
			if (!!pageInstances[pageData.key] && !override) {
				App.log({
					args: ['Overwriting page key `%s` is not allowed', pageData.key],
					fx: 'error'
				});
			} else {
				pageInst = pageModel(pageData);
				if (!!pageInst) {
					pageInstances[pageData.key] = pageInst;
				}
				return pageInst;
			}
		}
		return false;
	};

	/**
	 * Registers a pageModel instance.
	 * @name registerPageModel
	 * @memberof pages
	 * @method
	 * @param {String} key The model unique key
	 * @param {pageModel} pageModel The page model
	 * @param {Boolean} [override=false] Allows overriding an existing page instance
	 *
	 * @returns {pageModel}
	 * @private
	 */
	var registerPageModel = function (key, pageModel, override) {
		var keyType = $.type(key);
		if (keyType !== 'string') {
			App.log({
				args: ['`key` must be a string, `%s` given (%s).', keyType, key],
				fx: 'error'
			});
		// Found an existing page and cannot override it
		} else if (!!pageModels[key] && !override) {
			//error, should not override an existing key
			App.log({
				args: ['Overwriting page model key `%s` is not allowed', key],
				fx: 'error'
			});
		} else {
			// Store page to the list
			pageModels[key] = pageModel;
			return pageModel;
		}
		return false;
	};
	
	/**
	 * Create a new pageModel, i.e. a function to create a new pages.
	 * It first calls {@link createPageModel} and then calls {@link registerPageModel}
	 * with the output of the first call.
	 * @name exportPage
	 * @memberof pages
	 * @method
	 * @param {String} key The model unique key
	 * @param {pageParam|pageCreator} model A page object that conforms with the pageParam type
	 *   or a pageCreator function that returns a page object.
	 * @param {Boolean} [override=false] Allows overriding an existing page instance
	 *
	 * @return {pageModel}
	 * @private
	 */
	var exportPage = function (key, model, override) {
		// Pass all args to the factory
		var pageModel = createPageModel(key, model, override);
		// Only work with pageModel afterwards
		return registerPageModel(key, pageModel, override);
	};
	
	/**
	 * Validate a route object
	 * @name validateRoute
	 * @memberof pages
	 * @method
	 * @returns {Boolean}
	 * @private
	 */
	var validateRoute = function (route) {
		var result = false;
		
		if (!route) {
			App.log({args: 'No route set.', fx: 'error'});
		} else {
			result = true;
		}
		
		return result;
	};
	
	var routeMatchStagegies = {
		regexp: function (testRoute, route, cb) {
			if (testRoute.test(route)) {
				return cb();
			}
		},
		string: function (testRoute, route, cb) {
			var regex;
			// be sure to escape uri
			route = decodeURIComponent(route);
			
			// be sure we do not have hashed in the route
			route = route.split('#')[0];
			
			// avoid RegExp if possible
			if (testRoute == route) {
				return cb();
			}
			
			// assure we are testing from the beginning
			if (testRoute.indexOf('^') !== 0) {
				testRoute = '^' + testRoute;
			}
			
			// assure we are testing until the end
			if (testRoute.indexOf('^') !== testRoute.length - 1) {
				testRoute = testRoute + '$';
			}
			
			// wildcard replace
			// avoid overloading routes with regex
			if (testRoute.indexOf('*')) {
				// a-zA-Z0-9 ,:;.=%$|—_/\\-=?&\\[\\]\\\\#
				testRoute = testRoute.replace(new RegExp('\\*', 'gi'), '.*');
			}
			
			try {
				regex = new RegExp(testRoute);
			} catch (ex) {
				App.log({
					args: ['Error while creating RegExp %s.\n%s', testRoute, ex],
					fx: 'error'
				});
			}
			
			if (!!regex && regex.test(route)) {
				return cb();
			}
		}
	};
	
	/**
	 * Tries to match the given route against the given
	 * array of possible routes.
	 * @name matchRoute
	 * @memberof pages
	 * @method
	 * @param {String} route The route to search match for
	 * @param {String[]|RegExp[]} routes The allowed routes
	 *
	 * @returns {Integer} The index of the matched route or -1 if no match
	 * @private
	 */
	var matchRoute = function (route, routes) {
		var index = -1;
		var found = function (i) {
			index = i;
			return false; // exit each
		};
		
		if ($.type(route) !== 'string') {
			App.log({args: '`route` must be a string', fx: 'error'});
			return index;
		}
		
		if (!!~route.indexOf('?')) {
			route = route.split('?')[0];
		}
		
		if (!!route && !!routes) {
			$.each(routes, function matchOneRoute (i, testRoute) {
				var routeType = $.type(testRoute);
				var routeStrategy = routeMatchStagegies[routeType];
				var cb = function () {
					return found(i);
				};
				
				if ($.isFunction(routeStrategy)) {
					return routeStrategy(testRoute, route, cb);
				} else if (testRoute === route) {
					return found(i);
				}
				return true;
			});
		}
		
		return index;
	};

	/**
	 * Returns the first page object that matches the route param
	 * @name getPageForRoute
	 * @memberof pages
	 * @method
	 * @param {String} route The route to search match for
	 *
	 * @returns {?page} The page object or null if not found
	 * @private
	 */
	var getPageForRoute = function (route) {
		var page = null;
		if (validateRoute(route)) {
			$.each(pageInstances, function walkPage () {
				var routes = this.routes();
				// route found ?
				if (!!~matchRoute(route, routes)) {
					page = this;
					return false; // exit
				}
			});
		}
		return page;
	};

	/** Public Interfaces **/
	global.App = $.extend(true, global.App, {
		pages: {
			/**
			 * @name matchRoute
			 * @method
			 * @memberof pages
			 * {@link App.pages~matchRoute}
			 * @private
			 */
			matchRoute: matchRoute,

			/**
			 * @name validateRoute
			 * @method
			 * @memberof pages
			 * {@link App.pages~validateRoute}
			 * @private
			 */
			validateRoute: validateRoute,

			/**
			 * Getter for all instances of a particular one
			 * @param [key] - the optinal key to search for.
			 *   If falsy, will return all instances
			 * @returns {page|page[]}
			 * @private
			 */
			instances: function (key) {
				if (!!key) {
					return pageInstances[key];
				}
				return pageInstances;
			},

			/**
			 * Returns all models
			 * @method
			 * @name models
			 * @memberof pages
			 * @returns {Object}
			 * @public
			 */
			models: function () {
				return pageModels;
			},

			/**
			 * Returns the first page object that matches the route param
			 * @name getPageForRoute
			 * @memberof pages
			 * @method
			 * @param {String} route The route to search match for
			 *
			 * @returns {?page} The page object or null if not found
			 * @public
			 */
			getPageForRoute: getPageForRoute,

			/**
			 * Returns the page based the key and fallbacks to
			 * the [route]{@link getPageForRoute} if noting is found.
			 * @name page
			 * @method
			 * @memberof pages
			 * @param {string} keyOrRoute - the key or the route of the page
			 * @returns {page}
			 * @public
			 */
			page: function (keyOrRoute) {
				//Try to get the page by the key
				var result = pageInstances[keyOrRoute];
				
				//if no result found try with the route
				if (!!!result) {
					result = getPageForRoute(keyOrRoute);
				}
				
				return result;
			},

			/**
			 * Creates a page with the specified model.
			 * @name create
			 * @memberof pages
			 * @method
			 * @param {Object} pageData An data bag for your page
			 * @param {String} keyModel The page model's unique key
			 * @param {Boolean} [override=false] Allows overriding an existing page instance
			 * @returns {?page} Null if something goes wrong
			 * @public
			 */
			create: createPage,

			/**
			 * Create a new pageModel, i.e. a function to create a new pages.
			 * It first calls {@link createPageModel} and then calls {@link registerPageModel}
			 * with the output of the first call.
			 * @name exports
			 * @memberof pages
			 * @method
			 * @param {String} key The model unique key
			 * @param {pageParam|pageCreator} model A page object that conforms
			 *   with the pageParam type or a pageCreator function that returns a page object.
			 * @param {pageParam|pageCreator} model A page object that conforms with the
			 *   pageParam type or a pageCreator function that returns a page object.
			 * @param {Boolean} [override=false] Allows overriding an existing page instance
			 *
			 * @return {pageModel}
			 * @public
			 */
			exports: exportPage
		}
	});
	
})(jQuery, window);

/**
 * App routing
 *
 * @fileoverview Utility
 *
 * @author Deux Huit Huit <https://deuxhuithuit.com>
 * @license MIT <https://deuxhuithuit.mit-license.org>
 *
 * @namespace routing
 * @memberof App
 * @requires App
 */
(function ($, global, undefined) {
	'use strict';

	/**
	 * Factory for the query string parser
	 * @return {Object} accessible methods
	 */
	var queryStringParser = (function () {
		var a = /\+/g; // Regex for replacing addition symbol with a space
		var r = /([^&=]+)=?([^&]*)/gi;
		var d = function (s) {
			return decodeURIComponent(s.replace(a, ' '));
		};

		/**
		 * Format the querystring into an object
		 * @name prase
		 * @memberof querystring
		 * @method
		 * @param {String} qs
		 * @returns {Object}
		 * @public
		 */
		var parse = function (qs) {
			var u = {};
			var e, q;

			//if we dont have the parameter qs, use the window location search value
			if (qs !== '' && !qs) {
				qs = window.location.search;
			}

			//remove the first caracter (?)
			q = qs.substring(1);

			while ((e = r.exec(q))) {
				u[d(e[1])] = d(e[2]);
			}

			return u;
		};

		/**
		 * Format the object into a valid query string
		 * @name stringify
		 * @memberof querystring
		 * @method
		 * @param {Object} qs Object needed to be transformed into a string
		 * @returns {String} Result
		 * @public
		 */
		var stringify = function (qs) {
			var aqs = [];
			$.each(qs, function (k, v) {
				if (!!v) {
					aqs.push(k + '=' + global.encodeURIComponent(v));
				}
			});
			if (!aqs.length) {
				return '';
			}
			return '?' + aqs.join('&');
		};

		return {
			parse: parse,
			stringify: stringify
		};
	})();

	/** Public Interfaces **/
	global.App = $.extend(true, global.App, {
		routing: {

			/**
			 * Facade to parse and stringify a query string
			 * @namespace querystring
			 * @constant
			 * @property {Function} parse Parse the current queryString or the
			 *   provided one returns an object
			 * @property {Function} stringify Stringify the provided queryString
			 *   and returns a String
			 * @memberof routing
			 * @public
			 */
			querystring: queryStringParser
		}
	});

})(jQuery, window);

/**
 * Facade to access the browser's localstorage and session storage
 *
 * @fileoverview Storage facade compatible with localStorage and sessionStorage
 *
 * @author Deux Huit Huit <https://deuxhuithuit.com>
 * @license MIT <https://deuxhuithuit.mit-license.org>
 *
 * @namespace storage
 * @memberof App
 * @requires App
 */
(function ($, global, undefined) {
	'use strict';

	var storage = function (storage) {
		return {

			/**
			 * Return the value associated with the given key
			 * @name get
			 * @memberof storage
			 * @method
			 * @param {string} key Access key to the storage object
			 * @return {String}
			 * @public
			 */
			get: function (key) {
				if (!key) {
					return;
				}
				key += ''; // make it a string
				return storage[key];
			},

			/**
			 * Set and save a value to the given key in the storage
			 * @name set
			 * @memberof storage
			 * @method
			 * @param {string} key Access key to the storage object
			 * @param {*} value Value wanted to be saved
			 * @return {Boolean}
			 * @public
			 */
			set: function (key, value) {
				var result = false;
				if (!!key) {
					key += ''; // make it a string
					try {
						storage[key] = !value ? '' : value + '';
						result = true;
					} catch (e) {
						App.log({
							args: e.message,
							me: 'Storage',
							fx: 'error'
						});
						result = false;
					}
				}
				return result;
			},

			/**
			 * Delete the storage data associated with the given key
			 * @name remove
			 * @memberof storage
			 * @method
			 * @param {string} key Access key to the storage object
			 * @return {Boolean}
			 * @public
			 */
			remove: function (key) {
				var result = false;
				if (!!key) {
					key += ''; // make it a string
					try {
						storage.removeItem(key);
						result = true;
					} catch (e) {
						App.log({
							args: e.message,
							me: 'Storage',
							fx: 'error'
						});
						result = false;
					}
				}
				return result;
			},

			/**
			 * Delete the data from the storage matching
			 * the Regular Expression or all the data if none is provided
			 * @name clear
			 * @memberof storage
			 * @method
			 * @param {RegExp} regexp Regular Expression to match the key
			 * @return {Boolean}
			 * @public
			 */
			clear: function (regexp) {
				var result = false;
				try {
					if (!regexp) {
						storage.clear();
					} else {
						var remove = [];
						for (var i = 0; i < storage.length; i++) {
							var key = storage.key(i);
							if (regexp.test(key)) {
								remove.push(key);
							}
						}
						for (i = 0; i < remove.length; i++) {
							storage.removeItem(remove[i]);
						}
					}
					result = true;
				} catch (e) {
					App.log({
						args: e.message,
						me: 'Storage',
						fx: 'error'
					});
					result = false;
				}
				return result;
			}
		};
	};


	global.App = $.extend(true, global.App, {
		storage: {

			/**
			 * Factory of the storage object
			 * @name factory
			 * @method
			 * @memberof storage
			 * @returns {Object} All storage's methods
			 * @public
			 */
			factory: storage,

			/**
			 * Storage methods in localStorage mode
			 * @name local
			 * @constant
			 * @public
			 * @memberof storage
			 */
			local: storage(window.localStorage),

			/**
			 * Storage methods in sessionStorage mode
			 * @name session
			 * @constant
			 * @public
			 * @memberof storage
			 */
			session: storage(window.sessionStorage)
		}
	});
	
})(jQuery, window);

/**
 * Superlight App Framework
 *
 * @fileoverview Defines the App
 *
 * @author Deux Huit Huit <https://deuxhuithuit.com>
 * @license MIT <https://deuxhuithuit.mit-license.org>
 *
 * @requires jQuery
 * @namespace App
 */
(function ($, global, undefined) {
	'use strict';
	
	//Default value
	var ROOT = 'body';
	
	/**
	 * Init All the applications
	 * Assign root variable
	 * Call init on all registered page and modules
	 * @name initApplication
	 * @memberof App
	 * @method
	 * @fires App#app:init
	 * @fires App#app:pageNotFound
	 * @param {String} root CSS selector
	 * @private
	 */
	var initApplication = function (root) {
		// assure root node
		if (!!root && !!$(root).length) {
			ROOT = root;
		}
		
		// init each Modules
		$.each(App.modules.models(), function initModule () {
			this.init();
		});
		
		// init each Page already loaded
		$.each(App.pages.instances(), function initPage () {
			if (!!this.loaded()) {
				// init page
				this.init({firstTime: true});
				this.isInited = true;
				// set mediator state
				App.mediator.init(this);
			}
		});
		
		App.mediator.notify('app.init', {
			page: App.mediator.getCurrentPage()
		});
		
		if (!App.mediator.getCurrentPage()) {
			App.modules.notify('app.pageNotFound');
			App.log({ args: 'No current page set, pages will not work.', fx: 'error' });
		}
	};
	
	/**
	 * Init the app with the given css selector
	 * @name run
	 * @memberof App
	 * @method
	 * @param {String} root CSS selector
	 * @private
	 */
	var run = function (root) {
		initApplication(root);
		return global.App;
	};
	
	/** Public Interfaces **/
	global.App = $.extend(true, global.App, {
		/**
		 * Get the root css selector
		 * @name root
		 * @method
		 * @memberof App
		 * @returns {String} Root CSS selector
		 * @public
		 */
		root: function () {
			return ROOT;
		},
		
		/**
		 * Init the app with the given css selector
		 * @name run
		 * @memberof App
		 * @method
		 * @param {Object} App
		 * @public
		 */
		run: run
	});
	
})(jQuery, window);

/**
 * General customization alongside the framework
 *
 * @author Deux Huit Huit <https://deuxhuithuit.com>
 * @license MIT <https://deuxhuithuit.mit-license.org>
 *
 * @requires jQuery
 * @requires App
 */
(function ($, global, undefined) {
	'use strict';

	if (!!global.App && !!global.App.device) {
		(function (h, deviceClasses) {
			deviceClasses.forEach(function (c) {
				if (!!App.device[c]) {
					h.addClass(c);
				}
			});
		})($('html'), [
			'iphone', 'ipad', 'ios',
			'android',
			'mobile', 'phone', 'tablet', 'touch',
			'chrome', 'firefox', 'safari', 'internetexplorer', 'edge'
		]);

		// easing support
		$.easing.def = (App.device.mobile ? 'linear' : 'easeOutQuad');
	}

	/**
	 * Patching console object.
	 * @see https://developers.google.com/chrome-developer-tools/docs/console-api
	 */
	var consoleFx = ['assert', 'clear', 'count', 'debug', 'dir', 'dirxml', 'error', 'group',
		'group', 'group', 'info', 'log', 'profile', 'profile', 'time', 'time', 'time',
		'trace', 'warn'];

	/**
	 * Console support
	 * @global
	 */
	if (!global.console) {
		global.console = {};
	}

	$.each(consoleFx, function (i, key) {
		global.console[key] = global.console[key] || $.noop;
	});

	/**
	 * Facade to stop the propagation of events
	 * @name pd
	 * @method
	 * @param {Event} e Event object
	 * @param {Boolean} stopPropagation Flag to stop the event propagation or not
	 * @returns {Boolean} false, always.
	 * @global
	 * @public
	 */
	global.pd = function (e, stopPropagation) {
		if (!!e) {
			if ($.isFunction(e.preventDefault)) {
				e.preventDefault();
			}
			if (stopPropagation !== false && $.isFunction(e.stopPropagation)) {
				e.stopPropagation();
			}
		}
		return false;
	};
	
})(jQuery, window);
