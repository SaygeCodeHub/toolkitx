import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/tankManagement/tank_management_bloc.dart';
import 'package:toolkit/data/enums/tank_title_filter_enum.dart';
import '../../../../configs/app_dimensions.dart';
import '../../../../widgets/custom_choice_chip.dart';

class TankTitleFilter extends StatelessWidget {
  const TankTitleFilter({super.key, required this.tankFilterMap});

  final Map tankFilterMap;

  @override
  Widget build(BuildContext context) {
    context.read<TankManagementBloc>().add(SelectTankTitleFilter(
        selected: true, selectedIndex: tankFilterMap['type'] ?? ''));
    return Wrap(spacing: kFilterTags, children: choiceChips());
  }

  List<Widget> choiceChips() {
    List<Widget> chips = [];
    for (int i = 0; i < TankTitleFilterEnum.values.length; i++) {
      String id = TankTitleFilterEnum.values[i].value.toString();
      Widget item = BlocBuilder<TankManagementBloc, TankManagementState>(
          buildWhen: (previousState, currentState) =>
              currentState is TankTitleFilterSelected,
          builder: (context, state) {
            if (state is TankTitleFilterSelected) {
              tankFilterMap["type"] = state.selectedIndex;
              return CustomChoiceChip(
                label: TankTitleFilterEnum.values[i].title,
                selected: (tankFilterMap["type"] == null)
                    ? state.selected
                    : state.selectedIndex == id,
                onSelected: (bool value) {
                  context.read<TankManagementBloc>().add(SelectTankTitleFilter(
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
