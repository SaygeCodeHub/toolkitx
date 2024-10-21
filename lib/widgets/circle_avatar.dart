import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import '../configs/app_color.dart';

class CircleAvatarWidget extends StatelessWidget {
  final double? radius;
  final String imagePath;
  final String path = 'assets/icons/';
  final Color? backgroundColor;

  const CircleAvatarWidget(
      {super.key,
      this.radius,
      required this.imagePath,
      this.backgroundColor = AppColor.blueGrey});

  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: kElevation,
        borderRadius: BorderRadius.circular(kCircleAvatarRadius),
        child: CircleAvatar(
            backgroundColor: backgroundColor,
            radius: kCircleAvatarRadius,
            child: Image.asset('$path$imagePath',
                height: kCircleAvatarImgHeight, width: kCircleAvatarImgWidth)));
  }
}
