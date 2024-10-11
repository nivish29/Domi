part of 'map_bloc.dart';

@immutable
sealed class MapState {}

final class MapInitial extends MapState {}

class MapLoading extends MapState {}

class CurrLocationLoaded extends MapState {
  final String curr;
  CurrLocationLoaded({required this.curr});
}

class MapLoaded extends MapState {
  final CameraPosition initialCameraPosition;
  final Set<Marker> markers;
  final Set<Polygon> polygons;
  final String currentLocation;
   bool isLoading;

  MapLoaded({
    required this.initialCameraPosition,
    required this.markers,
    required this.polygons,
    required this.currentLocation,
    this.isLoading = false,
  });

   MapLoaded copyWith({
    CameraPosition? initialCameraPosition,
    Set<Marker>? markers,
    Set<Polygon>? polygons,
    String? currentLocation,
    bool? isLoading,
  }) {
    return MapLoaded(
      initialCameraPosition:
          initialCameraPosition ?? this.initialCameraPosition,
      markers: markers ?? this.markers,
      polygons: polygons ?? this.polygons,
      currentLocation: currentLocation ?? this.currentLocation,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props =>
      [initialCameraPosition, markers, polygons, currentLocation];
}

class MapError extends MapState {
  final String error;

  MapError(this.error);

  @override
  List<Object?> get props => [error];
}

class CreateBuildingLoading extends MapState {}
