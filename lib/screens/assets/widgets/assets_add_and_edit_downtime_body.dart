import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../widgets/generic_text_field.dart';
import '../../incident/widgets/date_picker.dart';
import '../../incident/widgets/time_picker.dart';
import 'assets_add_and_edit_downtime_screen.dart';

class AssetsAddAndEditDowntimeBody extends StatelessWidget {
  const AssetsAddAndEditDowntimeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(StringConstants.kStartDate,
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  fontWeight: FontWeight.w500, color: AppColor.black)),
          Padding(
              padding: const EdgeInsets.only(top: xxxTinierSpacing),
              child: DatePickerTextField(
                  editDate: AssetsAddAndEditDowntimeScreen
                          .saveDowntimeMap["startdate"] ??
                      "",
                  onDateChanged: (date) {
                    AssetsAddAndEditDowntimeScreen
                        .saveDowntimeMap["startdate"] = date;
                  })),
          const SizedBox(height: tinierSpacing),
          Text(StringConstants.kEndDate,
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  fontWeight: FontWeight.w500, color: AppColor.black)),
          Padding(
              padding: const EdgeInsets.only(top: xxxTinierSpacing),
              child: DatePickerTextField(
                  editDate: AssetsAddAndEditDowntimeScreen
                          .saveDowntimeMap["enddate"] ??
                      "",
                  onDateChanged: (date) {
                    AssetsAddAndEditDowntimeScreen.saveDowntimeMap["enddate"] =
                        date;
                  })),
          const SizedBox(height: tinierSpacing),
          Text(StringConstants.kStartTime,
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  fontWeight: FontWeight.w500, color: AppColor.black)),
          Padding(
              padding: const EdgeInsets.only(top: xxxTinierSpacing),
              child: TimePickerTextField(
                  editTime: AssetsAddAndEditDowntimeScreen
                          .saveDowntimeMap["starttime"] ??
                      "",
                  onTimeChanged: (String time) {
                    AssetsAddAndEditDowntimeScreen
                        .saveDowntimeMap["starttime"] = time;
                  })),
          const SizedBox(height: tinierSpacing),
          Text(StringConstants.kEndTime,
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  fontWeight: FontWeight.w500, color: AppColor.black)),
          Padding(
              padding: const EdgeInsets.only(top: xxxTinierSpacing),
              child: TimePickerTextField(
                  editTime: AssetsAddAndEditDowntimeScreen
                          .saveDowntimeMap["endtime"] ??
                      "",
                  onTimeChanged: (String time) {
                    AssetsAddAndEditDowntimeScreen.saveDowntimeMap["endtime"] =
                        time;
                  })),
          const SizedBox(height: tinierSpacing),
          Text(StringConstants.kNote,
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  fontWeight: FontWeight.w500, color: AppColor.black)),
          Padding(
              padding: const EdgeInsets.only(top: xxxTinierSpacing),
              child: TextFieldWidget(
                  value:
                      AssetsAddAndEditDowntimeScreen.saveDowntimeMap["note"] ??
                          "",
                  maxLines: 2,
                  onTextFieldChanged: (String textField) {
                    AssetsAddAndEditDowntimeScreen.saveDowntimeMap["note"] =
                        textField;
                  }))
        ]));
  }
}
