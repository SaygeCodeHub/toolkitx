import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/widgets/custom_floating_action_button.dart';
import 'package:toolkit/widgets/primary_button.dart';

import '../../../blocs/incident/incidentDetails/incident_details_bloc.dart';
import '../../../blocs/incident/incidentDetails/incident_details_event.dart';
import '../../../blocs/incident/incidentInjuryDetails/incident_injury_details_bloc.dart';
import '../../../blocs/incident/incidentInjuryDetails/incident_injury_details_event.dart';
import '../../../blocs/incident/incidentInjuryDetails/incident_injury_details_states.dart';
import '../../../blocs/incident/incidentListAndFilter/incident_list_and_filter_bloc.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/incident/incident_details_model.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/progress_bar.dart';
import 'injury_screen_body.dart';
import 'incident_injured_person_list.dart';

class IncidentInjuredPersonTab extends StatelessWidget {
  final IncidentDetailsModel incidentDetailsModel;
  final int initialIndex;
  final String incidentId;
  final Map injuredPersonDetailMap = {};

  IncidentInjuredPersonTab(
      {super.key,
      required this.incidentDetailsModel,
      required this.initialIndex,
      required this.incidentId});

  @override
  Widget build(BuildContext context) {
    injuredPersonDetailMap['incidentId'] = incidentId;
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton:
            BlocBuilder<InjuryDetailsBloc, InjuryDetailsStates>(
                buildWhen: (previousState, currentState) =>
                    currentState is FetchingInjuryMaster ||
                    currentState is InjuryMasterFetched ||
                    currentState is InjuryDetailsInitial,
                builder: (context, state) {
                  if (state is FetchingInjuryMaster) {
                    return const SizedBox();
                  } else if (state is InjuryMasterFetched) {
                    return const SizedBox();
                  } else {
                    return CustomFloatingActionButton(
                        onPressed: () {
                          context
                              .read<InjuryDetailsBloc>()
                              .add(const InjuryMaster());
                        },
                        textValue: DatabaseUtil.getText(
                            'addInjuredPersonPageHeading'));
                  }
                }),
        body: BlocConsumer<InjuryDetailsBloc, InjuryDetailsStates>(
            buildWhen: (previousState, currentState) =>
                currentState is FetchingInjuryMaster ||
                currentState is InjuryMasterFetched ||
                currentState is InjuryDetailsInitial,
            listener: (context, state) {
              if (state is SavingInjuryPerson) {
                ProgressBar.show(context);
              }
              if (state is SavedInjuredPerson) {
                ProgressBar.dismiss(context);
                context.read<IncidentDetailsBloc>().add(
                    FetchIncidentDetailsEvent(
                        incidentId: incidentId,
                        role: context.read<IncidentLisAndFilterBloc>().roleId,
                        initialIndex: initialIndex));
              }
              if (state is ErrorSavingInjuredPerson) {
                ProgressBar.dismiss(context);
                showCustomSnackBar(context, state.message, '');
              }
            },
            builder: (context, state) {
              if (state is FetchingInjuryMaster) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is InjuryMasterFetched) {
                return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(children: [
                      InjuryScreenBody(
                          injuryNatureList:
                              state.incidentInjuryMasterModel.data[0],
                          injuredPersonDetails: injuredPersonDetailMap),
                      const SizedBox(height: xxxSmallestSpacing),
                      Row(children: [
                        Expanded(
                            child: PrimaryButton(
                                onPressed: () {
                                  context
                                      .read<InjuryDetailsBloc>()
                                      .add(const CancelAddInjuredPerson());
                                },
                                textValue: DatabaseUtil.getText('Cancel'))),
                        const SizedBox(width: smallerSpacing),
                        Expanded(
                            child: PrimaryButton(
                                onPressed: () {
                                  context.read<InjuryDetailsBloc>().add(
                                      SaveInjuredPerson(
                                          injuredPersonDetailMap));
                                },
                                textValue: DatabaseUtil.getText('buttonSave')))
                      ]),
                      const SizedBox(height: tiniestSpacing)
                    ]));
              } else {
                return InjuredPersonList(
                    incidentDetailsModel: incidentDetailsModel);
              }
            }));
  }
}
