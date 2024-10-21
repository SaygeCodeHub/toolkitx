import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/workorder/workOrderTabsDetails/workorder_tab_details_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_events.dart';
import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_states.dart';
import '../../../configs/app_color.dart';
import '../../../utils/constants/string_constants.dart';

class WorkOrderSpecialWorkExpansionTile extends StatelessWidget {
  final List data;
  final Map workOrderDetailsMap;

  WorkOrderSpecialWorkExpansionTile(
      {super.key, required this.data, required this.workOrderDetailsMap});
  final List selectedIdList = [];
  final List selectedNameList = [];

  void _checkboxChange(isSelected, workOrderId, workOrderName) {
    if (isSelected) {
      selectedIdList.add(workOrderId);
      selectedNameList.add(workOrderName);
    } else {
      selectedIdList.remove(workOrderId);
      selectedNameList.remove(workOrderName);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isChecked = true;
    context
        .read<WorkOrderTabDetailsBloc>()
        .add(SelectSpecialWorkOptions(isChecked: isChecked));
    return BlocBuilder<WorkOrderTabDetailsBloc, WorkOrderTabDetailsStates>(
        buildWhen: (previousState, currentState) =>
            currentState is SpecialWorkOptionsSelected,
        builder: (context, state) {
          if (state is SpecialWorkOptionsSelected) {
            workOrderDetailsMap['specialwork'] = selectedIdList
                .toString()
                .replaceAll(' ', '')
                .replaceAll("[", "")
                .replaceAll("]", "");
            return Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: AppColor.transparent),
                child: ExpansionTile(
                    maintainState: true,
                    title: Text(
                        (selectedIdList.isEmpty)
                            ? StringConstants.kSelect
                            : selectedNameList
                                .toString()
                                .replaceAll('[', '')
                                .replaceAll(']', ''),
                        style: Theme.of(context).textTheme.xSmall),
                    children: [
                      ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: data[9].length,
                          itemBuilder: (BuildContext context, int index) {
                            return CheckboxListTile(
                                contentPadding: EdgeInsets.zero,
                                checkColor: AppColor.white,
                                activeColor: AppColor.deepBlue,
                                value:
                                    selectedIdList.contains(data[9][index].id),
                                title: Text(data[9][index].name),
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                                onChanged: (isChecked) {
                                  _checkboxChange(isChecked, data[9][index].id,
                                      data[9][index].name);
                                  context.read<WorkOrderTabDetailsBloc>().add(
                                      SelectSpecialWorkOptions(
                                          isChecked: isChecked!));
                                });
                          })
                    ]));
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}
