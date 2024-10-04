import 'package:domi_assignment/provider/bottomsheetProvider.dart';
import 'package:domi_assignment/provider/mapProvider.dart';
import 'package:domi_assignment/widget/bottomsheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenStateState();
}

class _HomeScreenStateState extends State<HomeScreen> {
  String? mapStyle;
  @override
  void initState() {
    super.initState();
    loadMapStyle();
  }

  Future<void> loadMapStyle() async {
    final style = await DefaultAssetBundle.of(context)
        .loadString('assets/map/map_style.json');
    if (mounted) {
      setState(() {
        mapStyle = style;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomSheetProvider = Provider.of<BottomSheetProvider>(context);
    final mapProvider = Provider.of<MapProvider>(context);

    return Scaffold(
        backgroundColor: Color(0xff33485E),
        body: Stack(
          children: [
            if (mapProvider.initialCameraPosition != null)
              GoogleMap(
                initialCameraPosition: mapProvider.initialCameraPosition!,
                onMapCreated: (GoogleMapController controller) {
                  controller.setMapStyle(mapStyle);
                  mapProvider.completeMapController(controller);
                  // mapProvider.createBuildingPolygon();
                },
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                markers: mapProvider.currentLocationMarker != null
                    ? {
                        mapProvider.currentLocationMarker!,
                        ...mapProvider.markers
                      }
                    : mapProvider.markers,
                polygons: mapProvider.polygons,
                onTap: (LatLng tappedPoint) async {
                  // mapProvider.addPolygonPoint(tappedPoint);
                  await bottomSheetController.animateTo(
                    0.0,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                  );
                  mapProvider.onMapTapped(tappedPoint, context);
                },
              )
            else
              const Center(child: SizedBox()),
            if (mapProvider.mapReady)
              Positioned.fill(
                child: Container(),
              ),
            Positioned(
              top: 50,
              left: 10,
              right: 10,
              child: buildTopBar(context, mapProvider),
            ),
            if (bottomSheetProvider.isBottomSheetVisible)
              buildDraggableBottomSheet(context),
          ],
        ));
  }

  Widget buildTopBar(BuildContext context, MapProvider mapProvider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildIconContainer(CupertinoIcons.person_crop_circle),
        GestureDetector(
            onTap: mapProvider.goToCurrentLocation,
            child: buildLocationInfo(mapProvider)),
        buildChatIcon(context),
      ],
    );
  }

  Widget buildIconContainer(IconData icon) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Icon(icon, color: Colors.white),
    );
  }

  Widget buildLocationInfo(MapProvider mapProvider) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          padding: const EdgeInsets.only(left: 8, right: 16, top: 8, bottom: 8),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(40),
          ),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.5,
          ),
          child: mapProvider.curr.isEmpty
              ? const SpinKitThreeBounce(
                  color: Colors.white,
                  size: 25,
                )
              : IntrinsicWidth(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          fit: BoxFit.cover,
                          'assets/images/t.jpg',
                          width: 24,
                          height: 24,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Flexible(
                        child: Text(
                          '${mapProvider.curr}',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }

  Widget buildChatIcon(BuildContext context) {
    return GestureDetector(
      onTap: () async {},
      child: buildIconContainer(CupertinoIcons.chat_bubble_text),
    );
  }
}
