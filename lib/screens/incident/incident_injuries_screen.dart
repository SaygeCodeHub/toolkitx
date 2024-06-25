import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/screens/incident/widgets/injury_screen_body.dart';
import 'package:toolkit/widgets/primary_button.dart';

import '../../blocs/incident/incidentInjuryDetails/incident_injury_details_bloc.dart';
import '../../blocs/incident/incidentInjuryDetails/incident_injury_details_event.dart';
import '../../blocs/incident/incidentInjuryDetails/incident_injury_details_states.dart';
import '../../configs/app_spacing.dart';
import '../../utils/database_utils.dart';
import '../../widgets/generic_app_bar.dart';
import 'add_injured_person_screen.dart';

class IncidentInjuriesScreen extends StatelessWidget {
  static const routeName = 'IncidentInjuriesScreen';
  final Map addIncidentMap;
  static Map injuriesDetailsMap = {};
  static List injuriesDetailsList = [];

  const IncidentInjuriesScreen({Key? key, required this.addIncidentMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<InjuryDetailsBloc>().add(const InjuryMaster());
    injuriesDetailsList = (addIncidentMap['persons'] == null)
        ? []
        : List.from(addIncidentMap['persons']);
    return Scaffold(
      appBar: const GenericAppBar(title: 'Injuries'),
      body: BlocBuilder<InjuryDetailsBloc, InjuryDetailsStates>(
          buildWhen: (previousState, currentState) =>
              currentState is FetchingInjuryMaster ||
              currentState is InjuryMasterFetched,
          builder: (context, state) {
            if (state is FetchingInjuryMaster) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is InjuryMasterFetched) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                    padding: const EdgeInsets.only(
                        left: leftRightMargin,
                        right: leftRightMargin,
                        top: xxxTinierSpacing),
                    child: Column(
                      children: [
                        InjuryScreenBody(
                          injuryNatureList:
                              state.incidentInjuryMasterModel.data[0],
                          injuredPersonDetails: injuriesDetailsMap,
                        ),
                        PrimaryButton(
                            onPressed: () {
                              injuriesDetailsList.add(injuriesDetailsMap);
                              addIncidentMap['persons'] = injuriesDetailsList;
                              injuriesDetailsMap = {};
                              Navigator.pop(context);
                              Navigator.pushReplacementNamed(
                                  context, AddInjuredPersonScreen.routeName,
                                  arguments: addIncidentMap);
                            },
                            textValue: DatabaseUtil.getText('buttonSave'))
                      ],
                    )),
              );
            } else {
              return const SizedBox();
            }
          }),
    );
  }
}
