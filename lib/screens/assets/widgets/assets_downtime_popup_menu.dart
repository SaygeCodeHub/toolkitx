import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/assets_get_downtime_model.dart';
import 'package:toolkit/utils/database_utils.dart';

class AssetsDowntimePopUpMenu extends StatelessWidget {
  const AssetsDowntimePopUpMenu(
      {super.key,
      required this.popUpMenuItems,
      required this.fetchAssetsDowntimeModel});

  final List popUpMenuItems;
  final FetchAssetsDowntimeModel fetchAssetsDowntimeModel;

  PopupMenuItem _buildPopupMenuItem(context, String title, String position) {
    return PopupMenuItem(
        value: position,
        child: Text(title, style: Theme.of(context).textTheme.xSmall));
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        onSelected: (value) {
          if (value == DatabaseUtil.getText("Edit")) {}
          if (value == DatabaseUtil.getText("Delete")) {}
        },
        position: PopupMenuPosition.under,
        itemBuilder: (BuildContext context) => [
              for (int i = 0; i < popUpMenuItems.length; i++)
                _buildPopupMenuItem(
                    context, popUpMenuItems[i], popUpMenuItems[i])
            ]);
  }
}
