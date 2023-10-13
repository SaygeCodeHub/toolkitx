import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/database_utils.dart';

class DocumentsDetailsPopUpMenu extends StatelessWidget {
  final List popUpMenuItems;

  const DocumentsDetailsPopUpMenu({Key? key, required this.popUpMenuItems})
      : super(key: key);

  PopupMenuItem _buildPopupMenuItem(context, String title, int position) {
    return PopupMenuItem(
        value: position,
        child: Text(title, style: Theme.of(context).textTheme.xSmall));
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kCardRadius)),
        iconSize: kIconSize,
        icon: const Icon(Icons.more_vert_outlined),
        offset: const Offset(0, xxTiniestSpacing),
        onSelected: (value) {
          if (popUpMenuItems[value] == DatabaseUtil.getText('AddComments')) {
          } else if (popUpMenuItems[value] ==
              DatabaseUtil.getText('dms_attachdocument')) {
          } else if (popUpMenuItems[value] ==
              DatabaseUtil.getText('dms_approvedocument')) {
          } else if (popUpMenuItems[value] ==
              DatabaseUtil.getText('dms_closedocument')) {
          } else if (popUpMenuItems[value] == DatabaseUtil.getText('Edit')) {
          } else if (popUpMenuItems[value] == DatabaseUtil.getText('Open')) {
          } else if (popUpMenuItems[value] ==
              DatabaseUtil.getText('dms_rejectdocument')) {
          } else if (popUpMenuItems[value] ==
              DatabaseUtil.getText('withdraw')) {}
        },
        position: PopupMenuPosition.under,
        itemBuilder: (BuildContext context) => [
              for (int i = 0; i < popUpMenuItems.length; i++)
                _buildPopupMenuItem(context, popUpMenuItems[i], i)
            ]);
  }
}
