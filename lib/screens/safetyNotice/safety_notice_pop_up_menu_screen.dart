import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import '../../utils/database_utils.dart';

class SafetyNoticePopUpMenuScreen extends StatelessWidget {
  static const routeName = 'SafetyNoticePopUpMenuScreen';
  final List popUpMenuOptionsList;

  const SafetyNoticePopUpMenuScreen(
      {Key? key, required this.popUpMenuOptionsList})
      : super(key: key);

  PopupMenuItem _buildPopupMenuItem(context, String title, String position) {
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
      offset: const Offset(0, xxTinierSpacing),
      onSelected: (value) {
        if (value == DatabaseUtil.getText('Edit')) {}
        if (value == DatabaseUtil.getText('Issue')) {}
        if (value == DatabaseUtil.getText('Hold')) {}
        if (value == DatabaseUtil.getText('Cancel')) {}
        if (value == DatabaseUtil.getText('Close')) {}
        if (value == DatabaseUtil.getText('Reissue')) {}
      },
      position: PopupMenuPosition.under,
      itemBuilder: (BuildContext context) => [
        for (int i = 0; i < popUpMenuOptionsList.length; i++)
          _buildPopupMenuItem(
              context, popUpMenuOptionsList[i], popUpMenuOptionsList[i])
      ],
    );
  }
}
