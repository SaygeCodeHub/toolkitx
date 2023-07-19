import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/incident/reportNewIncident/report_new_incident_states.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../blocs/incident/reportNewIncident/report_new_incident_bloc.dart';
import '../../blocs/incident/reportNewIncident/report_new_incident_events.dart';
import '../../configs/app_spacing.dart';
import '../../utils/database_utils.dart';
import '../../utils/report_new_incident_health_and_safety_util.dart';
import '../../utils/constants/string_constants.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/primary_button.dart';
import 'add_injured_person_screen.dart';

class IncidentHealthAndSafetyScreen extends StatelessWidget {
  static const routeName = 'IncidentHealthAndSafetyScreen';
  final Map addAndEditIncidentMap;
  static List customInfoFieldList = [];

  const IncidentHealthAndSafetyScreen(
      {Key? key, required this.addAndEditIncidentMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context
        .read<ReportNewIncidentBloc>()
        .add(ReportNewIncidentCustomInfoFieldFetch());
    return Scaffold(
      appBar: const GenericAppBar(title: StringConstants.kReportNewIncident),
      body: BlocBuilder<ReportNewIncidentBloc, ReportNewIncidentStates>(
          buildWhen: (previousState, currentState) =>
              currentState is ReportNewIncidentCustomFieldFetched,
          builder: (context, state) {
            if (state is ReportNewIncidentCustomFieldFetched) {
              return Padding(
                padding: const EdgeInsets.only(
                    left: leftRightMargin,
                    right: leftRightMargin,
                    top: xxTinySpacing),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.fetchIncidentMasterModel
                              .incidentMasterDatum![7].length,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    state.fetchIncidentMasterModel
                                        .incidentMasterDatum![7][index].title!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .xSmall
                                        .copyWith(fontWeight: FontWeight.w600)),
                                const SizedBox(height: xxxTinierSpacing),
                                ReportNewIncidentHealthAndSafetyUtil()
                                    .addHealthAndSafetyCaseWidget(
                                        index,
                                        state.fetchIncidentMasterModel
                                            .incidentMasterDatum![7],
                                        customInfoFieldList,
                                        addAndEditIncidentMap),
                                const SizedBox(height: xxTinySpacing),
                              ],
                            );
                          }),
                    ]),
              );
            } else {
              return const SizedBox();
            }
          }),
      bottomNavigationBar: BottomAppBar(
          child: PrimaryButton(
              onPressed: () {
                addAndEditIncidentMap['customfields'] = customInfoFieldList;
                Navigator.pushNamed(context, AddInjuredPersonScreen.routeName,
                    arguments: addAndEditIncidentMap);
              },
              textValue: DatabaseUtil.getText('nextButtonText'))),
    );
  }
}
