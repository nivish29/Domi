import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:domi_assignment/main.dart';
import 'package:domi_assignment/widget/invite.dart';
import 'package:domi_assignment/widget/marker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class MapProvider extends ChangeNotifier {
  final Completer<GoogleMapController> controller_map =
      Completer<GoogleMapController>();
  CameraPosition? initialCameraPosition_map;
  Marker? currentLocationMarker_map;
  Position? _currentPosition;
  Set<Polygon> polygons_map = {};
  LatLng? _lastTappedPoint;
  String curr = "";
  bool _mapReady = false;
  final String apiKey = 'AIzaSyBdpHK36b_FWVj9KIDXfkJx3RUzGnbCcOU';
  LatLng? _cachedPosition;
  double? _cachedZoom;

  CameraPosition? get initialCameraPosition => initialCameraPosition_map;
  Marker? get currentLocationMarker => currentLocationMarker_map;
  Set<Polygon> get polygons => polygons_map;
  LatLng? get lastTappedPoint => _lastTappedPoint;
  bool get mapReady => _mapReady;

  MapProvider() {
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await _showLocationServiceDialog();
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        await _showPermissionDeniedDialog();
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      await _showPermissionPermanentlyDeniedDialog();
      return;
    }

    _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    initialCameraPosition_map = CameraPosition(
      target: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
      zoom: 18.0,
    );

    BitmapDescriptor customIcon =
        await MapMarkers.createCustomMarkerBitmap('assets/images/image2.jpg');

    currentLocationMarker_map = Marker(
      markerId: const MarkerId('currentLocation'),
      position: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
      infoWindow: const InfoWindow(title: 'Current Location'),
      icon: customIcon,
    );

    _detail(LatLng(_currentPosition!.latitude, _currentPosition!.longitude));
    _mapReady = true;
    notifyListeners();
  }

  Future<void> _showPermissionDeniedDialog() async {
    await showDialog(
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Location Permission Required'),
          content: Text(
              'You need to give location permission to move forward. Would you like to grant permission?'),
          actions: [
            TextButton(
              child: Text('No'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop();
                _getCurrentLocation();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showPermissionPermanentlyDeniedDialog() async {
    await showDialog(
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Location Permission Permanently Denied'),
          content: Text(
              'Location permission is permanently denied. Please enable it in your device settings.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Geolocator.openAppSettings();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showLocationServiceDialog() async {
    await showDialog(
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Location Services Disabled'),
          content: Text('Please enable location services to use this feature.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Geolocator.openLocationSettings();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> goToCurrentLocation() async {
    final GoogleMapController controller = await controller_map.future;
    if (_currentPosition != null) {
      CameraPosition cameraPosition = CameraPosition(
        target: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
        zoom: 18.0,
      );
      await controller
          .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    }
  }

  void onMapTapped(LatLng tappedPoint, BuildContext context) async {
    _lastTappedPoint = tappedPoint;
    showInviteDialog(context);
    notifyListeners();
  }

  Future<void> _detail(LatLng center) async {
    final url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?'
        'location=${center.latitude},${center.longitude}'
        '&radius=20'
        '&type=establishment'
        '&key=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      int len = data['results'].length;
      curr = data['results'][len - 1]['name'];
      log(curr);
      notifyListeners();
    } else {
      log('Error fetching nearby places: ${response.statusCode}');
    }
  }

  void completeMapController(GoogleMapController controller) {
    controller_map.complete(controller);
  }
}
