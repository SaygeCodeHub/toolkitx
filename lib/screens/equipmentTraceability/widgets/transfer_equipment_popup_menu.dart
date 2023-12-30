import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

class TransferEquipmentPopupMenu extends StatelessWidget {
  const TransferEquipmentPopupMenu({super.key});

  PopupMenuItem _buildPopupMenuItem(context, String title, String position) {
    return PopupMenuItem(
        value: position,
        child: Text(title, style: Theme.of(context).textTheme.xSmall));
  }

  @override
  Widget build(BuildContext context) {
    List popUpMenuItems = [
      "Scan",
      "Enter",
      "Search",
      "Cancel"
    ];
    return PopupMenuButton(
        onSelected: (value) {
          // if (value == StringConstants.kManageDownTime) {
          //   Navigator.pushNamed(context, AssetsManageDownTimeScreen.routeName);
          // }

        },
        position: PopupMenuPosition.under,
        itemBuilder: (BuildContext context) => [
          for (int i = 0; i < popUpMenuItems.length; i++)
            _buildPopupMenuItem(
                context, popUpMenuItems[i], popUpMenuItems[i])
        ]);
  }
}
