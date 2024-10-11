import 'package:domi_assignment/feature/map_screen/domain/repository/map_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetBuildingOutline {
  final MapRepository repository;

  GetBuildingOutline(this.repository);

  Future<String> call(LatLng latLng) async {
    return await repository.fetchBuildingOutline(latLng);
  }
}
