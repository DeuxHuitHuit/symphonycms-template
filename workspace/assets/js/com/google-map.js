/**
 * @author Deux Huit Huit
 *
 * Google maps component
 *
 * It needs to have the API key in the DOM as
 * <script data-gmap-key="<YOUR KEY>"></script>
 */
(function ($, win, global, undefined) {

	'use strict';
	
	App.components.exports('googleMap', function (o) {
		var MAX_RETRIES = 40;
		var scope;
		var container;
		var markers = [];
		var map;
		var mapIsReady = false;
		var openedMarker;
		var urlGoogleMaps = 'https://maps.googleapis.com/maps/api/js?key=' +
			$('[data-gmap-key]').attr('data-gmap-key');
		var urlInfobox = 'https://cdn.jsdelivr.net/gh/googlemaps/v3-utility-library@' +
			'4cd67683a905265bfe5108205d8fff676eced4d8/infobox/src/infobox_packed.js';
		
		var closeAllPopup = function () {
			if (!!openedMarker) {
				openedMarker.infowindow.close();
			}
		};
		
		var defaultMapOptions = {
			selectorCtn: '',
			defaultMarkerOptions: {},
			mapTypeId: null,
			zoom: 10,
			markerAction: function () {
				var reelPosition = new google.maps.LatLng(
					this.getPosition().lat() + 0.005,
					this.getPosition().lng());
				map.panTo(reelPosition);
				
				closeAllPopup();
				this.infowindow.open(map, this);
				openedMarker = this;
			},
			beforeCreate: null,
			afterCreate: null,
			boundsChanged: null,
			dragBoundsChanged: null,
			dragBoundsChangedDelay: 250,
			drag: null,
			styles: []
		};
		
		var mapOptions = $.extend({}, defaultMapOptions, o);
		
		var googleGeocoder = function () {
			return !!global.google && !!google.maps && !!google.maps.Geocoder;
		};
		
		// GEO LOCALISATION
		var geolocAddress = function (data, callback) {
			App.loaded(googleGeocoder, function () {
				var geo = new google.maps.Geocoder();
				var res;

				geo.geocode(data, function (results, status) {
					if (status == google.maps.GeocoderStatus.OK) {
						res = results[0].geometry.location;
					}
					
					App.callback(callback, [res, results]);
				});
			}, MAX_RETRIES);
		};
		
		var addMarker = function (o) {
			
			var markerOption = $.extend({}, mapOptions.defaultMarkerOptions, o);
			
			if (markerOption.iconImage) {
				markerOption.iconImage = new google.maps.MarkerImage(
					markerOption.iconImage.src,
					new google.maps.Size(
						markerOption.iconImage.size.width,
						markerOption.iconImage.size.height
					),
					new google.maps.Point(
						markerOption.iconImage.p1.x,
						markerOption.iconImage.p1.y
					),
					new google.maps.Point(
						markerOption.iconImage.p2.x,
						markerOption.iconImage.p2.y
					)
				);
			}
			if (markerOption.position) {
				markerOption.LatLng = new google.maps.LatLng(
					markerOption.position.latitude,
					markerOption.position.longitude
				);
			}

			var marker = new google.maps.Marker({
				position: markerOption.LatLng,
				map: map,
				icon: markerOption.iconImage,
				shadow: markerOption.iconShadow,
				zIndex: markerOption.zIndex,
				animation: markerOption.animation,
				optimized: false
			});
			
			markers.push(marker);
			
			//If we have content add the infoWindow
			if (markerOption.content && markerOption.content.length) {
				marker.infowindow = new google.maps.InfoWindow({
					content: markerOption.content
				});
				
				google.maps.event.addListener(marker, 'click', mapOptions.markerAction);
			} else if (markerOption.markerCustomAction) {
				google.maps.event.addListener(marker, 'click', function () {
					App.callback(markerOption.markerCustomAction, [map, marker]);
				});
			} else if (mapOptions.markerCustomAction) {
				google.maps.event.addListener(marker, 'click', function () {
					App.callback(mapOptions.markerCustomAction, [map, marker]);
				});
			}
			
			return marker;
		};
		
		var createMap = function () {
			App.callback(mapOptions.beforeCreate, [google.maps, mapOptions, container]);
			
			if (mapOptions.center) {
				mapOptions.center = new google.maps.LatLng(
					mapOptions.center.latitude,
					mapOptions.center.longitude
				);
			}
			if (!!google.maps.MapTypeId[mapOptions.mapTypeId]) {
				mapOptions.mapTypeId = google.maps.MapTypeId[mapOptions.mapTypeId];
			}
			else {
				mapOptions.mapTypeId = google.maps.MapTypeId.ROADMAP;
			}
			map = new google.maps.Map(container.get(0), mapOptions);
			
			if (!!mapOptions.boundsChanged) {
				google.maps.event.addListener(map, 'bounds_changed', function () {
					var bounds = map.getBounds();
					App.callback(mapOptions.boundsChanged, [bounds]);
				});
			}
			if (!!mapOptions.dragBoundsChanged) {
				var debouncedDragEnd = _.debounce(function () {
					var bounds = map.getBounds();
					App.callback(mapOptions.dragBoundsChanged, [bounds]);
				}, mapOptions.dragBoundsChangedDelay);
				google.maps.event.addListener(map, 'dragend', debouncedDragEnd);
			}
			if (!!mapOptions.drag) {
				google.maps.event.addListener(map, 'drag', function () {
					var bounds = map.getBounds();
					App.callback(mapOptions.drag, [bounds]);
				});
			}
			google.maps.event.addListenerOnce(map, 'idle', function () {
				mapIsReady = true;
				App.callback(mapOptions.ready, [google.maps]);
			});
			
			App.callback(mapOptions.afterCreate, [google.maps]);
		};
		
		var googleMap = function () {
			return !!global.google && !!google.maps && !!google.maps.Map;
		};
		
		var initMap = function () {
			if (!container.hasClass('map-loaded')) {
				createMap();
				container.addClass('map-loaded');
			}
		};
		
		var loadDeps = function (ready) {
			ready = ready || $.noop;
			if (!window.isMapApiLoaded) {
				$.getScript(urlGoogleMaps).then(function () {
					$.getScript(urlInfobox).then(ready);
				});
				window.isMapApiLoaded = true;
			} else {
				ready();
			}
		};
		
		var init = function (s, options, initCompleteCallback) {
			mapOptions = $.extend(mapOptions, options);
			scope = s;
			container = scope.find(mapOptions.selectorCtn);
			var ready = function () {
				App.loaded(googleMap, function () {
					initMap();
					App.callback(initCompleteCallback);
				}, MAX_RETRIES);
			};
			
			loadDeps(ready);
		};
		
		return {
			init: init,
			loadDeps: loadDeps,
			addMarker: addMarker,
			center: function (lat, lng) {
				map.panTo(new google.maps.LatLng(lat, lng));
				App.log('[map] center ' + lat + ', ' + lng);
			},
			zoom: function (value) {
				map.setZoom(value);
				App.log('[map] zoom ' + value);
			},
			fitBounds: function (viewport, padding) {
				map.fitBounds(new google.maps.LatLngBounds(
					viewport.southwest, viewport.northeast
				), padding);
				App.log('[map] fitBound ' +
					viewport.southwest.lng() + ', ' +
					viewport.southwest.lat() + ' - ' +
					viewport.northeast.lng() + ', ' +
					viewport.northeast.lat()
				);
			},
			bounds: function () {
				return map.getBounds();
			},
			decZoom: function () {
				map.setZoom(Math.min(1, map.getZoom() - 1));
				App.log('[map] decZoom');
			},
			closeAllPopup: closeAllPopup,
			setMarkerVisibility: function (marker, isVisible) {
				marker.setVisible(isVisible);
			},
			getMarkers: function () {
				return markers;
			},
			geolocAddress: geolocAddress,
			googleMap: function () {
				return googleMap();
			},
			mapIsReady: function () {
				return googleMap() && !!map && !!mapIsReady;
			},
			addListenerOnce: function (event, fn) {
				return google.maps.event.addListenerOnce(map, event, fn);
			},
			getZoom: function () {
				return map.getZoom();
			}
		};
	});
	
})(jQuery, jQuery(window), window);
