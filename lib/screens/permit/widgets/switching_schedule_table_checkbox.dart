import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/data/models/permit/fetch_switching_schedule_instructions_model.dart';

typedef CreatedForStringCallBack = Function(List idList);

class SwitchingScheduleTableCheckbox extends StatefulWidget {
  const SwitchingScheduleTableCheckbox({
    super.key,
    required this.index,
    required this.scheduleInstructionDatum,
    required this.onCreatedForChanged,
    required this.selectedIdList,
  });

  final CreatedForStringCallBack onCreatedForChanged;
  final List<PermitSwithcingScheduleInstructionDatum> scheduleInstructionDatum;
  final int index;
  final List selectedIdList;

  @override
  State<SwitchingScheduleTableCheckbox> createState() =>
      _SwitchingScheduleTableCheckboxState();
}

class _SwitchingScheduleTableCheckboxState
    extends State<SwitchingScheduleTableCheckbox> {
  void _checkboxChange(isSelected, userId) {
    if (isSelected) {
      widget.selectedIdList.add(userId);
      widget.onCreatedForChanged(widget.selectedIdList);
    } else {
      widget.selectedIdList.remove(userId);
      widget.onCreatedForChanged(widget.selectedIdList);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      activeColor: AppColor.deepBlue,
      value: widget.selectedIdList
          .contains(widget.scheduleInstructionDatum[widget.index].id),
      onChanged: (isChecked) {
        setState(() {
          _checkboxChange(
              isChecked, widget.scheduleInstructionDatum[widget.index].id);
        });
      },
    );
  }
}
