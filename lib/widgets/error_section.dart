import 'package:flutter/material.dart';

import '../configs/app_dimensions.dart';

class GenericReloadButton extends StatelessWidget {
  final void Function() onPressed;
  final String textValue;

  const GenericReloadButton(
      {super.key, required this.onPressed, required this.textValue});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
            minimumSize: const WidgetStatePropertyAll(
                Size(kErrorButtonWidth, kErrorButtonHeight))),
        child: Text(textValue));
  }
}
