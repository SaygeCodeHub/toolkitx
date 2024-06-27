import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_theme.dart';

class ChatDetailsPopUpMenu extends StatelessWidget {
  const ChatDetailsPopUpMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        offset: const Offset(0, 40),
        shape: ShapeBorder.lerp(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kCardRadius)),
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kCardRadius)),
            1),
        itemBuilder: (context) {
          return [
            PopupMenuItem(
                value: '1',
                child: Text('Clear Chat',
                    style: Theme.of(context).textTheme.xxSmall),
                onTap: () {}),
            PopupMenuItem(
                value: '2',
                child: Text('Delete Chat',
                    style: Theme.of(context).textTheme.xxSmall),
                onTap: () {})
          ];
        });
  }
}
