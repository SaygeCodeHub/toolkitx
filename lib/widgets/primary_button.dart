import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../configs/app_color.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {Key? key, required this.onPressed, required this.textValue})
      : super(key: key);
  final void Function()? onPressed;
  final String textValue;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(textValue,
          style: Theme.of(context)
              .textTheme
              .medium
              .copyWith(fontWeight: FontWeight.w400, color: AppColor.white),
          textAlign: TextAlign.center),
    );
  }
}
