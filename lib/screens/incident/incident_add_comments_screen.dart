import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/incident/incidentDetails/incident_details_bloc.dart';
import 'package:toolkit/blocs/incident/incidentDetails/incident_details_states.dart';
import 'package:toolkit/blocs/incident/incidentListAndFilter/incident_list_and_filter_bloc.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/progress_bar.dart';

import '../../blocs/incident/incidentDetails/incident_details_event.dart';
import '../../blocs/pickAndUploadImage/pick_and_upload_image_bloc.dart';
import '../../blocs/pickAndUploadImage/pick_and_upload_image_events.dart';
import '../../configs/app_spacing.dart';
import '../../data/models/incident/fetch_incidents_list_model.dart';
import '../../data/models/incident/incident_details_model.dart';
import '../../utils/constants/string_constants.dart';
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
    incidentCommentsMap['filenames'] = null;
    context.read<PickAndUploadImageBloc>().add(UploadInitial());
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
              IncidentCommonCommentsSection(
                onPhotosUploaded: (List uploadList) {
                  incidentCommentsMap['filenames'] = uploadList
                      .toString()
                      .replaceAll("[", '')
                      .replaceAll(']', '');
                },
                onTextFieldValue: (String textValue) {
                  incidentCommentsMap['comments'] = textValue;
                },
                incidentCommentsMap: incidentCommentsMap,
                incidentDetailsModel: incidentDetailsModel,
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
                              role: context
                                  .read<IncidentLisAndFilterBloc>()
                                  .roleId));
                    } else if (state is IncidentCommentsNotSaved) {
                      ProgressBar.dismiss(context);
                      showCustomSnackBar(context, state.commentsNotSaved, '');
                    }
                  },
                  child: PrimaryButton(
                      onPressed: () {
                        incidentCommentsMap['incidentId'] =
                            incidentListDatum.id;
                        log('incidentCommentsMap============>$incidentCommentsMap');
                        // context.read<IncidentDetailsBloc>().add(
                        //     SaveIncidentComments(
                        //         saveCommentsMap: incidentCommentsMap));
                      },
                      textValue: StringConstants.kSave)),
            ],
          ),
        ),
      ),
    );
  }
}
