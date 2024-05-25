import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/imagePickerBloc/image_picker_bloc.dart';
import '../../blocs/incident/incidentDetails/incident_details_bloc.dart';
import '../../blocs/incident/incidentDetails/incident_details_event.dart';
import '../../blocs/incident/incidentDetails/incident_details_states.dart';
import '../../blocs/incident/incidentListAndFilter/incident_list_and_filter_bloc.dart';
import '../../blocs/pickAndUploadImage/pick_and_upload_image_bloc.dart';
import '../../blocs/pickAndUploadImage/pick_and_upload_image_events.dart';
import '../../blocs/uploadImage/upload_image_bloc.dart';
import '../../blocs/uploadImage/upload_image_event.dart';
import '../../blocs/uploadImage/upload_image_state.dart';
import '../../configs/app_spacing.dart';
import '../../data/models/incident/incident_details_model.dart';
import '../../utils/incident_status_util.dart';
import '../../utils/constants/string_constants.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/generic_loading_popup.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/progress_bar.dart';
import 'widgets/incident_common_comments_section.dart';

class IncidentStatusScreen extends StatelessWidget {
  final String incidentId;
  final IncidentDetailsModel incidentDetailsModel;

  IncidentStatusScreen(
      {Key? key, required this.incidentId, required this.incidentDetailsModel})
      : super(key: key);
  final Map incidentCommentsMap = {};

  @override
  Widget build(BuildContext context) {
    incidentCommentsMap['incidentId'] = incidentId;
    incidentCommentsMap['status'] = incidentDetailsModel.data!.nextStatus;
    context.read<PickAndUploadImageBloc>().add(UploadInitial());
    return Scaffold(
      appBar: GenericAppBar(
          title:
              IncidentStatusUtil().incidentStatusWidget(incidentDetailsModel)),
      body: Padding(
          padding: const EdgeInsets.only(
              left: leftRightMargin,
              right: leftRightMargin,
              top: xxTinierSpacing),
          child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(children: [
                IncidentCommonCommentsSection(
                    incidentDetailsModel: incidentDetailsModel,
                    onPhotosUploaded: (List uploadList) {
                      incidentCommentsMap['file_name'] = uploadList;
                    },
                    onTextFieldValue: (String textValue) {
                      incidentCommentsMap['comments'] = textValue;
                    },
                    incidentCommentsMap: incidentCommentsMap)
              ]))),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(xxTinierSpacing),
        child: MultiBlocListener(
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
                          role:
                              context.read<IncidentLisAndFilterBloc>().roleId));
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
                      saveCommentsMap: incidentCommentsMap));
                }
              } else if (state is ImageCouldNotUpload) {
                GenericLoadingPopUp.dismiss(context);
                showCustomSnackBar(context, state.errorMessage, '');
              }
            })
          ],
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
                      saveCommentsMap: incidentCommentsMap));
                }
              },
              textValue: StringConstants.kSave),
        ),
      ),
    );
  }
}
