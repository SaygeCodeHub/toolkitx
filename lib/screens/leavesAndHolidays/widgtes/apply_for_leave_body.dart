import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/leavesAndHolidays/fetch_leaves_and_holidays_master_model.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/generic_text_field.dart';
import '../../incident/widgets/date_picker.dart';
import 'select_leave_type_expansion_tile.dart';

class ApplyForLeaveBody extends StatelessWidget {
  final Map applyForLeaveMap;
  final List<LeavesMasterDatum> data;

  const ApplyForLeaveBody(
      {Key? key, required this.applyForLeaveMap, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: leftRightMargin, right: leftRightMargin, top: xxTinierSpacing),
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
                applyForLeaveMap['startdate'] = date;
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
                applyForLeaveMap['enddate'] = date;
              },
            ),
            const SizedBox(height: xxTinySpacing),
            Text(DatabaseUtil.getText('SelectLeaveType'),
                style: Theme.of(context)
                    .textTheme
                    .xSmall
                    .copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: xxxTinierSpacing),
            SelectLeaveTypeExpansionTile(
                data: data, applyForLeaveMap: applyForLeaveMap),
            const SizedBox(height: xxTinySpacing),
            Text(DatabaseUtil.getText('Reason'),
                style: Theme.of(context)
                    .textTheme
                    .xSmall
                    .copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: xxxTinierSpacing),
            TextFieldWidget(
                maxLength: 250,
                maxLines: 3,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.text,
                onTextFieldChanged: (String textField) {
                  applyForLeaveMap['reason'] = textField;
                }),
            const SizedBox(height: xxTinySpacing),
            Text(DatabaseUtil.getText('EmergencyContact'),
                style: Theme.of(context)
                    .textTheme
                    .xSmall
                    .copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: xxxTinierSpacing),
            TextFieldWidget(
                maxLength: 10,
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.number,
                onTextFieldChanged: (String textField) {
                  applyForLeaveMap['emergencycontact'] = textField;
                }),
          ],
        ),
      ),
    );
  }
}
