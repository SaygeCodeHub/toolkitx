import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final  Function()? onPressed;
  final String textValue;

  const CustomTextButton(
      {Key? key, required this.onPressed, required this.textValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onPressed, child: Text(textValue));
  }
}
