import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FlutterFlowGoogleMap extends StatelessWidget {
  final GoogleMapController? controller;
  final Function(LatLng)? onCameraIdle;
  final LatLng initialLocation;
  final Color markerColor;
  final MapType mapType;
  final String mapStyle;
  final double initialZoom;
  final bool allowInteraction;
  final bool allowZoom;
  final bool showZoomControls;
  final bool showLocation;
  final bool showCompass;
  final bool showMapToolbar;
  final bool showTraffic;
  final bool centerMapOnMarkerTap;

  const FlutterFlowGoogleMap({
    Key? key,
    this.controller,
    this.onCameraIdle,
    required this.initialLocation,
    this.markerColor = Colors.blue,
    this.mapType = MapType.normal,
    this.mapStyle = '[]',
    this.initialZoom = 14.0,
    this.allowInteraction = true,
    this.allowZoom = true,
    this.showZoomControls = true,
    this.showLocation = true,
    this.showCompass = false,
    this.showMapToolbar = false,
    this.showTraffic = false,
    this.centerMapOnMarkerTap = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: (GoogleMapController googleMapController) {
       /* if (controller != null) {
          controller!.complete(googleMapController);
        }*/
      },
      initialCameraPosition: CameraPosition(
        target: initialLocation,
        zoom: initialZoom,
      ),
      markers: {
        Marker(
          markerId: MarkerId('static_marker'),
          position: initialLocation,
          icon: BitmapDescriptor.defaultMarkerWithHue(
            _getMarkerColor(markerColor),
          ),
        ),
      },
      mapType: mapType,
      trafficEnabled: showTraffic,
      compassEnabled: showCompass,
      myLocationEnabled: showLocation,
      zoomControlsEnabled: showZoomControls,
      zoomGesturesEnabled: allowZoom,
      scrollGesturesEnabled: allowInteraction,
      rotateGesturesEnabled: allowInteraction,
      tiltGesturesEnabled: allowInteraction,
      onCameraIdle: () {
        if (onCameraIdle != null) {
          onCameraIdle!(initialLocation);
        }
      },
    );
  }

  // Method to get color value from the Color object
  double _getMarkerColor(Color color) {
    return (color == Colors.blue) ? BitmapDescriptor.hueBlue : BitmapDescriptor.hueViolet;
  }
}