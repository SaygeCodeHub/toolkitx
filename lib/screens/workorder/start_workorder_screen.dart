import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../utils/database_utils.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/generic_text_field.dart';
import '../incident/widgets/date_picker.dart';
import '../incident/widgets/time_picker.dart';
import 'widgets/start_workorder_button.dart';

class StartWorkOrderScreen extends StatelessWidget {
  static const routeName = 'StartWorkOrderScreen';

  const StartWorkOrderScreen({Key? key}) : super(key: key);
  static Map startWorkOrderMap = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GenericAppBar(title: DatabaseUtil.getText('WorkOrder')),
        bottomNavigationBar: const StartWorkOrderButton(),
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
                      Text(DatabaseUtil.getText('Date'),
                          style: Theme.of(context)
                              .textTheme
                              .xSmall
                              .copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: xxxTinierSpacing),
                      DatePickerTextField(
                        hintText: StringConstants.kSelectDate,
                        onDateChanged: (String date) {
                          startWorkOrderMap['date'] = date;
                        },
                      ),
                      const SizedBox(height: xxTinySpacing),
                      Text(DatabaseUtil.getText('Time'),
                          style: Theme.of(context)
                              .textTheme
                              .xSmall
                              .copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: xxxTinierSpacing),
                      TimePickerTextField(
                        hintText: StringConstants.kSelectTime,
                        onTimeChanged: (String time) {
                          startWorkOrderMap['time'] = time;
                        },
                      ),
                      const SizedBox(height: xxTinySpacing),
                      Text(DatabaseUtil.getText('Comments'),
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
                            startWorkOrderMap['comments'] = textField;
                          }),
                    ]))));
  }
}
