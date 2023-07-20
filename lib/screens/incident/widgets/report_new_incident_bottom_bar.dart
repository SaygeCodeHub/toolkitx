import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/incident/reportNewIncident/report_new_incident_bloc.dart';
import '../../../blocs/incident/reportNewIncident/report_new_incident_events.dart';
import '../../../blocs/incident/reportNewIncident/report_new_incident_states.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/primary_button.dart';
import '../incident_location_screen.dart';

class ReportNewIncidentBottomBar extends StatelessWidget {
  final Map addAndEditIncidentMap;

  const ReportNewIncidentBottomBar(
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
          BlocListener<ReportNewIncidentBloc, ReportNewIncidentStates>(
            listener: (context, state) {
              if (state is ReportNewIncidentDateTimeDescValidated) {
                showCustomSnackBar(
                    context, state.dateTimeDescValidationMessage, '');
              } else if (state
                  is ReportNewIncidentDateTimeDescValidationComplete) {
                Navigator.pushNamed(context, IncidentLocationScreen.routeName,
                    arguments: addAndEditIncidentMap);
              }
            },
            child: Expanded(
              child: PrimaryButton(
                  onPressed: () {
                    context.read<ReportNewIncidentBloc>().add(
                        ReportNewIncidentDateTimeDescriptionValidation(
                            reportNewIncidentMap: addAndEditIncidentMap));
                  },
                  textValue: DatabaseUtil.getText('nextButtonText')),
            ),
          ),
        ],
      ),
    );
  }
}
