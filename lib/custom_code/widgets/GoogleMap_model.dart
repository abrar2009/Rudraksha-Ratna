import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FlutterFlowGoogleMapModel with ChangeNotifier {
  // Google Maps controller
  GoogleMapController? _googleMapsController;
  GoogleMapController? get googleMapsController => _googleMapsController;
  set googleMapsController(GoogleMapController? controller) {
    _googleMapsController = controller;
    notifyListeners();
  }

  // Current center of the map
  LatLng _googleMapsCenter = LatLng(19.080046557699973, 72.89604328835297);
  LatLng get googleMapsCenter => _googleMapsCenter;
  set googleMapsCenter(LatLng center) {
    _googleMapsCenter = center;
    notifyListeners();
  }

  // Map settings
  bool _allowInteraction = true;
  bool get allowInteraction => _allowInteraction;
  set allowInteraction(bool value) {
    _allowInteraction = value;
    notifyListeners();
  }

  bool _allowZoom = true;
  bool get allowZoom => _allowZoom;
  set allowZoom(bool value) {
    _allowZoom = value;
    notifyListeners();
  }

  bool _showZoomControls = true;
  bool get showZoomControls => _showZoomControls;
  set showZoomControls(bool value) {
    _showZoomControls = value;
    notifyListeners();
  }

  bool _showLocation = true;
  bool get showLocation => _showLocation;
  set showLocation(bool value) {
    _showLocation = value;
    notifyListeners();
  }

  bool _showCompass = false;
  bool get showCompass => _showCompass;
  set showCompass(bool value) {
    _showCompass = value;
    notifyListeners();
  }

  bool _showMapToolbar = false;
  bool get showMapToolbar => _showMapToolbar;
  set showMapToolbar(bool value) {
    _showMapToolbar = value;
    notifyListeners();
  }

  bool _showTraffic = false;
  bool get showTraffic => _showTraffic;
  set showTraffic(bool value) {
    _showTraffic = value;
    notifyListeners();
  }

  bool _centerMapOnMarkerTap = true;
  bool get centerMapOnMarkerTap => _centerMapOnMarkerTap;
  set centerMapOnMarkerTap(bool value) {
    _centerMapOnMarkerTap = value;
    notifyListeners();
  }

  double _initialZoom = 14.0;
  double get initialZoom => _initialZoom;
  set initialZoom(double value) {
    _initialZoom = value;
    notifyListeners();
  }

  // Method to initialize the model
  void initialize() {
    // Initialize any necessary state or configuration here
  }

  // Method to dispose resources
  @override
  void dispose() {
    // Dispose of any resources here
    super.dispose();
  }
}