import 'package:domi_assignment/feature/map_screen/domain/repository/map_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetNearestPlace {
  final MapRepository repository;

  GetNearestPlace(this.repository);

  Future<String> call(LatLng center) async {
    return await repository.getNearestPlace(center);
  }
}
