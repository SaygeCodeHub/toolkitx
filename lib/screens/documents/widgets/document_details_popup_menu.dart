import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/documents/documents_bloc.dart';
import 'package:toolkit/blocs/documents/documents_events.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/documents/documents_details_models.dart';
import '../../../utils/database_utils.dart';
import '../attach_document_screen.dart';
import '../documents_approve_and_reject_screen.dart';
import '../link_document_screen.dart';

class DocumentsDetailsPopUpMenu extends StatelessWidget {
  final List popUpMenuItems;
  final DocumentDetailsModel documentDetailsModel;

  const DocumentsDetailsPopUpMenu(
      {Key? key,
      required this.popUpMenuItems,
      required this.documentDetailsModel})
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
          if (popUpMenuItems[value] == DatabaseUtil.getText('Edit')) {
          } else if (popUpMenuItems[value] == DatabaseUtil.getText('Open')) {
          } else if (popUpMenuItems[value] ==
              DatabaseUtil.getText('dms_linkotherdocument')) {
            Navigator.pushNamed(context, LinkDocumentScreen.routeName);
          } else if (popUpMenuItems[value] ==
              DatabaseUtil.getText('AddComments')) {
          } else if (popUpMenuItems[value] ==
              DatabaseUtil.getText('dms_attachdocument')) {
            AttachDocumentScreen.isFromUploadVersion = false;
            Navigator.pushNamed(context, AttachDocumentScreen.routeName,
                    arguments: documentDetailsModel)
                .then((_) => context
                    .read<DocumentsBloc>()
                    .add(const GetDocumentsDetails()));
          } else if (popUpMenuItems[value] ==
              DatabaseUtil.getText('dms_approvedocument')) {
            DocumentsApproveAndRejectScreen.isFromReject = false;
            Navigator.pushNamed(
                context, DocumentsApproveAndRejectScreen.routeName);
          } else if (popUpMenuItems[value] ==
              DatabaseUtil.getText('dms_closedocument')) {
          } else if (popUpMenuItems[value] ==
              DatabaseUtil.getText('dms_rejectdocument')) {
            DocumentsApproveAndRejectScreen.isFromReject = true;
            Navigator.pushNamed(
                context, DocumentsApproveAndRejectScreen.routeName);
          } else if (popUpMenuItems[value] ==
              DatabaseUtil.getText('withdraw')) {
          } else if (popUpMenuItems[value] ==
              DatabaseUtil.getText('dms_openforinformation')) {}
        },
        position: PopupMenuPosition.under,
        itemBuilder: (BuildContext context) => [
              for (int i = 0; i < popUpMenuItems.length; i++)
                _buildPopupMenuItem(context, popUpMenuItems[i], i)
            ]);
  }
}
