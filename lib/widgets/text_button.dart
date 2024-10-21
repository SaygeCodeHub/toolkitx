import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_color.dart';

class CustomTextButton extends StatelessWidget {
  final Function()? onPressed;
  final String textValue;
  final Color textColor;

  const CustomTextButton(
      {super.key,
      required this.onPressed,
      required this.textValue,
      this.textColor = AppColor.deepBlue});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Text(
          textValue,
          style: TextStyle(color: textColor),
        ));
  }
}
