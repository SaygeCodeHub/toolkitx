import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_dimensions.dart';

import '../configs/app_color.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final Function() onPressed;
  final double? size;

  const CustomIconButton(
      {Key? key,
      required this.icon,
      required this.onPressed,
      this.size = kIconSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -15),
      child: IconButton(
          highlightColor: AppColor.transparent,
          constraints: const BoxConstraints(),
          padding: EdgeInsets.zero,
          splashColor: AppColor.transparent,
          icon: Icon(icon, size: size),
          onPressed: onPressed),
    );
  }
}
