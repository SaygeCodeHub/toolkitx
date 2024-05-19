import 'package:flutter/material.dart';

class MediaAlertDialog extends StatelessWidget {
  final List<Widget> mediaList;

  const MediaAlertDialog({super.key, required this.mediaList});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(
          vertical: MediaQuery.sizeOf(context).width / 1.25, horizontal: 90),
      content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: mediaList),
    );
  }
}
