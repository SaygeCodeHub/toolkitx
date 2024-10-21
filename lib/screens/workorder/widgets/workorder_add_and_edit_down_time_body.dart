import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/generic_text_field.dart';
import '../../incident/widgets/date_picker.dart';
import '../../incident/widgets/time_picker.dart';
import '../workorder_add_and_edit_down_time_screen.dart';

class WorkOrderAddAndEditDownTimeBody extends StatelessWidget {
  const WorkOrderAddAndEditDownTimeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin, right: leftRightMargin, top: xxTinySpacing),
        child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(DatabaseUtil.getText('StartDate'),
                    style: Theme.of(context)
                        .textTheme
                        .xSmall
                        .copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: xxxTinierSpacing),
                DatePickerTextField(
                  editDate: WorkOrderAddAndEditDownTimeScreen
                          .addAndEditDownTimeMap['startdate'] ??
                      '',
                  hintText: StringConstants.kSelectDate,
                  onDateChanged: (String date) {
                    WorkOrderAddAndEditDownTimeScreen
                        .addAndEditDownTimeMap['startdate'] = date;
                  },
                ),
                const SizedBox(height: xxTinySpacing),
                Text(DatabaseUtil.getText('startTimePlaceHolder'),
                    style: Theme.of(context)
                        .textTheme
                        .xSmall
                        .copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: xxxTinierSpacing),
                TimePickerTextField(
                  editTime: WorkOrderAddAndEditDownTimeScreen
                          .addAndEditDownTimeMap['starttime'] ??
                      '',
                  hintText: StringConstants.kSelectTime,
                  onTimeChanged: (String time) {
                    WorkOrderAddAndEditDownTimeScreen
                        .addAndEditDownTimeMap['starttime'] = time;
                  },
                ),
                const SizedBox(height: xxTinySpacing),
                Text(DatabaseUtil.getText('EndDate'),
                    style: Theme.of(context)
                        .textTheme
                        .xSmall
                        .copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: xxxTinierSpacing),
                DatePickerTextField(
                  editDate: WorkOrderAddAndEditDownTimeScreen
                          .addAndEditDownTimeMap['enddate'] ??
                      '',
                  hintText: StringConstants.kSelectDate,
                  onDateChanged: (String date) {
                    WorkOrderAddAndEditDownTimeScreen
                        .addAndEditDownTimeMap['enddate'] = date;
                  },
                ),
                const SizedBox(height: xxTinySpacing),
                Text(DatabaseUtil.getText('endTimePlaceHolder'),
                    style: Theme.of(context)
                        .textTheme
                        .xSmall
                        .copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: xxxTinierSpacing),
                TimePickerTextField(
                  editTime: WorkOrderAddAndEditDownTimeScreen
                          .addAndEditDownTimeMap['endtime'] ??
                      '',
                  hintText: StringConstants.kSelectTime,
                  onTimeChanged: (String time) {
                    WorkOrderAddAndEditDownTimeScreen
                        .addAndEditDownTimeMap['endtime'] = time;
                  },
                ),
                const SizedBox(height: xxTinySpacing),
                Text(DatabaseUtil.getText('ReasonofDowntime'),
                    style: Theme.of(context)
                        .textTheme
                        .xSmall
                        .copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: xxxTinierSpacing),
                TextFieldWidget(
                    value: WorkOrderAddAndEditDownTimeScreen
                            .addAndEditDownTimeMap['notes'] ??
                        '',
                    maxLength: 200,
                    textInputAction: TextInputAction.done,
                    maxLines: 2,
                    textInputType: TextInputType.text,
                    onTextFieldChanged: (String textField) {
                      WorkOrderAddAndEditDownTimeScreen
                          .addAndEditDownTimeMap['notes'] = textField;
                    })
              ],
            )));
  }
}
