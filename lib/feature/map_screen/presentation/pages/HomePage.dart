import 'package:domi_assignment/feature/bottomsheet/presentation/bottomsheet.dart';
import 'package:domi_assignment/feature/map_screen/presentation/bloc/map_bloc.dart';
import 'package:domi_assignment/feature/map_screen/presentation/widget/top_bar.dart';
import 'package:domi_assignment/theme/app_pallete.dart';
import 'package:domi_assignment/theme/theme.dart';
import 'package:domi_assignment/widget/invite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:domi_assignment/feature/app_apearance/presentation/bloc/app_appearance_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? mapStyle;

  @override
  void initState() {
    super.initState();
    context.read<MapBloc>().add(RequestLocationPermission());
    BlocProvider.of<MapBloc>(context).add(LoadMap());
    loadMapStyle();
  }

  Future<void> loadMapStyle() async {
    final style = await DefaultAssetBundle.of(context)
        .loadString('assets/map/map_style_dark.json');
    if (mounted) {
      setState(() {
        mapStyle = style;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.mapLoadingScreenColor,
      body: Stack(
        children: [
          BlocConsumer<MapBloc, MapState>(
            listener: (BuildContext context, MapState state) {
              if (state is MapLoaded && state.polygons.isNotEmpty) {
                showInviteDialog(context);
              }
            },
            builder: (context, state) {
              if (state is MapLoaded) {
                return BlocBuilder<AppAppearanceBloc, AppAppearanceState>(
                  builder: (context, appState) {
                    bool isLight = appState is AppAppearanceUpdated &&
                        appState.selectedTheme == 'Light';
                    MapType mapType =
                        isLight ? MapType.terrain : MapType.normal;

                    return GoogleMap(
                      initialCameraPosition: state.initialCameraPosition,
                      onMapCreated: (GoogleMapController controller) {
                        if (!isLight) {
                          controller.setMapStyle(mapStyle);
                        }
                        context.read<MapBloc>().add(MapCreated(controller));
                      },
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: false,
                      markers: state.markers,
                      polygons: state.polygons,
                      mapType: mapType,
                      onTap: (LatLng latLng) async {
                        context
                            .read<MapBloc>()
                            .add(BuildingOutlineRequested(latLng));
                        bottomSheetController.animateTo(
                          0.0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                    );
                  },
                );
              }
              return Container();
            },
          ),
          Positioned(
            top: 50,
            left: 10,
            right: 10,
            child: TopBar(),
          ),
          buildDraggableBottomSheet(context),
          BlocBuilder<MapBloc, MapState>(
            builder: (context, state) {
              if (state is MapLoaded && state.isLoading) {
                return Container(
                  decoration:
                      BoxDecoration(color: AppPallete.blackColor.withOpacity(0.4)),
                  child: Center(
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        color: AppThemes.darkTheme.scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: SpinKitFadingCircle(
                        size: 40,
                        color: AppPallete.whiteColor,
                      ),
                    ),
                  ),
                );
              }
              return SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
