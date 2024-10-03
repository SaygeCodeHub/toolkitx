import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/imagePickerBloc/image_picker_bloc.dart';
import '../../../blocs/incident/incidentDetails/incident_details_bloc.dart';
import '../../../blocs/incident/incidentDetails/incident_details_event.dart';
import '../../../blocs/incident/incidentDetails/incident_details_states.dart';
import '../../../blocs/incident/incidentListAndFilter/incident_list_and_filter_bloc.dart';
import '../../../blocs/uploadImage/upload_image_bloc.dart';
import '../../../blocs/uploadImage/upload_image_event.dart';
import '../../../blocs/uploadImage/upload_image_state.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/generic_loading_popup.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/progress_bar.dart';

class IncidentAddCommentsBottomNavbar extends StatelessWidget {
  const IncidentAddCommentsBottomNavbar(
      {super.key,
      required this.incidentCommentsMap,
      required this.incidentId,
      required this.isFromAddComment});

  final Map incidentCommentsMap;
  final String incidentId;
  final bool isFromAddComment;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
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
            },
          ),
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
                    if (isFromAddComment &&
                            incidentCommentsMap['comments'] == null ||
                        incidentCommentsMap['comments'].isEmpty) {
                      showCustomSnackBar(
                          context, DatabaseUtil.getText('CommentsInsert'), '');
                    } else {
                      context.read<IncidentDetailsBloc>().add(
                          SaveIncidentComments(
                              saveCommentsMap: incidentCommentsMap));
                    }
                  }
                },
                textValue: StringConstants.kSave)));
  }
}
