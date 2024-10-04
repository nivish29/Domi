import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatelessWidget {
  final Completer<GoogleMapController> controller_map;
  final CameraPosition initialCameraPosition;
  final Marker currentLocationMarker;
  final Set<Polygon> polygons;

  MapWidget({
    required this.controller_map,
    required this.initialCameraPosition,
    required this.currentLocationMarker,
    required this.polygons,
  });

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: initialCameraPosition,
      onMapCreated: (GoogleMapController controller) {
        controller_map.complete(controller);
      },
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      markers: {currentLocationMarker},
      polygons: polygons,
      liteModeEnabled: true,
    );
  }
}
