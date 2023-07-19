import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/incident/editIncidentDetails/edit_incident_details_bloc.dart';
import '../../../blocs/incident/editIncidentDetails/edit_incident_details_events.dart';
import '../../../blocs/incident/editIncidentDetails/edit_incident_details_states.dart';
import '../../../blocs/incident/incidentDetails/incident_details_bloc.dart';
import '../../../blocs/incident/incidentDetails/incident_details_event.dart';
import '../../../blocs/incident/incidentListAndFilter/incident_list_and_filter_bloc.dart';
import '../../../blocs/incident/incidentListAndFilter/incident_list_and_filter_event.dart';
import '../../../blocs/incident/reportNewIncident/report_new_incident_bloc.dart';
import '../../../blocs/incident/reportNewIncident/report_new_incident_events.dart';
import '../../../blocs/incident/reportNewIncident/report_new_incident_states.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/progress_bar.dart';
import '../category_screen.dart';

class AddInjuredPersonBottomNavBar extends StatelessWidget {
  final Map addAndEditIncidentMap;

  const AddInjuredPersonBottomNavBar(
      {Key? key, required this.addAndEditIncidentMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        children: [
          Expanded(
              child: PrimaryButton(
            onPressed: () {
              Navigator.pop(context);
            },
            textValue: DatabaseUtil.getText('buttonBack'),
          )),
          const SizedBox(width: xxTinierSpacing),
          MultiBlocListener(
              listeners: [
                BlocListener<ReportNewIncidentBloc, ReportNewIncidentStates>(
                    listener: (context, state) {
                  if (state is ReportNewIncidentSaving) {
                    ProgressBar.show(context);
                  } else if (state is ReportNewIncidentSaved ||
                      state is ReportNewIncidentPhotoSaved) {
                    ProgressBar.dismiss(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    context.read<IncidentLisAndFilterBloc>().add(
                        const FetchIncidentListEvent(
                            page: 1, isFromHome: false));
                  } else if (state is ReportNewIncidentNotSaved) {
                    ProgressBar.dismiss(context);
                    showCustomSnackBar(
                        context, state.incidentNotSavedMessage, '');
                  }
                }),
                BlocListener<EditIncidentDetailsBloc,
                    EditIncidentDetailsStates>(listener: (context, state) {
                  if (state is EditingIncidentDetails) {
                    ProgressBar.show(context);
                  } else if (state is IncidentDetailsEdited ||
                      state is EditIncidentDetailsPhotoSaved) {
                    ProgressBar.dismiss(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    context
                        .read<IncidentDetailsBloc>()
                        .add(FetchIncidentDetailsEvent(
                          initialIndex: 0,
                          incidentId:
                              context.read<IncidentDetailsBloc>().incidentId,
                          role: context.read<IncidentLisAndFilterBloc>().roleId,
                        ));
                  } else if (state is IncidentDetailsNotEdited) {
                    ProgressBar.dismiss(context);
                    showCustomSnackBar(context, state.incidentNotEdited, '');
                  }
                })
              ],
              child: Expanded(
                child: PrimaryButton(
                    onPressed: () {
                      if (CategoryScreen.isFromEdit == true) {
                        context.read<EditIncidentDetailsBloc>().add(
                            EditIncidentDetails(
                                editIncidentMap: addAndEditIncidentMap));
                      } else {
                        context.read<ReportNewIncidentBloc>().add(
                            SaveReportNewIncident(
                                reportNewIncidentMap: addAndEditIncidentMap,
                                role: context
                                    .read<IncidentLisAndFilterBloc>()
                                    .roleId));
                      }
                    },
                    textValue: StringConstants.kDone),
              )),
        ],
      ),
    );
  }
}
