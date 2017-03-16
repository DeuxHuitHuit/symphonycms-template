/**
 * @author Deux Huit Huit
 *
 * Duplicate id detector
 */

(function ($, global, undefined) {

	//Add custom module to keep ui in sync with the framework state
	if (App && App.modules && App.modules.exports) {

		var errorPanel = $('<div />');
		errorPanel.css({
			position: 'fixed',
			top: 0,
			left: 0,
			right: 0,
			bottom: 0,
			margin: 'auto',
			backgroundColor: 'rgba(255,0,0,0.8)',
			zIndex: 9999999
		}).addClass('flexbox flex-center');

		var errorPanelInner = $('<div />');
		errorPanelInner.css({
			padding: 30,
			minWidth: 200,
			backgroundColor: 'white'
		});

		errorPanel.append(errorPanelInner);

		var dataLoaded = function (key, data) {

			if (data && data.data) {
				//lookup elements
				var map = {};
				var duplicate = [];

				$(data.data).find('*[id]').each(function (i, e) {
					var id = $(e).attr('id');

					if (map[id]) {
						map[id].count += 1;
						map[id].nodes.push(e);
						duplicate.push(id);
					} else {
						map[id] = {
							count: 1,
							nodes: [e]
						};
					}
				});

				if (duplicate.length != 0) {
					//Error.. we have found some duplicate

					//Show error panel
					errorPanelInner.empty();
					errorPanelInner.append($('<h2>Duplicate id</h2>'));
					var ul = $('<ul />');
					errorPanelInner.append(ul);
					
					$('body').append(errorPanel);

					var text = 'Duplicate id found:';
					$.each(duplicate, function (i, e) {
						text += ' ' + e;
						var d = $('<li />')
						d.text(e);
						ul.append(d);
					});

					App.log({args: [text], fx: 'error'});
				}
			}
		};

		var init = function () {
			dataLoaded(null, {data: $('html')});
		};

		App.modules.exports('dev-duplicate-id-detector', {
			init: init,
			actions: function () {
				return {
					pages: {
						loaded: dataLoaded
					},
					articleChanger: {
						loaded: dataLoaded
					},
					infiniteScroll: {
						pageLoaded: dataLoaded
					}
				};
			}
		});
	}
	
})(jQuery, window);
