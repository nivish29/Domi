import 'package:domi_assignment/feature/map_screen/data/datasource/map_remote_data_source.dart';
import 'package:domi_assignment/feature/map_screen/domain/repository/map_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapRepositoryImpl implements MapRepository {
  final MapRemoteDataSource remoteDataSource;

  MapRepositoryImpl(this.remoteDataSource);

  @override
  Future<String> getNearestPlace(LatLng center) async {
    return await remoteDataSource.getNearestPlace(center);
  }

  @override
  Future<String> fetchBuildingOutline(LatLng latLng) async {
    return await remoteDataSource.fetchBuildingOutline(
        latLng.latitude, latLng.longitude);
  }
}
