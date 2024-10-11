import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:domi_assignment/endpoints/endpoints.dart';
import 'package:domi_assignment/feature/app_apearance/presentation/bloc/app_appearance_bloc.dart';
import 'package:domi_assignment/feature/map_screen/domain/usecase/get_building_outline.dart';
import 'package:domi_assignment/feature/map_screen/domain/usecase/get_nearest_place.dart';
import 'package:domi_assignment/feature/map_screen/domain/usecase/process_osm_data.dart';
import 'package:domi_assignment/theme/app_pallete.dart';
import 'package:domi_assignment/widget/marker.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  GoogleMapController? _controller;
  final AppAppearanceBloc appAppearanceBloc;
  final GetNearestPlace getNearestPlace;
  final GetBuildingOutline getBuildingOutline;
  final ProcessOsmData processOsmData;

  MapBloc(
      {required this.appAppearanceBloc,
      required this.getNearestPlace,
      required this.getBuildingOutline,
      required this.processOsmData})
      : super(MapInitial()) {
    on<LoadMap>(_onLoadMap);

    on<BuildingOutlineRequested>(_onFetchBuildingOutline);
    on<MapCreated>(_onMapCreated);
    on<CurrentLocationRequested>(_onCurrentLocationRequested);
    on<EmptyMarkerData>(_onEmptyMarkerData);
    on<RequestLocationPermission>(_onRequestLocationPermission);

  }

    Future<void> _onRequestLocationPermission(
    RequestLocationPermission event,
    Emitter<MapState> emit,
  ) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        emit(MapError('Location permissions are denied'));
        return;
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      emit(MapError('Location permissions are permanently denied, we cannot request permissions.'));
      return;
    } 
    add(LoadMap());
  }

  Future<void> _onEmptyMarkerData(
      EmptyMarkerData event, Emitter<MapState> emit) async {
    if (state is MapLoaded) {
      final currentState = state as MapLoaded;

      emit(MapLoaded(
        initialCameraPosition: currentState.initialCameraPosition,
        currentLocation: currentState.currentLocation,
        markers: currentState.markers,
        polygons: {},
      ));
    }
  }

  Future<void> _onMapCreated(MapCreated event, Emitter<MapState> emit) async {
    _controller = event.controller;
  }

  Future<void> _onCurrentLocationRequested(
      CurrentLocationRequested event, Emitter<MapState> emit) async {
    if (state is MapLoaded) {
      final currentState = state as MapLoaded;
      _controller?.animateCamera(
          CameraUpdate.newLatLng(currentState.markers.first.position));
    }
  }

  Future<void> _onLoadMap(LoadMap event, Emitter<MapState> emit) async {
    emit(MapLoading());

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      final LatLng currentLocation =
          LatLng(position.latitude, position.longitude);

      BitmapDescriptor customIcon =
          await MapMarkers.createCustomMarkerBitmap('assets/images/image2.jpg');
      Marker currentMarker = Marker(
        markerId: const MarkerId('currentLocation'),
        position: currentLocation,
        icon: customIcon,
      );
      final String nearestPlace = await getNearestPlace(currentLocation);

      emit(MapLoaded(
        initialCameraPosition:
            CameraPosition(target: currentLocation, zoom: 18),
        currentLocation: nearestPlace,
        markers: {currentMarker},
        polygons: {},
      ));
    } catch (e) {
      emit(MapError('Failed to load map'));
    }
  }

  Future<void> _onUpdateCurrentLocation(
      UpdateCurrentLocation event, Emitter<MapState> emit) async {
    if (state is MapLoaded) {
      final currentState = state as MapLoaded;

      final updatedMarker = Marker(
        markerId: const MarkerId('currentLocation'),
        position: event.currentLocation,
        icon: await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(),
          'assets/images/image2.jpg',
        ),
      );

      emit(MapLoaded(
        initialCameraPosition: currentState.initialCameraPosition,
        currentLocation: '',
        markers: {updatedMarker},
        polygons: currentState.polygons,
      ));

      _controller?.animateCamera(CameraUpdate.newLatLng(event.currentLocation));
    }
  }

  Future<void> _onMapTapped(MapTapped event, Emitter<MapState> emit) async {
    if (state is MapLoaded) {
      final currentState = state as MapLoaded;

      Marker tappedMarker = Marker(
        markerId: MarkerId(event.tappedPoint.toString()),
        position: event.tappedPoint,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      );

      emit(MapLoaded(
        initialCameraPosition: currentState.initialCameraPosition,
        currentLocation: currentState.currentLocation,
        markers: {...currentState.markers, tappedMarker},
        polygons: currentState.polygons,
      ));
    }
  }

  Future<void> _onFetchBuildingOutline(
      BuildingOutlineRequested event, Emitter<MapState> emit) async {
    if (state is MapLoaded) {
      emit((state as MapLoaded).copyWith(isLoading: true));
      final currentState = state as MapLoaded;
      Color highlightColor = AppPallete.defaultHighlightColor;
      final appState = appAppearanceBloc.state;
      if (appState is AppAppearanceUpdated) {
        highlightColor = appState.selectedColor;
      }
      final query = MapApiEndpoints.getBuildingOutlineEndpoint(
          event.latLng.latitude, event.latLng.longitude);

      final url = Uri.parse(MapApiEndpoints.getBuildingOutlineUrl())
          .replace(queryParameters: {'data': query});

      try {
        final outlineData = await getBuildingOutline(event.latLng);

        final data = json.decode(outlineData);
        Set<Polygon> polygons = processOsmData(data, highlightColor);
        emit((state as MapLoaded).copyWith(isLoading: true));

        emit(MapLoaded(
          initialCameraPosition: currentState.initialCameraPosition,
          currentLocation: currentState.currentLocation,
          markers: currentState.markers,
          polygons: polygons,
        ));
      } catch (e) {
        emit(MapError('Error fetching building data'));
      }
    }
  }
}
