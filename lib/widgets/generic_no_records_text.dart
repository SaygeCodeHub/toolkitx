import 'package:flutter/material.dart';

class NoRecordsText extends StatelessWidget {
  final String text;

  const NoRecordsText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(child: Text(text)),
    );
  }
}
