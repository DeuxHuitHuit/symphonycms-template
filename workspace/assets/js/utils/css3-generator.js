/**
 * @author Deux Huit Huit
 * 
 * css3 generators
 * 
 * Makes the use of CSS3 in javascript more easier
 */

(function ($, global, undefined) {
	
	'use strict';
	
	//var VENDOR_PREFIXES = ['', '-webkit-', '-moz-', '-o-', '-ms-'];
	
	/* jshint ignore:start */
	// from https://github.com/DeuxHuitHuit/jQuery-Animate-Enhanced/blob/master/scripts/src/jquery.animate-enhanced.js
	/* jshint ignore:end */
	var HAS_3D =  ('WebKitCSSMatrix' in window && 'm11' in new window.WebKitCSSMatrix());
	
	var _getTranslation = function (x, y, z) {
		x = !x || $.isNumeric(x) ? (x || 0) + 'px' : x;
		y = !y || $.isNumeric(y) ? (y || 0) + 'px' : y;
		z = !z || $.isNumeric(z) ? (z || 0) + 'px' : z;
		
		var prefix = (HAS_3D ? '3d(' : '(');
		var suffix = (HAS_3D ? ',' + z + ')' : ')');
		
		return 'translate' + prefix + x + ',' + y + suffix;
	};
	
	var _getRotation = function (x, y, z, theta) {
		x = !x || $.isNumeric(x) ? (x || 0) : x;
		y = !y || $.isNumeric(y) ? (y || 0) : y;
		z = !z || $.isNumeric(z) ? (z || 0) : z;
		theta = !theta || $.isNumeric(theta) ? (theta || 0) + 'deg' : theta;
		
		var prefix = (HAS_3D ? '3d('  + x + ',' + y + ',' + z + ',' : 'Z(');
		var suffix = (HAS_3D ? ')' : ')');
		
		return 'rotate' + prefix + theta + suffix;
	};
	
	global.CSS3 = {
		translate: _getTranslation,
		rotate: _getRotation,
		prefix: function (key, value) {
			var c = {};
			c[key] = value;
			c['-webkit-' + key] = value;
			c['-moz-' + key] = value;
			c['-ms-' + key] = value;
			c['-o-' + key] = value;
			return c;
		}
	};
	
})(jQuery, window);