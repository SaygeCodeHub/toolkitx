import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/enums/permit_emergency_enum.dart';
import 'package:toolkit/utils/database_utils.dart';

class PermitEmergencyFilter extends StatefulWidget {
  final Map permitFilterMap;

  const PermitEmergencyFilter({super.key, required this.permitFilterMap});

  @override
  State<PermitEmergencyFilter> createState() => _PermitEmergencyFilterState();
}

class _PermitEmergencyFilterState extends State<PermitEmergencyFilter> {
  bool selected = false;

  @override
  void initState() {
    (widget.permitFilterMap['eme'] != null)
        ? selected = PermitEmergencyEnum
            .values[PermitEmergencyEnum.values.indexWhere(
                (element) => element.valueId == widget.permitFilterMap['eme'])]
            .value
        : false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(DatabaseUtil.getText('Emergency'),
          style: Theme.of(context)
              .textTheme
              .xSmall
              .copyWith(fontWeight: FontWeight.w600)),
      Switch(
          activeColor: AppColor.white,
          inactiveThumbColor: AppColor.white,
          activeTrackColor: AppColor.green,
          inactiveTrackColor: AppColor.lightestGrey,
          value: selected,
          onChanged: (value) {
            setState(() {
              selected = !selected;
              widget.permitFilterMap['eme'] = PermitEmergencyEnum
                  .values[PermitEmergencyEnum.values
                      .indexWhere((element) => element.value == selected)]
                  .valueId;
            });
          })
    ]);
  }
}
