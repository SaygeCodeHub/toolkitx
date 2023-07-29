import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../blocs/incident/incidentInjuryDetails/incident_injury_details_bloc.dart';
import '../../../blocs/incident/incidentInjuryDetails/incident_injury_details_event.dart';
import '../../../blocs/incident/incidentInjuryDetails/incident_injury_details_states.dart';
import '../../../configs/app_color.dart';
import '../../../data/models/incident/incident_injury_master.dart';

class InjuryNatureExpansionTile extends StatelessWidget {
  final List<IncidentInjuryMasterDatum> injuryNature;
  final Map injuredPersonDetails;

  const InjuryNatureExpansionTile(
      {Key? key,
      required this.injuryNature,
      required this.injuredPersonDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InjuryDetailsBloc, InjuryDetailsStates>(
        buildWhen: (previousState, currentState) =>
            currentState is InjuryNatureSelected,
        builder: (context, state) {
          if (state is InjuryNatureSelected) {
            injuredPersonDetails['injury'] = state.selectedInjuryId
                .toString()
                .replaceAll('[', '')
                .replaceAll(']', '');
            return Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                    maintainState: true,
                    title: Text(
                        (state.selectedInjuryNature.isEmpty)
                            ? 'Select'
                            : state.selectedInjuryNature
                                .toString()
                                .replaceAll('[', '')
                                .replaceAll(']', ''),
                        style: Theme.of(context).textTheme.xSmall),
                    children: [
                      ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: injuryNature.length,
                          itemBuilder: (BuildContext context, int index) {
                            return CheckboxListTile(
                                checkColor: AppColor.white,
                                activeColor: AppColor.deepBlue,
                                value: state.selectedInjuryId
                                    .contains(injuryNature[index].id),
                                title: Text(injuryNature[index].name),
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                                onChanged: (isChecked) {
                                  context.read<InjuryDetailsBloc>().add(
                                      SelectInjuryNature(
                                          state.selectedInjuryId,
                                          state.selectedInjuryNature,
                                          injuryNature[index],
                                          state.selectedInjuryArea,
                                          ''));
                                });
                          })
                    ]));
          } else {
            return const SizedBox();
          }
        });
  }
}
