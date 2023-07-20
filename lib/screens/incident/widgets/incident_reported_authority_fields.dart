import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/incident/widgets/time_picker.dart';

import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/generic_text_field.dart';
import '../category_screen.dart';
import 'date_picker.dart';

class IncidentReportedAuthorityFields extends StatelessWidget {
  final Map addIncidentMap;
  final String reportIncidentAuthorityId;

  const IncidentReportedAuthorityFields(
      {Key? key,
      required this.addIncidentMap,
      required this.reportIncidentAuthorityId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String reportedDate = '';
    return Visibility(
        visible: reportIncidentAuthorityId == '1',
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: xxTinySpacing),
          Text(DatabaseUtil.getText('WhichAuthority'),
              style: Theme.of(context)
                  .textTheme
                  .xSmall
                  .copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: xxxTinierSpacing),
          TextFieldWidget(
              value: (CategoryScreen.isFromEdit == true &&
                      addIncidentMap['responsible_person'] != null &&
                      addIncidentMap['responsible_person'].isNotEmpty)
                  ? addIncidentMap['responsible_person']
                  : '',
              hintText: DatabaseUtil.getText('WhichAuthority'),
              onTextFieldChanged: (String textField) {
                addIncidentMap['responsible_person'] = textField;
              }),
          const SizedBox(height: xxTinySpacing),
          Text(DatabaseUtil.getText('WhenReported'),
              style: Theme.of(context)
                  .textTheme
                  .xSmall
                  .copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: xxxTinierSpacing),
          Visibility(
            visible: addIncidentMap['reporteddatetime'] == null ||
                addIncidentMap['reporteddatetime'].toString().isEmpty,
            replacement: TextFieldWidget(
                value: (addIncidentMap['reporteddatetime'] == null ||
                        addIncidentMap['reporteddatetime'].isEmpty)
                    ? ""
                    : addIncidentMap['reporteddatetime']
                        .toString()
                        .substring(0, 10),
                readOnly: true,
                onTextFieldChanged: (String textField) {}),
            child: DatePickerTextField(
              hintText: StringConstants.kSelectDate,
              onDateChanged: (String date) {
                reportedDate = date;
              },
            ),
          ),
          const SizedBox(height: xxTinySpacing),
          Text(StringConstants.kTime,
              style: Theme.of(context)
                  .textTheme
                  .xSmall
                  .copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: xxxTinierSpacing),
          Visibility(
            visible: addIncidentMap['reporteddatetime'] == null ||
                addIncidentMap['reporteddatetime'].toString().isEmpty,
            replacement: TextFieldWidget(
                value: (addIncidentMap['reporteddatetime'] == null ||
                        addIncidentMap['reporteddatetime'].isEmpty)
                    ? ""
                    : addIncidentMap['reporteddatetime']
                        .toString()
                        .substring(12, 19),
                readOnly: true,
                onTextFieldChanged: (String textField) {}),
            child: TimePickerTextField(
              hintText: StringConstants.kSelectTime,
              onTimeChanged: (String time) {
                addIncidentMap['reporteddatetime'] = '$reportedDate $time';
              },
            ),
          ),
          const SizedBox(height: xxTinySpacing)
        ]));
  }
}
