/**
 *  @author Deux Huit Huit
 *
 *  Change state
 *
 *
 *  ATTRIBUTES :
 *      (OPTIONAL)
 *      - data-{state}-state-add-class : List of class added when state goes on
 *      - data-{state}-state-rem-class : List of class removed when state goes on
 *
 *      - data-{state}-state-follower : List of selector separated by ','
 *      - data-{state}-state-follower-common-ancestor (if not present: this will be used)
 *
 *      - data-{state}-state-notify-on: custom list of notification separated by ','
 *             called when switching state to on. Data passed : {item:this}
 *      - data-{state}-state-notify-off: custom list of notification separated by ','
 *             called when switching state to off. Data passed : {item:this}
 *
 *  NOTIFY IN :
 *      - changeState.update
 *          {item,state,flag}
 *
 *
 *  NOTIFY OUT :
 *      - changeState.begin
 *          {item,state,flag}
 *      - changeState.end
 *          {item,state,flag}
 *
 */
(function ($, undefined) {
	
	'use strict';
	var win = $(window);

	var isSvgElement = function (item) {
		return !!item && !!item.length && (
			item[0].nodeName == 'polygon' ||
			item[0].nodeName == 'polyline' ||
			item[0].nodeName == 'path' ||
			item[0].nodeName == 'g' ||
			item[0].nodeName == 'circle' ||
			item[0].nodeName == 'rect' ||
			item[0].nodeName == 'text'
		);
	};

	var notifyChanges = function (notifyOn, notifyOff, item, state, flag) {
		if (flag && notifyOn.length) {
			$.each(notifyOn.split(','), function (i, e) {
				App.mediator.notify(e, {item: item, state: state, flag: flag});
			});
		} else if (!flag && notifyOff.length) {
			$.each(notifyOff.split(','), function (i, e) {
				App.mediator.notify(e, {item: item, state: state, flag: flag});
			});
		}
	};

	var doSetItemState = function (item, state, flag) {
		if (!item || !item.length || !item[0]) {
			App.log('Called `doSetItemState` on an empty element collection, aborting.');
			return;
		}

		var flagClass = 'is-' + state;
		var addClass = item.attr('data-' + state + '-state-add-class');
		var remClass = item.attr('data-' + state + '-state-rem-class');
		var notifyOn = item.attr('data-' + state + '-state-notify-on') || '';
		var notifyOff = item.attr('data-' + state + '-state-notify-off') || '';
		var notifyOnAfter = item.attr('data-' + state + '-state-notify-on-after') || '';
		var notifyOffAfter = item.attr('data-' + state + '-state-notify-off-after') || '';

		notifyChanges(notifyOn, notifyOff, item, state, flag);

		var ieBehavior = function () {
			//IE BEHAVIOR
			var newClass = [];
			var curClass = item.attr('class').split(' ');
			var finalClass = '';

			var ieOn = function () {
				var remClassArray = [];
				if (remClass) {
					remClassArray = remClass.split(' ');
				}

				//Add New class
				if (addClass) {
					newClass.push(addClass.split(' '));
				}
				
				//Add Flag class
				newClass.push(flagClass);

				//Remove class
				$.each(curClass, function (i, e) {

					if (remClassArray.indexOf(e) == -1) {
						newClass.push(e);
					}
				});
				
				$.each(newClass, function (i, e) {
					finalClass += ' ' + e;
				});

				//Set class attribute
				item.attr('class', finalClass);
			};

			var ieOff = function () {
				//Remove Add class and flag class
				var addClassArray = [];
				if (addClass) {
					addClassArray = addClass.split(' ');
				}

				$.each(curClass, function (i, e) {
					if (e != flagClass) {
						if (addClassArray.indexOf(e) == -1) {
							newClass.push(e);
						}
					}
				});

				//Add Remove Class
				if (remClass) {
					newClass.push(remClass.split(' '));
				}

				$.each(newClass, function (i, e) {
					finalClass += ' ' + e;
				});

				item.attr('class', finalClass);
			};


			if (flag) {
				ieOn();
			} else {
				ieOff();
			}
		};

		var setSvgItemState = function () {
			if (!!item[0] && item[0].classList) {
				if (flag) {
					item[0].classList.add(addClass);
					item[0].classList.remove(remClass);
					item[0].classList.add(flagClass);
				} else {
					item[0].classList.remove(addClass);
					item[0].classList.add(remClass);
					item[0].classList.remove(flagClass);
				}
			} else {
				ieBehavior();
			}
		};

		if (isSvgElement(item)) {
			setSvgItemState();
		} else {
			if (flag) {
				//Set state
				item.addClass(addClass);
				item.removeClass(remClass);
				item.addClass(flagClass);
			} else {
				//Remove state
				item.removeClass(addClass);
				item.addClass(remClass);
				item.removeClass(flagClass);
			}
		}
		
		notifyChanges(notifyOnAfter, notifyOffAfter, item, state, flag);
	};

	var setItemState = function (item, state, flag) {
		//Flag class
		var followerCommonAncestor = item.attr('data-' + state + '-state-follower-common-ancestor');
		var followerSelector = item.attr('data-' + state + '-state-follower');
		var followerScope = item;

		if (followerCommonAncestor) {
			followerScope = item.closest(followerCommonAncestor);
		}
		
		var followers = followerScope.find(followerSelector);

		App.modules.notify('changeState.begin', {item: item, state: state, flag: flag});

		//Execute change
		doSetItemState(item, state, flag);

		//Process followers
		followers.each(function () {
			var it = $(this);
			setItemState(it, state, flag);
		});
		
		App.modules.notify('changeState.end', {item: item, state: state, flag: flag});
	};

	var processItem = function (item, state, action, callbacks) {
		var flagClass = 'is-' + state;
		var curBoolState = item.hasClass(flagClass);

		callbacks = callbacks ? callbacks : {};

		if (isSvgElement(item)) {
			if (item[0].classList) {
				curBoolState = item[0].classList.contains(flagClass);
			} else {
				//Ie Behavior
				var classList = item.attr('class').split(' ');
				curBoolState = classList.indexOf(flagClass) != -1;
			}
		}

		if (action == 'toggle') {
			setItemState(item, state, !curBoolState);

			if (curBoolState) {
				//Off callback
				App.callback(callbacks.off);
			} else {
				//On callback
				App.callback(callbacks.on);
			}
		} else if (action == 'on') {
			if (!curBoolState) {
				setItemState(item, state, true);

				//On callback
				App.callback(callbacks.on);
			}
		} else if (action == 'off') {
			if (curBoolState) {
				setItemState(item, state, false);

				//Off callback
				App.callback(callbacks.off);
			}
		} else {
			App.log('Action: ' + action +
				' is not recognized: Actions available are : toggle, on or off');
		}
	};

	var onUpdateState = function (key, data) {
		if (data && data.item && data.state && data.action) {
			var minWidth = data.item.attr('data-' + data.state + '-state-min-width');
			var maxWidth = data.item.attr('data-' + data.state + '-state-max-width');
			var isMinWidthValid = (!!minWidth && window.mediaQueryMinWidth(minWidth)) || !minWidth;
			var isMaxWidthValid = (!!maxWidth && window.mediaQueryMaxWidth(maxWidth)) || !maxWidth;
			
			if (isMinWidthValid && isMaxWidthValid) {
				processItem(data.item, data.state, data.action, data.callbacks);
			}
		}
	};
	
	var actions = function () {
		return {
			changeState: {
				update: onUpdateState
			}
		};
	};
	
	App.modules.exports('change-state', {
		actions: actions
	});
	
})(jQuery);
