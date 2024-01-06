import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_color.dart';

class CustomTextButton extends StatelessWidget {
  final Function()? onPressed;
  final String textValue;
  final Color textColor;

  const CustomTextButton(
      {Key? key,
      required this.onPressed,
      required this.textValue,
      this.textColor = AppColor.deepBlue})
      : super(key: key);

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
