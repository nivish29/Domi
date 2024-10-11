import 'package:domi_assignment/feature/bottomsheet/presentation/bloc/bottom_sheet_bloc.dart';
import 'package:domi_assignment/feature/map_screen/presentation/bloc/map_bloc.dart';
import 'package:domi_assignment/theme/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> showInviteDialog(BuildContext context) async {
  context.read<BottomSheetBloc>().add(HideBottomSheet());
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Material(
            borderRadius: BorderRadius.circular(16),
            color: AppPallete.blackColor,
            child: Container(
              padding: const EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width * 0.9,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Invite & Earn',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppPallete.whiteColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.read<MapBloc>().add(EmptyMarkerData());
                          Navigator.of(context).pop();
                        },
                        child: const Icon(Icons.close,
                            color: AppPallete.whiteColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Invite your neighbor and you both receive \$10 when they claim their address.',
                    style: TextStyle(color: AppPallete.greyColor, fontSize: 15),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppPallete.whiteColor,
                      foregroundColor: AppPallete.blackColor,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const SizedBox(
                      width: double.infinity,
                      child: Center(
                        child: Text('Send invite'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  ).then((_) {
    context.read<MapBloc>().add(EmptyMarkerData());
    context.read<BottomSheetBloc>().add(ShowBottomSheet());
  });
}
