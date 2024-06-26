import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/leavesAndHolidays/leaves_and_holidays_states.dart';
import '../../blocs/leavesAndHolidays/leaves_and_holidays_bloc.dart';
import '../../blocs/leavesAndHolidays/leaves_and_holidays_events.dart';
import '../../configs/app_color.dart';

typedef CreatedForListCallBack = Function(List idList);

class TimeSheetSubmitAllCheckbox extends StatelessWidget {
  const TimeSheetSubmitAllCheckbox({
    super.key,
    required this.selectedCreatedForIdList,
    required this.id,
    required this.onCreatedForChanged,
  });

  final String id;
  final List selectedCreatedForIdList;
  final CreatedForListCallBack onCreatedForChanged;

  void _checkboxChange(isSelected, id) {
    if (isSelected) {
      selectedCreatedForIdList.add(id);
      onCreatedForChanged(selectedCreatedForIdList);
    } else {
      selectedCreatedForIdList.remove(id);
      onCreatedForChanged(selectedCreatedForIdList);
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
            value: selectedCreatedForIdList.contains(id),
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
