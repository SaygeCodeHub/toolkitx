import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/incident/incident_health_and_safety_screen.dart';
import 'package:toolkit/screens/incident/widgets/incident_location_list_tile.dart';
import 'package:toolkit/screens/incident/widgets/incident_repported_authority_expansion_tile.dart';
import 'package:toolkit/screens/incident/widgets/incident_site_list_tile.dart';
import 'package:toolkit/utils/database_utils.dart';
import '../../blocs/incident/reportNewIncident/report_new_incident_bloc.dart';
import '../../blocs/incident/reportNewIncident/report_new_incident_events.dart';
import '../../blocs/incident/reportNewIncident/report_new_incident_states.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/primary_button.dart';

class IncidentLocationScreen extends StatelessWidget {
  static const routeName = 'IncidentLocationScreen';
  final Map addAndEditIncidentMap;

  const IncidentLocationScreen({Key? key, required this.addAndEditIncidentMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GenericAppBar(title: StringConstants.kReportNewIncident),
      body: Padding(
          padding: const EdgeInsets.only(
              left: leftRightMargin, right: leftRightMargin),
          child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IncidentSiteListTile(addIncidentMap: addAndEditIncidentMap),
                    IncidentLocationListTile(
                        addIncidentMap: addAndEditIncidentMap),
                    const SizedBox(height: xxTinySpacing),
                    Text(DatabaseUtil.getText('ReportedAuthorities'),
                        style: Theme.of(context)
                            .textTheme
                            .xSmall
                            .copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: xxxTinierSpacing),
                    IncidentReportedAuthorityExpansionTile(
                        addIncidentMap: addAndEditIncidentMap),
                  ]))),
      bottomNavigationBar: BottomAppBar(
        child: BlocListener<ReportNewIncidentBloc, ReportNewIncidentStates>(
            listener: (context, state) {
              if (state is ReportNewIncidentSiteLocationValidated) {
                showCustomSnackBar(
                    context, state.siteLocationValidationMessage, '');
              } else if (state
                  is ReportNewIncidentSiteLocationValidationComplete) {
                Navigator.pushNamed(
                    context, IncidentHealthAndSafetyScreen.routeName,
                    arguments: addAndEditIncidentMap);
              }
            },
            child: PrimaryButton(
                onPressed: () {
                  context.read<ReportNewIncidentBloc>().add(
                      ReportNewIncidentSiteLocationValidation(
                          reportNewIncidentMap: addAndEditIncidentMap));
                },
                textValue: DatabaseUtil.getText('nextButtonText'))),
      ),
    );
  }
}
