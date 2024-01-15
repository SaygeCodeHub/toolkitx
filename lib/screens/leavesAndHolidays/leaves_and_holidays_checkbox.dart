import 'package:flutter/material.dart';

import '../../configs/app_color.dart';

typedef CreatedForListCallBack = Function(List codeList);

class SearchEquipmentCheckbox extends StatefulWidget {
  const SearchEquipmentCheckbox({
    super.key,
    required this.selectedCreatedForIdList,
    required this.id,
    required this.onCreatedForChanged,
    required this.idList,
  });
  final String id;
  final List selectedCreatedForIdList;
  final CreatedForListCallBack onCreatedForChanged;
  final List idList;
  @override
  State<SearchEquipmentCheckbox> createState() =>
      _SearchEquipmentCheckboxState();
}

class _SearchEquipmentCheckboxState extends State<SearchEquipmentCheckbox> {
  void _checkboxChange(isSelected, id) {
    if (isSelected) {
      widget.selectedCreatedForIdList.add(id);
      widget.onCreatedForChanged(widget.idList);
    } else {
      widget.selectedCreatedForIdList.remove(id);
      widget.onCreatedForChanged(widget.idList);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      activeColor: AppColor.deepBlue,
      value: widget.selectedCreatedForIdList.contains(widget.id),
      onChanged: (isChecked) {
        _checkboxChange(isChecked, widget.id);
        setState(() {
          isChecked = isChecked!;
        });
      },
    );
  }
}
