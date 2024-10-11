import 'dart:ui';

import 'package:domi_assignment/feature/map_screen/presentation/bloc/map_bloc.dart';
import 'package:domi_assignment/theme/app_pallete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Widget buildLocationInfo(MapState state) {
  return LayoutBuilder(
    builder: (context, constraints) {
      return Container(
        padding: const EdgeInsets.only(left: 8, right: 16, top: 8, bottom: 8),
        decoration: BoxDecoration(
          color: AppPallete.blackColor,
          borderRadius: BorderRadius.circular(40),
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.5,
        ),
        child: state is MapLoading
            ? const SpinKitThreeBounce(
                color: AppPallete.whiteColor,
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
                        state is MapLoaded && state.currentLocation.isNotEmpty
                            ? state.currentLocation
                            : 'Location not available',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppPallete.whiteColor,
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
