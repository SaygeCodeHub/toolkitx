import 'package:flutter/material.dart';

import '../configs/app_spacing.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final String textValue;
  final void Function() onPressed;

  const CustomFloatingActionButton(
      {super.key, required this.textValue, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
        label: Row(
          children: [
            const Icon(Icons.add),
            const SizedBox(width: tiniestSpacing),
            Text(textValue)
          ],
        ),
        onPressed: onPressed);
  }
}
