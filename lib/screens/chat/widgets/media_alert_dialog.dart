import 'package:flutter/material.dart';

class MediaAlertDialog extends StatelessWidget {
  final List<Widget> mediaList;

  const MediaAlertDialog({super.key, required this.mediaList});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(vertical: 345, horizontal: 90),
      content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: mediaList),
    );
  }
}
