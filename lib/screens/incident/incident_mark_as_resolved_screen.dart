import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/incident/incidentDetails/incident_details_bloc.dart';
import '../../blocs/incident/incidentDetails/incident_details_event.dart';
import '../../blocs/incident/incidentDetails/incident_details_states.dart';
import '../../blocs/incident/incidentListAndFilter/incident_list_and_filter_bloc.dart';
import '../../configs/app_spacing.dart';
import '../../data/models/incident/fetch_incidents_list_model.dart';
import '../../utils/constants/string_constants.dart';
import '../../utils/database_utils.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/progress_bar.dart';
import 'widgets/incident_common_comments_section.dart';

class IncidentMarkAsResolvedScreen extends StatelessWidget {
  static const routeName = 'IncidentMarkAsResolvedScreen';
  final IncidentListDatum incidentListDatum;

  IncidentMarkAsResolvedScreen({Key? key, required this.incidentListDatum})
      : super(key: key);
  final Map incidentCommentsMap = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenericAppBar(title: DatabaseUtil.getText('Markasresolved')),
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
                        context.read<IncidentDetailsBloc>().add(
                            SaveIncidentComments(
                                saveCommentsMap: incidentCommentsMap));
                      },
                      textValue: StringConstants.kSave)),
            ],
          ),
        ),
      ),
    );
  }
}
