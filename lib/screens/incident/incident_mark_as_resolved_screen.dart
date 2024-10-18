import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/data/enums/incident_and_qm_filter_status_enum.dart';
import '../../blocs/imagePickerBloc/image_picker_bloc.dart';
import '../../blocs/incident/incidentDetails/incident_details_bloc.dart';
import '../../blocs/incident/incidentDetails/incident_details_event.dart';
import '../../blocs/incident/incidentDetails/incident_details_states.dart';
import '../../blocs/incident/incidentListAndFilter/incident_list_and_filter_bloc.dart';
import '../../blocs/uploadImage/upload_image_bloc.dart';
import '../../blocs/uploadImage/upload_image_event.dart';
import '../../blocs/uploadImage/upload_image_state.dart';
import '../../configs/app_spacing.dart';
import '../../data/models/incident/incident_details_model.dart';
import '../../utils/constants/string_constants.dart';
import '../../utils/incident/incident_popup_menu_status.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/generic_loading_popup.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/progress_bar.dart';
import 'widgets/incident_common_comments_section.dart';

class IncidentMarkAsResolvedScreen extends StatelessWidget {
  final String incidentId;
  final IncidentDetailsModel incidentDetailsModel;

  IncidentMarkAsResolvedScreen(
      {Key? key, required this.incidentId, required this.incidentDetailsModel})
      : super(key: key);
  final Map incidentCommentsMap = {};

  @override
  Widget build(BuildContext context) {
    incidentCommentsMap['incidentId'] = incidentId;
    incidentCommentsMap['status'] =
        IncidentAndQualityManagementStatusEnum.resolved.value;
    return Scaffold(
      appBar: const GenericAppBar(title: StringConstants.kResolve),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(children: [
            IncidentPopUpMenuStatusWidgets().renderMarkAsResolvedControl(
                incidentDetailsModel, context, incidentCommentsMap),
            IncidentCommonCommentsSection(
                onPhotosUploaded: (List uploadList) {
                  incidentCommentsMap['file_name'] = uploadList
                      .toString()
                      .replaceAll("[", '')
                      .replaceAll(']', '');
                },
                onTextFieldValue: (String textValue) {
                  incidentCommentsMap['comments'] = textValue;
                },
                incidentCommentsMap: incidentCommentsMap,
                incidentDetailsModel: incidentDetailsModel,
                showStatusControl: false,
                showClassification: false),
          ]),
        ),
      ),
      bottomNavigationBar: MultiBlocListener(
        listeners: [
          BlocListener<IncidentDetailsBloc, IncidentDetailsStates>(
            listener: (context, state) {
              if (state is SavingIncidentComments) {
                ProgressBar.show(context);
              } else if (state is IncidentCommentsSaved ||
                  state is IncidentCommentsFilesSaved) {
                ProgressBar.dismiss(context);
                Navigator.pop(context);
                context.read<IncidentDetailsBloc>().add(
                    FetchIncidentDetailsEvent(
                        initialIndex: 0,
                        incidentId: incidentId,
                        role: context.read<IncidentLisAndFilterBloc>().roleId));
              } else if (state is IncidentCommentsNotSaved) {
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
              incidentCommentsMap['ImageString'] = state.images
                  .toString()
                  .replaceAll('[', '')
                  .replaceAll(']', '')
                  .replaceAll(' ', '');
              if (incidentCommentsMap['comments'] != null ||
                  incidentCommentsMap['comments'] != '') {
                context.read<IncidentDetailsBloc>().add(SaveIncidentComments(
                    saveCommentsMap: incidentCommentsMap,
                    isFromAddComment: false));
              }
            } else if (state is ImageCouldNotUpload) {
              GenericLoadingPopUp.dismiss(context);
              showCustomSnackBar(context, state.errorMessage, '');
            }
          })
        ],
        child: Padding(
          padding: const EdgeInsets.all(xxTinierSpacing),
          child: PrimaryButton(
              onPressed: () {
                if (incidentCommentsMap['file_name'] != null &&
                    incidentCommentsMap['file_name'].isNotEmpty) {
                  context.read<UploadImageBloc>().add(UploadImage(
                      images: incidentCommentsMap['file_name'],
                      imageLength:
                          context.read<ImagePickerBloc>().lengthOfImageList));
                } else {
                  context.read<IncidentDetailsBloc>().add(SaveIncidentComments(
                      saveCommentsMap: incidentCommentsMap,
                      isFromAddComment: false));
                }
              },
              textValue: StringConstants.kSave),
        ),
      ),
    );
  }
}
