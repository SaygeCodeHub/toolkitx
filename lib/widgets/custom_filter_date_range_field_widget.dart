import 'package:flutter/material.dart';

import '../configs/app_spacing.dart';
import '../screens/incident/widgets/date_picker.dart';
import '../utils/constants/string_constants.dart';
import '../utils/database_utils.dart';

typedef FromDateCallBack = Function(String fromDate);
typedef ToDateCallBack = Function(String toDate);

class CustomFilterDateRangeFieldWidget extends StatelessWidget {
  final String fromDate;
  final String toDate;
  final FromDateCallBack onFromDateSelected;
  final ToDateCallBack onToDateSelected;

  const CustomFilterDateRangeFieldWidget(
      {Key? key,
      required this.fromDate,
      required this.toDate,
      required this.onFromDateSelected,
      required this.onToDateSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Expanded(
          child: DatePickerTextField(
              editDate: fromDate,
              hintText: DatabaseUtil.getText('SelectDate'),
              onDateChanged: (String date) {
                onFromDateSelected(date);
              })),
      const SizedBox(width: xxTinierSpacing),
      const Text(StringConstants.kBis),
      const SizedBox(width: xxTinierSpacing),
      Expanded(
          child: DatePickerTextField(
              editDate: toDate,
              hintText: DatabaseUtil.getText('SelectDate'),
              onDateChanged: (String date) {
                onToDateSelected(date);
              }))
    ]);
  }
}
