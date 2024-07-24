import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/tankManagement/tank_management_bloc.dart';
import 'package:toolkit/data/enums/tank_Status_filter_enum.dart';
import '../../../../configs/app_dimensions.dart';
import '../../../../widgets/custom_choice_chip.dart';

class TankStatusFilter extends StatelessWidget {
  const TankStatusFilter({super.key, required this.tankFilterMap});

  final Map tankFilterMap;

  @override
  Widget build(BuildContext context) {
    context.read<TankManagementBloc>().add(SelectTankStatusFilter(
        selected: true, selectedIndex: tankFilterMap['status'] ?? ''));
    return Wrap(spacing: kFilterTags, children: choiceChips());
  }

  List<Widget> choiceChips() {
    List<Widget> chips = [];
    for (int i = 0; i < TankStatusFilterEnum.values.length; i++) {
      String id = TankStatusFilterEnum.values[i].value.toString();
      Widget item = BlocBuilder<TankManagementBloc, TankManagementState>(
          buildWhen: (previousState, currentState) =>
              currentState is TankStatusFilterSelected,
          builder: (context, state) {
            if (state is TankStatusFilterSelected) {
              tankFilterMap["status"] = state.selectedIndex;
              return CustomChoiceChip(
                label: TankStatusFilterEnum.values[i].status,
                selected: (tankFilterMap["status"] == null)
                    ? state.selected
                    : state.selectedIndex == id,
                onSelected: (bool value) {
                  context.read<TankManagementBloc>().add(SelectTankStatusFilter(
                      selected: value, selectedIndex: id));
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
