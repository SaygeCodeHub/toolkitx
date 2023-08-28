import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/workorder/workorder_bloc.dart';
import 'package:toolkit/blocs/workorder/workorder_states.dart';

import '../../../blocs/workorder/workorder_events.dart';
import '../../../configs/app_dimensions.dart';
import '../../../data/enums/workorder_status_enum.dart';
import '../../../widgets/custom_choice_chip.dart';

class WorkOrderStatusFilter extends StatelessWidget {
  final Map workOrderFilterMap;

  const WorkOrderStatusFilter({Key? key, required this.workOrderFilterMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<WorkOrderBloc>().add(
        SelectWorkOrderTypeFilter(value: workOrderFilterMap['status'] ?? ''));
    return Wrap(spacing: kFilterTags, children: choiceChips());
  }

  List<Widget> choiceChips() {
    List<Widget> chips = [];
    for (int i = 0; i < WorkOrderStatus.values.length; i++) {
      String value = WorkOrderStatus.values[i].value;
      Widget item = BlocBuilder<WorkOrderBloc, WorkOrderStates>(
          buildWhen: (previousState, currentState) =>
              currentState is WorkOrderStatusSelected,
          builder: (context, state) {
            if (state is WorkOrderStatusSelected) {
              return CustomChoiceChip(
                label: WorkOrderStatus.values[i].type,
                selected: (workOrderFilterMap['status'] == null)
                    ? false
                    : state.value == value,
                onSelected: (bool val) {
                  workOrderFilterMap['status'] = state.value;
                  context
                      .read<WorkOrderBloc>()
                      .add(SelectWorkOrderStatusFilter(id: value));
                },
              );
            } else {
              return const SizedBox.shrink();
            }
          });
      chips.add(item);
    }
    return chips;
  }
}
