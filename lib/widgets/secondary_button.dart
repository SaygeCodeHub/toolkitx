import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton(
      {Key? key, required this.onPressed, required this.textValue})
      : super(key: key);
  final void Function()? onPressed;
  final String textValue;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: onPressed,
        child: Text(textValue, textAlign: TextAlign.center));
  }
}
