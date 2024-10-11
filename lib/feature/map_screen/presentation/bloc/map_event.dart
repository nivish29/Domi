part of 'map_bloc.dart';

@immutable
sealed class MapEvent {
  const MapEvent();
  @override
  List<Object?> get props => [];
}

class LoadMap extends MapEvent {}

class LoadCurrLocation extends MapEvent {
  final LatLng location;
  LoadCurrLocation(this.location);
}

class MapCreated extends MapEvent {
  final GoogleMapController controller;

  const MapCreated(this.controller);

  @override
  List<Object?> get props => [controller];
}

class UpdateCurrentLocation extends MapEvent {
  final LatLng currentLocation;

  UpdateCurrentLocation(this.currentLocation);

  @override
  List<Object?> get props => [currentLocation];
}

class MapTapped extends MapEvent {
  final LatLng tappedPoint;

  MapTapped(this.tappedPoint);

  @override
  List<Object?> get props => [tappedPoint];
}

class FetchBuildingOutline extends MapEvent {
  final LatLng latLng;

  FetchBuildingOutline(this.latLng);

  @override
  List<Object?> get props => [latLng];
}

class BuildingOutlineRequested extends MapEvent {
  final LatLng latLng;

  const BuildingOutlineRequested(this.latLng);

  @override
  List<Object?> get props => [latLng];
}

class CurrentLocationRequested extends MapEvent {
  const CurrentLocationRequested();
}

class EmptyMarkerData extends MapEvent{}

class RequestLocationPermission extends MapEvent {}
