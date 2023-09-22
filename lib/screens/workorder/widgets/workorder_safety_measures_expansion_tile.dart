import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/workorder/workOrderTabsDetails/workorder_tab_details_bloc.dart';
import 'package:toolkit/blocs/workorder/workOrderTabsDetails/workorder_tab_details_states.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_events.dart';
import '../../../configs/app_color.dart';

class WorkOrderSafetyMeasuresExpansionTile extends StatelessWidget {
  final List data;
  final Map workOrderDetailsMap;

  const WorkOrderSafetyMeasuresExpansionTile(
      {Key? key, required this.data, required this.workOrderDetailsMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List safetyNames = [];
    List safetyIds = [];
    safetyNames = workOrderDetailsMap['measurenames'].toString().split(',');
    safetyIds = workOrderDetailsMap['measure'].toString().split(',');
    context.read<WorkOrderTabDetailsBloc>().add(SelectSafetyMeasureOptions(
        safetyMeasureName: '',
        safetyMeasureNameList: safetyNames,
        safetyMeasureId: '',
        safetyMeasureIdList: safetyIds));
    return BlocBuilder<WorkOrderTabDetailsBloc, WorkOrderTabDetailsStates>(
        buildWhen: (previousState, currentState) =>
            currentState is SafetyMeasuresOptionsSelected,
        builder: (context, state) {
          if (state is SafetyMeasuresOptionsSelected) {
            workOrderDetailsMap['measure'] = state.safetyMeasureIdList
                .toString()
                .replaceAll("[", "")
                .replaceAll("]", "");
            safetyIds = state.safetyMeasureIdList;
            safetyNames = state.safetyMeasureNameList;
            return Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: AppColor.transparent),
                child: ExpansionTile(
                    maintainState: true,
                    title: Text(
                        (safetyNames.isEmpty)
                            ? StringConstants.kSelect
                            : safetyNames
                                .toString()
                                .replaceAll('[', '')
                                .replaceAll(']', ''),
                        style: Theme.of(context).textTheme.xSmall),
                    children: [
                      ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: data[5].length,
                          itemBuilder: (BuildContext context, int index) {
                            return CheckboxListTile(
                                contentPadding: EdgeInsets.zero,
                                checkColor: AppColor.white,
                                activeColor: AppColor.deepBlue,
                                value: safetyIds
                                    .contains(data[5][index].id.toString()),
                                title: Text(data[5][index].name),
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                                onChanged: (isChecked) {
                                  context.read<WorkOrderTabDetailsBloc>().add(
                                      SelectSafetyMeasureOptions(
                                          safetyMeasureName:
                                              data[5][index].name,
                                          safetyMeasureNameList: safetyNames,
                                          safetyMeasureId:
                                              data[5][index].id.toString(),
                                          safetyMeasureIdList: safetyIds));
                                });
                          })
                    ]));
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}
