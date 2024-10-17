import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final void Function()? onPressed;
  final String textValue;

  const SecondaryButton(
      {super.key, required this.onPressed, required this.textValue});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: onPressed,
        child: Text(textValue, textAlign: TextAlign.center));
  }
}

class SecondaryButtonIcon extends StatelessWidget {
  final void Function()? onPressed;
  final String textValue;
  final Widget icon;
  final IconAlignment iconAlignment;
  final double width;

  const SecondaryButtonIcon(
      {super.key,
      required this.onPressed,
      required this.textValue,
      required this.icon,
      required this.iconAlignment,
      this.width = double.infinity});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
        style: OutlinedButton.styleFrom(minimumSize: Size(width, 45)),
        onPressed: onPressed,
        label: Text(textValue, textAlign: TextAlign.center),
        icon: icon,
        iconAlignment: iconAlignment);
  }
}
