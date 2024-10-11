import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:domi_assignment/endpoints/endpoints.dart';

class MapRemoteDataSource {
  Future<String> getNearestPlace(LatLng center) async {
    final String url = MapApiEndpoints.getNearestPlaceEndpoint(
        center.latitude, center.longitude);
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['results'].isNotEmpty) {
          return data['results'].last['name'];
        } else {
          return 'No nearby places';
        }
      } else {
        return 'Error fetching places';
      }
    } catch (e) {
      return 'Error fetching places';
    }
  }

  Future<String> fetchBuildingOutline(double lat, double lng) async {
    final query = MapApiEndpoints.getBuildingOutlineEndpoint(lat, lng);
    final url = Uri.parse(MapApiEndpoints.getBuildingOutlineUrl())
        .replace(queryParameters: {'data': query});

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('Error fetching building data');
      }
    } catch (e) {
      throw Exception('Error fetching building data');
    }
  }
}
