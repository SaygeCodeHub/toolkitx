import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/workorder/workOrderTabsDetails/workorder_tab_details_bloc.dart';
import 'package:toolkit/blocs/workorder/workOrderTabsDetails/workorder_tab_details_states.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/enums/workorder_priority_enum.dart';

class WorkOrderPriorityExpansionTile extends StatelessWidget {
  final Map workOrderDetailsMap;

  const WorkOrderPriorityExpansionTile(
      {Key? key, required this.workOrderDetailsMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<WorkOrderTabDetailsBloc>().add(SelectWorkOrderPriorityOptions(
        priorityId: workOrderDetailsMap['priorityid'] ?? '',
        priorityValue: ''));
    return BlocBuilder<WorkOrderTabDetailsBloc, WorkOrderTabDetailsStates>(
        buildWhen: (previousState, currentState) =>
            currentState is WorkOrderPriorityOptionSelected,
        builder: (context, state) {
          if (state is WorkOrderPriorityOptionSelected) {
            workOrderDetailsMap['priorityid'] = state.priorityId;
            log('id===========>${workOrderDetailsMap['priorityid']}');
            log('value============>${priorityNameSwitch(context, workOrderDetailsMap['priorityid'])}');
            return Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: AppColor.transparent),
                child: ExpansionTile(
                    maintainState: true,
                    key: GlobalKey(),
                    title: Text(
                        (state.priorityValue.isEmpty)
                            ? StringConstants.kSelectPriority
                            : state.priorityValue,
                        style: Theme.of(context).textTheme.xSmall),
                    children: [
                      ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: WorkOrderPriorityEnum.values.length,
                          itemBuilder: (BuildContext context, int index) {
                            return RadioListTile(
                                contentPadding: const EdgeInsets.only(
                                    left: xxxTinierSpacing),
                                activeColor: AppColor.deepBlue,
                                title: Text(
                                    WorkOrderPriorityEnum.values
                                        .elementAt(index)
                                        .priority,
                                    style: Theme.of(context).textTheme.xSmall),
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                                value: WorkOrderPriorityEnum.values
                                    .elementAt(index)
                                    .value,
                                groupValue: state.priorityId,
                                onChanged: (value) {
                                  context.read<WorkOrderTabDetailsBloc>().add(
                                      SelectWorkOrderPriorityOptions(
                                          priorityId: WorkOrderPriorityEnum
                                              .values
                                              .elementAt(index)
                                              .value,
                                          priorityValue: WorkOrderPriorityEnum
                                              .values
                                              .elementAt(index)
                                              .priority));
                                });
                          })
                    ]));
          } else {
            return const SizedBox.shrink();
          }
        });
  }
 priorityNameSwitch(BuildContext context, String value){
    String priorityValue = '';
   // for (String element in WorkOrderPriorityEnum.values) {
   //   priorityValue = element;
   // }
    switch(value){
      case '1':
         return priorityValue;
      case '2':
        return priorityValue;
    }
 }
}
