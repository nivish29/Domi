import 'package:domi_assignment/theme/app_pallete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
      },
      child: buildIconContainer(CupertinoIcons.chat_bubble_text),
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
