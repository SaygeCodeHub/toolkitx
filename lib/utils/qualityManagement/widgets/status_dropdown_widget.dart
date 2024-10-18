import 'package:flutter/material.dart';

import '../../../configs/app_color.dart';
import '../../../data/enums/qualityManagement/status_enum.dart';

typedef StatusCallBack = Function(String selectedValue);

class StatusDropdownWidget extends StatefulWidget {
  final StatusCallBack onStatusChanged;

  const StatusDropdownWidget({super.key, required this.onStatusChanged});

  @override
  State<StatusDropdownWidget> createState() => _StatusDropdownWidgetState();
}

class _StatusDropdownWidgetState extends State<StatusDropdownWidget> {
  String selectedValue = '';

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: StatusEnum.values.length,
        itemBuilder: (context, index) {
          return RadioListTile(
              activeColor: AppColor.blue,
              contentPadding: EdgeInsets.zero,
              title: Text(StatusEnum.values[index].label),
              value: StatusEnum.values[index].value,
              groupValue: selectedValue,
              onChanged: (value) {
                setState(() {
                  selectedValue = value!;
                });
                widget.onStatusChanged(selectedValue);
              });
        });
  }
}
