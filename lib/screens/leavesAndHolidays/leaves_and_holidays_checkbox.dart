import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/leavesAndHolidays/leaves_and_holidays_states.dart';
import '../../blocs/leavesAndHolidays/leaves_and_holidays_bloc.dart';
import '../../blocs/leavesAndHolidays/leaves_and_holidays_events.dart';
import '../../configs/app_color.dart';

typedef CreatedForListCallBack = Function(List idList);

class TimeSheetCheckbox extends StatelessWidget {
  const TimeSheetCheckbox({
    super.key,
    required this.id,
    required this.onCreatedForChanged,
  });

  final String id;
  final CreatedForListCallBack onCreatedForChanged;
  static List idsList = [];
  void _checkboxChange(isSelected, id) {
    if (isSelected) {
      idsList.add(id);
      onCreatedForChanged(idsList);
    } else {
      idsList.remove(id);
      onCreatedForChanged(idsList);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isChecked = false;
    context
        .read<LeavesAndHolidaysBloc>()
        .add(SelectCheckBox(isChecked: isChecked));
    return BlocBuilder<LeavesAndHolidaysBloc, LeavesAndHolidaysStates>(
      buildWhen: (previousState, currentState) =>
          currentState is CheckBoxSelected,
      builder: (context, state) {
        if (state is CheckBoxSelected) {
          return Checkbox(
            activeColor: AppColor.deepBlue,
            value: idsList.contains(id),
            onChanged: (isChecked) {
              _checkboxChange(isChecked, id);
              context
                  .read<LeavesAndHolidaysBloc>()
                  .add(SelectCheckBox(isChecked: isChecked!));
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
