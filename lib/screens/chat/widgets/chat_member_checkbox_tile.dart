import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/chatBox/fetch_employees_model.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import '../../../configs/app_color.dart';

class ChatMemberCheckBoxTile extends StatefulWidget {
  const ChatMemberCheckBoxTile({
    super.key,
    required this.employeesDatum,
    required this.selectedEmployeeList,
  });

  final EmployeesDatum employeesDatum;
  final List selectedEmployeeList;

  @override
  State<ChatMemberCheckBoxTile> createState() => _ChatMemberCheckBoxTileState();
}

class _ChatMemberCheckBoxTileState extends State<ChatMemberCheckBoxTile> {
  List selectedIdList = [];

  void _checkboxChange(isSelected, userId, type) {
    if (isSelected) {
      selectedIdList.add({"id": userId, "type": type, "isowner": 0});
      widget.selectedEmployeeList
          .add({"id": userId, "type": type, "isowner": 0});
    } else {
      selectedIdList.removeWhere((element) => element["id"] == userId);
      widget.selectedEmployeeList
          .removeWhere((element) => element["id"] == userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      activeColor: AppColor.deepBlue,
      title: Text(widget.employeesDatum.name,
          style: Theme.of(context)
              .textTheme
              .xSmall
              .copyWith(color: AppColor.black, fontWeight: FontWeight.w500)),
      subtitle: Text((widget.employeesDatum.type == 1)
          ? StringConstants.kSystemUser
          : StringConstants.kWorkforce),
      value: selectedIdList
          .any((element) => element["id"] == widget.employeesDatum.id),
      onChanged: (isChecked) {
        setState(() {
          _checkboxChange(
              isChecked, widget.employeesDatum.id, widget.employeesDatum.type);
        });
      },
    );
  }
}
