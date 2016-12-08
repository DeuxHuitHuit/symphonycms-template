/**
 * @author Deux Huit Huit
 *
 * Dev only helpers
 */

(function ($, global, undefined) {
	
	global.lr = function () {
		return less.refresh(true);
	};
	
	less.pageLoadFinished.then(function () {
		$(window).trigger('resize');
	});
	
})(jQuery, window);
