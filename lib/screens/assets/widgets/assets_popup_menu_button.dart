import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/assets/assets_details_model.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../assets_manage_comments_screen.dart';
import '../assets_manage_document_screeen.dart';
import '../assets_manage_downtime_screen.dart';

class AssetsPopUpMenuButton extends StatelessWidget {
  const AssetsPopUpMenuButton(
      {super.key,
      required this.popUpMenuItems,
      required this.assetsDetailsModel});

  final List popUpMenuItems;
  final FetchAssetsDetailsModel assetsDetailsModel;

  PopupMenuItem _buildPopupMenuItem(context, String title, String position) {
    return PopupMenuItem(
        value: position,
        child: Text(title, style: Theme.of(context).textTheme.xSmall));
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        onSelected: (value) {
          if (value == StringConstants.kManageDownTime) {
            Navigator.pushNamed(context, AssetsManageDownTimeScreen.routeName);
          }
          if (value == StringConstants.kManageDocuments) {
            Navigator.pushNamed(context, AssetsManageDocumentScreen.routeName);
          }
          if(value == StringConstants.kManageComment){
            Navigator.pushNamed(context, AssetsManageCommentsScreen.routeName);
          }
        },
        position: PopupMenuPosition.under,
        itemBuilder: (BuildContext context) => [
              for (int i = 0; i < popUpMenuItems.length; i++)
                _buildPopupMenuItem(
                    context, popUpMenuItems[i], popUpMenuItems[i])
            ]);
  }
}
