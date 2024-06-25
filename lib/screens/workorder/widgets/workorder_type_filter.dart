import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/workorder/workorder_bloc.dart';
import '../../../blocs/workorder/workorder_events.dart';
import '../../../blocs/workorder/workorder_states.dart';
import '../../../configs/app_dimensions.dart';
import '../../../data/models/workorder/fetch_workorder_master_model.dart';
import '../../../widgets/custom_choice_chip.dart';

class WorkOrderTypeFilter extends StatelessWidget {
  final Map workOrderFilterMap;
  final List<List<WorkOrderMasterDatum>> workOderDatum;

  const WorkOrderTypeFilter(
      {Key? key, required this.workOrderFilterMap, required this.workOderDatum})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context
        .read<WorkOrderBloc>()
        .add(SelectWorkOrderStatusFilter(id: workOrderFilterMap['type'] ?? ''));

    return Wrap(spacing: kFilterTags, children: choiceChips());
  }

  List<Widget> choiceChips() {
    List<Widget> chips = [];
    for (int i = 0; i < workOderDatum[6].length; i++) {
      String id = workOderDatum[6][i].id.toString();
      Widget item = BlocBuilder<WorkOrderBloc, WorkOrderStates>(
          buildWhen: (previousState, currentState) =>
              currentState is WorkOrderTypeSelected,
          builder: (context, state) {
            if (state is WorkOrderTypeSelected) {
              workOrderFilterMap['type'] = state.id.toString();
              return CustomChoiceChip(
                label: workOderDatum[6][i].workordertype,
                selected: (workOrderFilterMap['type'] == null)
                    ? false
                    : workOrderFilterMap['type'] == id,
                onSelected: (bool val) {
                  context
                      .read<WorkOrderBloc>()
                      .add(SelectWorkOrderTypeFilter(value: id));
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
