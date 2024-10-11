import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class MapRepository {
  Future<String> getNearestPlace(LatLng center);
  Future<String> fetchBuildingOutline(LatLng latLng);
}
