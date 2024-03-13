import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/incident/incidentDetails/incident_details_bloc.dart';
import 'package:toolkit/blocs/incident/incidentDetails/incident_details_states.dart';
import 'package:toolkit/blocs/incident/incidentListAndFilter/incident_list_and_filter_bloc.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/progress_bar.dart';

import '../../blocs/imagePickerBloc/image_picker_bloc.dart';
import '../../blocs/incident/incidentDetails/incident_details_event.dart';
import '../../blocs/pickAndUploadImage/pick_and_upload_image_bloc.dart';
import '../../blocs/pickAndUploadImage/pick_and_upload_image_events.dart';
import '../../blocs/uploadImage/upload_image_bloc.dart';
import '../../blocs/uploadImage/upload_image_event.dart';
import '../../blocs/uploadImage/upload_image_state.dart';
import '../../configs/app_spacing.dart';
import '../../data/models/incident/fetch_incidents_list_model.dart';
import '../../data/models/incident/incident_details_model.dart';
import '../../utils/constants/string_constants.dart';
import '../../widgets/generic_loading_popup.dart';
import '../../widgets/primary_button.dart';
import 'widgets/incident_common_comments_section.dart';

class IncidentAddCommentsScreen extends StatelessWidget {
  final IncidentListDatum incidentListDatum;
  final IncidentDetailsModel incidentDetailsModel;

  IncidentAddCommentsScreen(
      {Key? key,
      required this.incidentListDatum,
      required this.incidentDetailsModel})
      : super(key: key);
  final Map incidentCommentsMap = {};

  @override
  Widget build(BuildContext context) {
    context.read<PickAndUploadImageBloc>().add(UploadInitial());
    incidentCommentsMap['incidentId'] = incidentListDatum.id;
    return Scaffold(
      appBar: GenericAppBar(title: DatabaseUtil.getText('Comments')),
      body: Padding(
          padding: const EdgeInsets.only(
              left: leftRightMargin,
              right: leftRightMargin,
              top: xxTinierSpacing),
          child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(children: [
                IncidentCommonCommentsSection(
                  onPhotosUploaded: (List uploadList) {
                    incidentCommentsMap['file_name'] = uploadList;
                  },
                  onTextFieldValue: (String textValue) {
                    incidentCommentsMap['comments'] = textValue;
                  },
                  incidentCommentsMap: incidentCommentsMap,
                  incidentDetailsModel: incidentDetailsModel,
                )
              ]))),
      bottomNavigationBar: MultiBlocListener(
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
                        incidentId: incidentListDatum.id,
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
              onPressed: incidentCommentsMap['comments'] != ''
                  ? () {
                      if (incidentCommentsMap['file_name'] != null &&
                          incidentCommentsMap['file_name'].isNotEmpty) {
                        context.read<UploadImageBloc>().add(UploadImage(
                            images: incidentCommentsMap['file_name'],
                            imageLength: context
                                .read<ImagePickerBloc>()
                                .lengthOfImageList));
                      } else {
                        context.read<IncidentDetailsBloc>().add(
                            SaveIncidentComments(
                                saveCommentsMap: incidentCommentsMap));
                      }
                    }
                  : null,
              textValue: StringConstants.kSave),
        ),
      ),
    );
  }
}
