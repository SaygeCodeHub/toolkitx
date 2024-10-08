import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/qualityManagement/qm_bloc.dart';
import 'package:toolkit/blocs/qualityManagement/qm_states.dart';
import '../../blocs/imagePickerBloc/image_picker_bloc.dart';
import '../../blocs/qualityManagement/qm_events.dart';
import '../../blocs/uploadImage/upload_image_bloc.dart';
import '../../blocs/uploadImage/upload_image_event.dart';
import '../../blocs/uploadImage/upload_image_state.dart';
import '../../configs/app_spacing.dart';
import '../../data/models/qualityManagement/fetch_qm_details_model.dart';
import '../../utils/constants/string_constants.dart';
import '../../utils/database_utils.dart';
import '../../utils/qualityManagement/status_widgets.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/generic_loading_popup.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/progress_bar.dart';
import 'widgets/qm_common_comments_section.dart';

class QualityManagementAddCommentsScreen extends StatelessWidget {
  static const routeName = 'QualityManagementAddCommentsScreen';
  final FetchQualityManagementDetailsModel fetchQualityManagementDetailsModel;
  final bool isFromAddComments;

  QualityManagementAddCommentsScreen(
      {super.key,
      required this.fetchQualityManagementDetailsModel,
      required this.isFromAddComments});

  final Map qmCommentsMap = {};
  static int imageIndex = 0;
  final StatusWidgets statusWidgets = StatusWidgets();

  @override
  Widget build(BuildContext context) {
    qmCommentsMap['status'] =
        fetchQualityManagementDetailsModel.data.nextStatus;
    log('next status ${fetchQualityManagementDetailsModel.data.nextStatus}');
    return Scaffold(
      appBar: GenericAppBar(title: DatabaseUtil.getText('Comments')),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              if (isFromAddComments == false)
                statusWidgets.renderWidgets(
                    fetchQualityManagementDetailsModel, context, qmCommentsMap),
              QualityManagementCommonCommentsSection(
                  onPhotosUploaded: (List<dynamic> uploadList) {
                    qmCommentsMap['pickedImage'] = uploadList;
                  },
                  onTextFieldValue: (String textValue) {
                    qmCommentsMap['comments'] = textValue;
                  },
                  qmCommentsMap: qmCommentsMap,
                  fetchQualityManagementDetailsModel:
                      fetchQualityManagementDetailsModel,
                  imageIndex: imageIndex),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MultiBlocListener(
        listeners: [
          BlocListener<QualityManagementBloc, QualityManagementStates>(
            listener: (context, state) {
              if (state is QualityManagementSavingComments) {
                ProgressBar.show(context);
              } else if (state is QualityManagementCommentsSaved) {
                ProgressBar.dismiss(context);
                Navigator.pop(context);
                context.read<QualityManagementBloc>().add(
                    FetchQualityManagementDetails(
                        initialIndex: 0, qmId: state.qmId));
              } else if (state is QualityManagementCommentsNotSaved) {
                ProgressBar.dismiss(context);
                showCustomSnackBar(context, state.commentsNotSaved, '');
              }
            },
          ),
          BlocListener<UploadImageBloc, UploadImageState>(
            listener: (context, state) {
              if (state is UploadingImage) {
                GenericLoadingPopUp.show(context, StringConstants.kUploadFiles);
              } else if (state is ImageUploaded) {
                GenericLoadingPopUp.dismiss(context);
                qmCommentsMap['ImageString'] = state.images
                    .toString()
                    .replaceAll('[', '')
                    .replaceAll(']', '')
                    .replaceAll(' ', '');
                if (qmCommentsMap['comments'] != null ||
                    qmCommentsMap['comments'] != '') {
                  context.read<QualityManagementBloc>().add(
                      SaveQualityManagementComments(
                          saveCommentsMap: qmCommentsMap));
                }
              } else if (state is ImageCouldNotUpload) {
                GenericLoadingPopUp.dismiss(context);
                showCustomSnackBar(context, state.errorMessage, '');
              }
            },
          ),
        ],
        child: Padding(
          padding: const EdgeInsets.all(xxTinierSpacing),
          child: PrimaryButton(
              onPressed: () {
                if (qmCommentsMap['pickedImage'] != null &&
                    qmCommentsMap['pickedImage'].isNotEmpty) {
                  context.read<UploadImageBloc>().add(UploadImage(
                      images: qmCommentsMap['pickedImage'],
                      imageLength:
                          context.read<ImagePickerBloc>().lengthOfImageList));
                } else {
                  if (isFromAddComments) {
                    qmCommentsMap['status'] = '';
                    context.read<QualityManagementBloc>().add(
                        SaveQualityManagementComments(
                            saveCommentsMap: qmCommentsMap));
                  } else {
                    context.read<QualityManagementBloc>().add(
                        SaveQualityManagementComments(
                            saveCommentsMap: qmCommentsMap));
                  }
                }
              },
              textValue: StringConstants.kSave),
        ),
      ),
    );
  }
}
