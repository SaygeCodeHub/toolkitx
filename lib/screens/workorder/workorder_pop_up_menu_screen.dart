import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import '../../utils/database_utils.dart';
import 'create_similar_work_order_screen_one.dart';

class WorkOrderPopUpMenuScreen extends StatelessWidget {
  final List popUpMenuOptions;
  final Map workOrderDetailsMap;

  const WorkOrderPopUpMenuScreen(
      {Key? key,
      required this.popUpMenuOptions,
      required this.workOrderDetailsMap})
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
          if (value == DatabaseUtil.getText('CreateSimillar')) {
            Navigator.pushNamed(context, CreateSimilarWorkOrderScreen.routeName,
                arguments: workOrderDetailsMap);
          }
        },
        position: PopupMenuPosition.under,
        itemBuilder: (BuildContext context) => [
              for (int i = 0; i < popUpMenuOptions.length; i++)
                _buildPopupMenuItem(
                    context, popUpMenuOptions[i], popUpMenuOptions[i])
            ]);
  }
}