import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../utils/database_utils.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/generic_text_field.dart';
import '../incident/widgets/date_picker.dart';
import '../incident/widgets/time_picker.dart';
import 'widgets/workorder_downtime_save_button.dart';

class WorkOrderAddDownTimeScreen extends StatelessWidget {
  static const routeName = 'WorkOrderAddDownTimeScreen';
  static Map addDownTimeMap = {};

  const WorkOrderAddDownTimeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GenericAppBar(title: DatabaseUtil.getText('ScheduleDowntime')),
        bottomNavigationBar: const WorkOrderDownTimeSaveButton(),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: xxTinySpacing),
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
                        hintText: StringConstants.kSelectDate,
                        onDateChanged: (String date) {
                          addDownTimeMap['startdate'] = date;
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
                        hintText: StringConstants.kSelectTime,
                        onTimeChanged: (String time) {
                          addDownTimeMap['starttime'] = time;
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
                        hintText: StringConstants.kSelectDate,
                        onDateChanged: (String date) {
                          addDownTimeMap['enddate'] = date;
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
                        hintText: StringConstants.kSelectTime,
                        onTimeChanged: (String time) {
                          addDownTimeMap['endtime'] = time;
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
                          maxLength: 200,
                          textInputAction: TextInputAction.done,
                          maxLines: 2,
                          textInputType: TextInputType.text,
                          onTextFieldChanged: (String textField) {
                            addDownTimeMap['notes'] = textField;
                          }),
                    ]))));
  }
}
