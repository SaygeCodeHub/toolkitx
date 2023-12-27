import 'package:flutter/material.dart';

class NoRecordsText extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const NoRecordsText({super.key, required this.text, this.style});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(child: Text(text, style: style)),
    );
  }
}
