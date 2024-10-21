import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/screens/incident/category_screen.dart';
import '../../blocs/incident/reportNewIncident/report_new_incident_bloc.dart';
import '../../blocs/incident/reportNewIncident/report_new_incident_events.dart';
import '../../blocs/incident/reportNewIncident/report_new_incident_states.dart';
import '../../utils/database_utils.dart';
import '../../widgets/custom_floating_action_button.dart';
import '../../widgets/generic_app_bar.dart';
import 'incident_injuries_screen.dart';
import 'widgets/add_injures_person_body.dart';
import 'widgets/add_injures_person_bottom_navigation_bar.dart';

class AddInjuredPersonScreen extends StatelessWidget {
  static const routeName = 'AddInjuredPersonScreen';
  final Map addAndEditIncidentMap;

  const AddInjuredPersonScreen(
      {super.key, required this.addAndEditIncidentMap});

  @override
  Widget build(BuildContext context) {
    context.read<ReportNewIncidentBloc>().add(FetchIncidentInjuredPerson(
        injuredPersonDetailsList: (addAndEditIncidentMap['persons'] == null)
            ? []
            : addAndEditIncidentMap['persons']));
    return Scaffold(
        appBar: GenericAppBar(
            title: DatabaseUtil.getText('addInjuredPersonPageHeading')),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: (CategoryScreen.isFromEdit == true)
            ? const SizedBox.shrink()
            : CustomFloatingActionButton(
                textValue: DatabaseUtil.getText('addInjuredPersonPageDetails'),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => IncidentInjuriesScreen(
                          addIncidentMap: addAndEditIncidentMap)));
                }),
        body: BlocBuilder<ReportNewIncidentBloc, ReportNewIncidentStates>(
            buildWhen: (previousState, currentState) =>
                currentState is ReportNewIncidentInjuredPersonDetailsFetched,
            builder: (context, state) {
              if (state is ReportNewIncidentInjuredPersonDetailsFetched) {
                return AddInjuredPersonBody(
                    injuredPersonsList: state.injuredPersonDetailsList,
                    addAndEditIncidentMap: addAndEditIncidentMap);
              } else {
                return const SizedBox();
              }
            }),
        bottomNavigationBar: AddInjuredPersonBottomNavBar(
            addAndEditIncidentMap: addAndEditIncidentMap));
  }
}
