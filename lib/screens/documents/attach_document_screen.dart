import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../blocs/documents/documents_bloc.dart';
import '../../blocs/documents/documents_events.dart';
import '../../blocs/documents/documents_states.dart';
import '../../blocs/pickAndUploadImage/pick_and_upload_image_bloc.dart';
import '../../blocs/pickAndUploadImage/pick_and_upload_image_events.dart';
import '../../configs/app_spacing.dart';
import '../../data/models/documents/documents_details_models.dart';
import '../../utils/database_utils.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/generic_text_field.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/progress_bar.dart';
import '../checklist/workforce/widgets/upload_image_section.dart';

class AttachDocumentScreen extends StatelessWidget {
  static const routeName = 'AttachDocumentScreen';
  static Map attachDocumentMap = {};
  final DocumentDetailsModel documentDetailsModel;

  const AttachDocumentScreen({super.key, required this.documentDetailsModel});

  @override
  Widget build(BuildContext context) {
    attachDocumentMap = {};
    context.read<PickAndUploadImageBloc>().isInitialUpload = true;
    context.read<PickAndUploadImageBloc>().add(UploadInitial());
    return Scaffold(
        appBar: const GenericAppBar(title: 'Attach Document'),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
                padding: const EdgeInsets.only(
                    left: leftRightMargin,
                    right: leftRightMargin,
                    top: topBottomPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    Text(DatabaseUtil.getText('Author'),
                        style: Theme.of(context)
                            .textTheme
                            .xSmall
                            .copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: tiniestSpacing),
                    TextFieldWidget(
                        readOnly: true,
                        value: documentDetailsModel.data.author,
                        onTextFieldChanged: (textField) {},
                        hintText: DatabaseUtil.getText('Author')),
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
                          attachDocumentMap['notes'] = textField;
                        },
                        hintText: DatabaseUtil.getText('dms_versionnotes')),
                    const SizedBox(height: xxTinySpacing),
                    UploadImageMenu(
                        isUpload: false,
                        onUploadImageResponse: (List uploadImageList) {
                          attachDocumentMap['files'] = uploadImageList
                              .toString()
                              .replaceAll('[', '')
                              .replaceAll(']', '');
                        }),
                    const SizedBox(height: xxTinySpacing),
                    BlocListener<DocumentsBloc, DocumentsStates>(
                        listener: (context, state) {
                          if (state is AttachingDocuments) {
                            ProgressBar.show(context);
                          }
                          if (state is DocumentsAttached) {
                            ProgressBar.dismiss(context);
                            Navigator.pop(context);
                          }
                          if (state is AttachDocumentsError) {
                            ProgressBar.dismiss(context);
                            showCustomSnackBar(context, state.message, '');
                          }
                        },
                        child: PrimaryButton(
                            onPressed: () {
                              context.read<DocumentsBloc>().add(AttachDocuments(
                                  attachDocumentsMap: attachDocumentMap));
                            },
                            textValue: DatabaseUtil.getText('Submit')))
                  ],
                ))));
  }
}
