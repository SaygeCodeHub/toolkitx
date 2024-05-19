import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/screens/documents/widgets/attach_document_body.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/android_pop_up.dart';

import '../../blocs/documents/documents_bloc.dart';
import '../../blocs/documents/documents_events.dart';
import '../../blocs/documents/documents_states.dart';
import '../../blocs/pickAndUploadImage/pick_and_upload_image_bloc.dart';
import '../../blocs/pickAndUploadImage/pick_and_upload_image_events.dart';
import '../../configs/app_spacing.dart';
import '../../data/models/documents/documents_details_models.dart';
import '../../utils/database_utils.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/progress_bar.dart';
import 'widgets/document_files_menu.dart';

class AttachDocumentScreen extends StatelessWidget {
  static const routeName = 'AttachDocumentScreen';
  static Map attachDocumentMap = {};
  static bool isFromUploadVersion = false;
  final DocumentDetailsModel documentDetailsModel;

  const AttachDocumentScreen({super.key, required this.documentDetailsModel});

  @override
  Widget build(BuildContext context) {
    attachDocumentMap = {};
    context.read<PickAndUploadImageBloc>().isInitialUpload = true;
    context.read<PickAndUploadImageBloc>().add(UploadInitial());
    return Scaffold(
        appBar: GenericAppBar(
            title: isFromUploadVersion == true
                ? DatabaseUtil.getText('dms_uploadnewversion')
                : DatabaseUtil.getText('dms_attachdocument')),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
                padding: const EdgeInsets.only(
                    left: leftRightMargin,
                    right: leftRightMargin,
                    top: topBottomPadding),
                child: AttachDocumentBody(
                    documentDetailsModel: documentDetailsModel))),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(xxTinierSpacing),
            child: BlocListener<DocumentsBloc, DocumentsStates>(
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
                    showDialog(
                        context: context,
                        builder: (context) => AndroidPopUp(
                              titleValue: StringConstants.kAlert,
                              contentValue: state.message,
                              isNoVisible: false,
                              textValue: StringConstants.kOk,
                              onPrimaryButton: () {
                                Navigator.pop(context);
                              },
                            ));
                  }
                  if (state is DocumentFileVersionUploading) {
                    ProgressBar.show(context);
                  }
                  if (state is DocumentFileVersionUploaded) {
                    ProgressBar.dismiss(context);
                    Navigator.pop(context);
                  }
                  if (state is DocumentFileVersionNotUploaded) {
                    ProgressBar.dismiss(context);
                    showDialog(
                        context: context,
                        builder: (context) => AndroidPopUp(
                            titleValue: StringConstants.kAlert,
                            contentValue: state.errorMessage,
                            isNoVisible: false,
                            textValue: StringConstants.kOk,
                            onPrimaryButton: () {
                              Navigator.pop(context);
                            }));
                  }
                },
                child: PrimaryButton(
                    onPressed: () {
                      isFromUploadVersion == true
                          ? context.read<DocumentsBloc>().add(
                              UploadDocumentFileVersion(
                                  uploadFileVersionMap:
                                      DocumentsFilesMenu.documentFileMap))
                          : context.read<DocumentsBloc>().add(AttachDocuments(
                              attachDocumentsMap: attachDocumentMap));
                    },
                    textValue: DatabaseUtil.getText('Submit')))));
  }
}
