import '../../../configs/app_color.dart';
import '../../../data/models/equipmentTraceability/fetch_search_equipment_model.dart';
import 'package:flutter/material.dart';

typedef CreatedForListCallBack = Function(List codeList);

class SearchEquipmentCheckbox extends StatefulWidget {
  const SearchEquipmentCheckbox({
    super.key,
    required this.selectedCreatedForIdList,
    required this.data,
    required this.onCreatedForChanged,
    required this.codeList,
  });

  final SearchEquipmentDatum data;
  final List selectedCreatedForIdList;
  final CreatedForListCallBack onCreatedForChanged;
  final List codeList;

  @override
  State<SearchEquipmentCheckbox> createState() =>
      _SearchEquipmentCheckboxState();
}

class _SearchEquipmentCheckboxState extends State<SearchEquipmentCheckbox> {
  @override
  void initState() {
    super.initState();
    widget.selectedCreatedForIdList.clear();
    widget.codeList.clear();
  }

  void _checkboxChange(isSelected, equipmentId, code) {
    if (isSelected) {
      widget.selectedCreatedForIdList.add(equipmentId);
      widget.codeList.add(code);
      widget.onCreatedForChanged(widget.codeList);
    } else {
      widget.selectedCreatedForIdList.remove(equipmentId);
      widget.codeList.remove(code);
      widget.onCreatedForChanged(widget.codeList);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      activeColor: AppColor.deepBlue,
      value: widget.selectedCreatedForIdList.contains(widget.data.id),
      onChanged: (isChecked) {
        _checkboxChange(isChecked, widget.data.id, widget.data.equipmentcode);
        setState(() {
          isChecked = isChecked!;
        });
      },
    );
  }
}
