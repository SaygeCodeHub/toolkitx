import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/assets/fetch_assets_document_model.dart';
import 'package:toolkit/utils/database_utils.dart';

class AssetsManageDocumentPopUp extends StatelessWidget {
  const AssetsManageDocumentPopUp({
    super.key,
    required this.popUpMenuItems,
    required this.fetchAssetsManageDocumentModel,
  });
  final List popUpMenuItems;
  final FetchAssetsManageDocumentModel fetchAssetsManageDocumentModel;

  PopupMenuItem _buildPopupMenuItem(context, String title, String position) {
    return PopupMenuItem(
        value: position,
        child: Text(title, style: Theme.of(context).textTheme.xSmall));
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        onSelected: (value) {
          if (value == DatabaseUtil.getText("Delete")) {}
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
