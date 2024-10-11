import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ProcessOsmData {
  Set<Polygon> call(Map<String, dynamic> data, Color highlightColor) {
    Set<Polygon> polygons = {};

    if (data['elements'] != null && data['elements'].isNotEmpty) {
      for (var element in data['elements']) {
        if (element['type'] == 'way' && element['geometry'] != null) {
          List<LatLng> points = [];
          for (var node in element['geometry']) {
            points.add(LatLng(node['lat'], node['lon']));
          }

          polygons.add(
            Polygon(
              polygonId: PolygonId(element['id'].toString()),
              points: points,
              strokeWidth: 2,
              strokeColor: highlightColor,
              fillColor: highlightColor.withOpacity(0.8),
            ),
          );
        }
      }
    }
    return polygons;
  }
}
