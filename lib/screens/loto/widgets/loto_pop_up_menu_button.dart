import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/loto/loto_details_model.dart';

class LotoPopupMenuButton extends StatelessWidget {
  const LotoPopupMenuButton(
      {super.key,
      required this.popUpMenuItems,
      required this.fetchLotoDetailsModel});
  final List popUpMenuItems;
  final FetchLotoDetailsModel fetchLotoDetailsModel;

  PopupMenuItem _buildPopupMenuItem(context, String title, String position) {
    return PopupMenuItem(
        value: position,
        child: Text(title, style: Theme.of(context).textTheme.xSmall));
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        position: PopupMenuPosition.under,
        itemBuilder: (BuildContext context) => [
              for (int i = 0; i < popUpMenuItems.length; i++)
                _buildPopupMenuItem(
                    context, popUpMenuItems[i], popUpMenuItems[i])
            ]);
  }
}
