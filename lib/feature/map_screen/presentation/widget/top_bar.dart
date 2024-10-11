import 'package:domi_assignment/feature/app_apearance/presentation/AppAppearance.dart';
import 'package:domi_assignment/feature/map_screen/presentation/bloc/map_bloc.dart';
import 'package:domi_assignment/feature/map_screen/presentation/widget/chat_icon.dart';
import 'package:domi_assignment/feature/map_screen/presentation/widget/location_info.dart';
import 'package:domi_assignment/routes/app_route_constants.dart';
import 'package:domi_assignment/theme/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                context.pushNamed(MyAppRouteConstant.appearanceScreenRoute);
              },
              child: buildIconContainer(Icons.person),
            ),
            GestureDetector(
              onTap: () =>
                  context.read<MapBloc>().add(CurrentLocationRequested()),
              child: buildLocationInfo(state),
            ),
            ChatIcon(),
          ],
        );
      },
    );
  }

  Widget buildIconContainer(IconData icon) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: AppPallete.blackColor,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Icon(icon, color: AppPallete.whiteColor),
    );
  }
}
