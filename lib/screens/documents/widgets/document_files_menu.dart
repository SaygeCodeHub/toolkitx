import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../blocs/documents/documents_bloc.dart';
import '../../../blocs/documents/documents_events.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/documents/documents_details_models.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/android_pop_up.dart';

class DocumentsFilesMenu extends StatelessWidget {
  final FileList fileData;
  final List popUpMenuItems;

  const DocumentsFilesMenu(
      {Key? key, required this.popUpMenuItems, required this.fileData})
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
          if (popUpMenuItems[value] ==
              DatabaseUtil.getText('dms_uploadnewversion')) {
          } else if (popUpMenuItems[value] == DatabaseUtil.getText('Delete')) {
            showDialog(
                context: context,
                builder: (context) {
                  return AndroidPopUp(
                      titleValue: 'File Management',
                      contentValue:
                          'Are you sure you want to delete this file?',
                      onPrimaryButton: () {
                        Navigator.pop(context);
                        context
                            .read<DocumentsBloc>()
                            .add(DeleteDocuments(fileId: fileData.fileid));
                      });
                });
          } else if (popUpMenuItems[value] ==
              DatabaseUtil.getText('AddComments')) {}
        },
        position: PopupMenuPosition.under,
        itemBuilder: (BuildContext context) => [
          for (int i = 0; i < popUpMenuItems.length; i++)
            _buildPopupMenuItem(context, popUpMenuItems[i], i)
        ]);
  }
}
