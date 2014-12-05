/**
 * @author Deux Huit Huit
 *
 * Dev only code
 */

(function ($, global, undefined) {
	
	global.lr = function () {
		return less.refresh(true);
	};
	
	less.pageLoadFinished.then(function () {
		$(window).trigger('resize');
	});
	
	function x(x) {
		return x * 10;
	}
	x('allo');
	
})(jQuery, window);