import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

class GroupDetailsPopupMenu extends StatelessWidget {
  const GroupDetailsPopupMenu({super.key});

  PopupMenuItem _buildPopupMenuItem(context, String title, String position) {
    return PopupMenuItem(
        value: position,
        child: Text(title, style: Theme.of(context).textTheme.xSmall));
  }

  @override
  Widget build(BuildContext context) {
    List popUpMenuItems = ['Remove Member', 'Set as Admin', 'Dismiss as Admin'];
    return PopupMenuButton(
        onSelected: (value) {
          if (value == 'Remove Member') {}
        },
        position: PopupMenuPosition.under,
        itemBuilder: (BuildContext context) => [
              for (int i = 0; i < popUpMenuItems.length; i++)
                _buildPopupMenuItem(
                    context, popUpMenuItems[i], popUpMenuItems[i])
            ]);
  }
}
