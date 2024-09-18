import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/qualityManagement/fetch_qm_details_model.dart';
import '../../../widgets/generic_text_field.dart';
import '../../incident/widgets/date_picker.dart';

class ReInspectionWidget extends StatelessWidget {
  final FetchQualityManagementDetailsModel fetchQualityManagementDetailsModel;
  final Map qmCommentsMap;

  const ReInspectionWidget(
      {super.key,
      required this.fetchQualityManagementDetailsModel,
      required this.qmCommentsMap});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Reinspection By',
          style: Theme.of(context)
              .textTheme
              .small
              .copyWith(color: AppColor.black, fontWeight: FontWeight.w500)),
      const SizedBox(height: xxTinierSpacing),
      TextFieldWidget(onTextFieldChanged: (String value) {
        qmCommentsMap['reinspectionby'] = value;
      }),
      const SizedBox(height: tinySpacing),
      Text('Reinspection Date',
          style: Theme.of(context)
              .textTheme
              .small
              .copyWith(color: AppColor.black, fontWeight: FontWeight.w500)),
      const SizedBox(height: xxTinierSpacing),
      DatePickerTextField(onDateChanged: (String date) {
        qmCommentsMap['reinspectiondate'] = date;
      }),
      const SizedBox(height: tinySpacing),
      Text('Reinspection Result',
          style: Theme.of(context)
              .textTheme
              .small
              .copyWith(color: AppColor.black, fontWeight: FontWeight.w500)),
      const SizedBox(height: xxTinierSpacing),
      TextFieldWidget(
          maxLines: 5,
          onTextFieldChanged: (String value) {
            qmCommentsMap['reinspectionresult'] = value;
          }),
      const SizedBox(height: tinySpacing)
    ]);
  }
}
