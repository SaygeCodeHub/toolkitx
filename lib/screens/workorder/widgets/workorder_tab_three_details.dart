import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../data/models/workorder/fetch_workorder_details_model.dart';

class WorkOrderTabThreeDetails extends StatelessWidget {
  final WorkOrderDetailsData data;
  final int tabIndex;

  const WorkOrderTabThreeDetails(
      {Key? key, required this.data, required this.tabIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ToggleSwitch(
        animate: true,
        minWidth: kToggleSwitchMinWidth,
        initialLabelIndex: 0,
        cornerRadius: kSignInToggleCornerRadius,
        activeFgColor: AppColor.black,
        inactiveBgColor: AppColor.blueGrey,
        inactiveFgColor: AppColor.black,
        totalSwitches: 4,
        labels: const [
          'Document',
          'Items/Parts',
          'Misc.Cost',
          'Schedule Downtime',
        ],
        activeBgColors: const [
          [AppColor.lightBlue],
          [AppColor.lightBlue],
          [AppColor.lightBlue],
          [AppColor.lightBlue]
        ],
        onToggle: (index) {});
  }
}
