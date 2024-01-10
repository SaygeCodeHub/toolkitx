import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/database_utils.dart';


class ViewMyRequestPopUp extends StatelessWidget {
  const ViewMyRequestPopUp({
    super.key,
  });

  PopupMenuItem _buildPopupMenuItem(context, String title, String position) {
    return PopupMenuItem(
        value: position,
        child: Text(title, style: Theme.of(context).textTheme.xSmall));
  }

  @override
  Widget build(BuildContext context) {
    List popUpMenuItems = [
      DatabaseUtil.getText('approve'),
      DatabaseUtil.getText('Reject'),
      DatabaseUtil.getText('Cancel')
    ];
    return PopupMenuButton(
        onSelected: (value) {
          if (value == DatabaseUtil.getText("Cancel")) {}
        },
        position: PopupMenuPosition.under,
        itemBuilder: (BuildContext context) => [
          for (int i = 0; i < popUpMenuItems.length; i++)
            _buildPopupMenuItem(
                context, popUpMenuItems[i], popUpMenuItems[i])
        ]);
  }
}
