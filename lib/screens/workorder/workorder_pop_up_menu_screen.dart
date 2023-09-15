import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';

class WorkOrderPopUpMenuScreen extends StatelessWidget {
  final List popUpMenuOptions;

  const WorkOrderPopUpMenuScreen({Key? key, required this.popUpMenuOptions})
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
        onSelected: (value) {},
        position: PopupMenuPosition.under,
        itemBuilder: (BuildContext context) => [
              for (int i = 0; i < popUpMenuOptions.length; i++)
                _buildPopupMenuItem(
                    context, popUpMenuOptions[i], popUpMenuOptions[i])
            ]);
  }
}
