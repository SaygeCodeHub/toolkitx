import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/permit/widgets/permit_switching_date_time_fields.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/generic_text_field.dart';

class EditMultiSelectInstructionOfflineBody extends StatelessWidget {
  const EditMultiSelectInstructionOfflineBody({
    super.key,
    required this.switchingScheduleMap,
  });

  final Map switchingScheduleMap;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(StringConstants.kInstructionReceivedBy,
          style: Theme.of(context)
              .textTheme
              .xSmall
              .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
      const SizedBox(height: tiniestSpacing),
      TextFieldWidget(
        onTextFieldChanged: (textField) {
          switchingScheduleMap["instructionreceivedbyname"] = textField;
        },
      ),
      const SizedBox(height: xxxSmallestSpacing),
      Text(StringConstants.kInstructedDateTime,
          style: Theme.of(context)
              .textTheme
              .xSmall
              .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
      const SizedBox(height: tiniestSpacing),
      PermitSwitchingDateTimeFields(
          callBackFunctionForDateTime: (String date, String time) {
        switchingScheduleMap["instructiondate"] = date;
        switchingScheduleMap["instructiontime"] = time;
      }),
      const SizedBox(height: xxxSmallestSpacing),
      Text(StringConstants.kControlEngineer,
          style: Theme.of(context)
              .textTheme
              .xSmall
              .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
      const SizedBox(height: tiniestSpacing),
      TextFieldWidget(
        onTextFieldChanged: (textField) {
          switchingScheduleMap['controlengineername'] = textField;
        },
      ),
      const SizedBox(height: xxxSmallestSpacing),
      Text(StringConstants.kCarriedoutDateTime,
          style: Theme.of(context)
              .textTheme
              .xSmall
              .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
      const SizedBox(height: tiniestSpacing),
      PermitSwitchingDateTimeFields(
          callBackFunctionForDateTime: (String date, String time) {
        switchingScheduleMap["carriedoutdate"] = date;
        switchingScheduleMap["carriedouttime"] = time;
      }),
      const SizedBox(height: xxxSmallestSpacing),
      Text(StringConstants.kCarriedoutConfirmedDateTime,
          style: Theme.of(context)
              .textTheme
              .xSmall
              .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
      const SizedBox(height: tiniestSpacing),
      PermitSwitchingDateTimeFields(
          callBackFunctionForDateTime: (String date, String time) {
        switchingScheduleMap["carriedoutconfirmeddate"] = date;
        switchingScheduleMap["carriedoutconfirmedtime"] = time;
      }),
      const SizedBox(height: xxxSmallestSpacing),
      Text(StringConstants.kSafetyKeyNumber,
          style: Theme.of(context)
              .textTheme
              .xSmall
              .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
      const SizedBox(height: tiniestSpacing),
      TextFieldWidget(
        onTextFieldChanged: (textField) {
          switchingScheduleMap['safetykeynumber'] = textField;
        },
      ),
    ]);
  }
}
