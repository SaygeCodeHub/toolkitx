import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/assets/fetch_assets_document_model.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/android_pop_up.dart';

import '../../../blocs/assets/assets_bloc.dart';

class AssetsManageDocumentPopUp extends StatelessWidget {
  const AssetsManageDocumentPopUp({
    super.key,
    required this.popUpMenuItems,
    required this.fetchAssetsManageDocumentModel,
    required this.documentId,
  });
  final List popUpMenuItems;
  final FetchAssetsManageDocumentModel fetchAssetsManageDocumentModel;
  final String documentId;

  PopupMenuItem _buildPopupMenuItem(context, String title, String position) {
    return PopupMenuItem(
        value: position,
        child: Text(title, style: Theme.of(context).textTheme.xSmall));
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        onSelected: (value) {
          if (value == DatabaseUtil.getText("Delete")) {
            showDialog(
              context: context,
              builder: (context) => AndroidPopUp(
                titleValue: StringConstants.kDeleteDocument,
                contentValue: DatabaseUtil.getText("DeleteConfirmationImage"),
                onPrimaryButton: () {
                  context
                      .read<AssetsBloc>()
                      .add(DeleteAssetsDocument(documentId: documentId));
                },
              ),
            );
          }
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
