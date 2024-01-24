import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_spacing.dart';
import '../../../data/models/documents/documents_details_models.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/generic_text_field.dart';
import '../../checklist/workforce/widgets/upload_image_section.dart';
import '../attach_document_screen.dart';
import 'document_files_menu.dart';

class AttachDocumentBody extends StatelessWidget {
  const AttachDocumentBody({super.key, required this.documentDetailsModel});

  final DocumentDetailsModel documentDetailsModel;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(DatabaseUtil.getText('DocumentName'),
          style: Theme.of(context)
              .textTheme
              .xSmall
              .copyWith(fontWeight: FontWeight.w600)),
      const SizedBox(height: tiniestSpacing),
      TextFieldWidget(
          readOnly: true,
          value: documentDetailsModel.data.name,
          onTextFieldChanged: (textField) {},
          hintText: DatabaseUtil.getText('DocumentName')),
      const SizedBox(height: xxTinySpacing),
      Text(
          AttachDocumentScreen.isFromUploadVersion == true
              ? DatabaseUtil.getText('dms_filename')
              : DatabaseUtil.getText('Author'),
          style: Theme.of(context)
              .textTheme
              .xSmall
              .copyWith(fontWeight: FontWeight.w600)),
      const SizedBox(height: tiniestSpacing),
      TextFieldWidget(
          readOnly: true,
          value: AttachDocumentScreen.isFromUploadVersion == true
              ? DocumentsFilesMenu.documentFileMap['name']
              : documentDetailsModel.data.author,
          onTextFieldChanged: (textField) {},
          hintText: DatabaseUtil.getText('Author')),
      Visibility(
          visible: AttachDocumentScreen.isFromUploadVersion == true,
          child: Column(children: [
            const SizedBox(height: xxTinySpacing),
            TextFieldWidget(
                readOnly: true,
                value: DocumentsFilesMenu.documentFileMap['version'],
                onTextFieldChanged: (textField) {})
          ])),
      const SizedBox(height: xxTinySpacing),
      const SizedBox(height: xxTinySpacing),
      Text(DatabaseUtil.getText('dms_versionnotes'),
          style: Theme.of(context)
              .textTheme
              .xSmall
              .copyWith(fontWeight: FontWeight.w600)),
      const SizedBox(height: tiniestSpacing),
      TextFieldWidget(
          onTextFieldChanged: (textField) {
            AttachDocumentScreen.attachDocumentMap['notes'] = textField;
            DocumentsFilesMenu.documentFileMap['notes'] = textField;
          },
          hintText: DatabaseUtil.getText('dms_versionnotes')),
      const SizedBox(height: xxTinySpacing),
      UploadImageMenu(
          isUpload: false,
          onUploadImageResponse: (List uploadImageList) {
            AttachDocumentScreen.attachDocumentMap['files'] = uploadImageList
                .toString()
                .replaceAll('[', '')
                .replaceAll(']', '');
            DocumentsFilesMenu.documentFileMap['filename'] = uploadImageList
                .toString()
                .replaceAll('[', '')
                .replaceAll(']', '');
          }),
      const SizedBox(height: xxTinySpacing)
    ]);
  }
}
