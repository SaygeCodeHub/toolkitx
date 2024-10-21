import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_color.dart';

import '../../../blocs/incident/incidentInjuryDetails/incident_injury_details_bloc.dart';
import '../../../blocs/incident/incidentInjuryDetails/incident_injury_details_event.dart';
import '../../../blocs/incident/incidentInjuryDetails/incident_injury_details_states.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/enums/injury_area_select_enum.dart';

class InjuryMultiSelect extends StatelessWidget {
  final Map injuredPersonDetails;

  const InjuryMultiSelect({super.key, required this.injuredPersonDetails});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InjuryDetailsBloc, InjuryDetailsStates>(
        buildWhen: (previousState, currentState) =>
            currentState is InjuryNatureSelected,
        builder: (context, state) {
          if (state is InjuryNatureSelected) {
            injuredPersonDetails['bodypart'] = state.selectedInjuryArea
                .toString()
                .replaceAll('[', '')
                .replaceAll(']', '');
            return GridView.builder(
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    childAspectRatio: 4 / 2,
                    mainAxisSpacing: tiniestSpacing,
                    crossAxisSpacing: xxTinierSpacing),
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: InjuryAreaMultiSelectEnum.multiSelect.area.length,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    child: Row(children: [
                      Text(InjuryAreaMultiSelectEnum.multiSelect.area[index]),
                      Checkbox(
                          activeColor: AppColor.deepBlue,
                          value: state.selectedInjuryArea.contains(
                              InjuryAreaMultiSelectEnum
                                  .multiSelect.area[index]),
                          onChanged: (isChecked) {
                            context.read<InjuryDetailsBloc>().add(
                                SelectInjuryNature(
                                    state.selectedInjuryId,
                                    state.selectedInjuryNature,
                                    null,
                                    state.selectedInjuryArea,
                                    InjuryAreaMultiSelectEnum
                                        .multiSelect.area[index]
                                        .toString()));
                          })
                    ]),
                  );
                });
          } else {
            return const SizedBox();
          }
        });
  }
}
