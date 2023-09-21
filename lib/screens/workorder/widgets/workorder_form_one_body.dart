import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_spacing.dart';
import '../../../data/models/workorder/fetch_workorder_master_model.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/generic_text_field.dart';
import '../../incident/widgets/date_picker.dart';
import '../../incident/widgets/time_picker.dart';
import 'workorder_company_list_tile.dart';
import 'workorder_location_list_tile.dart';

class WorkOrderFormOneBody extends StatelessWidget {
  final List<List<WorkOrderMasterDatum>> data;
  final Map workOrderDetailsMap;

  const WorkOrderFormOneBody(
      {Key? key, required this.data, required this.workOrderDetailsMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin, right: leftRightMargin),
        child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CompanyListTile(
                    data: data, workOrderDetailsMap: workOrderDetailsMap),
                LocationListTile(
                    data: data, workOrderDetailsMap: workOrderDetailsMap),
                const SizedBox(height: xxxTinierSpacing),
                Text(DatabaseUtil.getText('OtherLocation'),
                    style: Theme.of(context)
                        .textTheme
                        .xSmall
                        .copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: xxxTinierSpacing),
                TextFieldWidget(
                    maxLength: 70,
                    value: workOrderDetailsMap['otherlocation'] ?? '',
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.text,
                    onTextFieldChanged: (String textField) {
                      workOrderDetailsMap['otherlocation'] = textField;
                    }),
                const SizedBox(height: xxTinySpacing),
                Text(DatabaseUtil.getText('PlannedStartDate'),
                    style: Theme.of(context)
                        .textTheme
                        .xSmall
                        .copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: xxxTinierSpacing),
                DatePickerTextField(
                  editDate: workOrderDetailsMap['plannedstartdate'] ?? '',
                  hintText: StringConstants.kSelectDate,
                  onDateChanged: (String date) {
                    workOrderDetailsMap['plannedstartdate'] = date;
                  },
                ),
                const SizedBox(height: xxTinySpacing),
                Text(DatabaseUtil.getText('PlannedStartTime'),
                    style: Theme.of(context)
                        .textTheme
                        .xSmall
                        .copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: xxxTinierSpacing),
                TimePickerTextField(
                  editTime: workOrderDetailsMap['plannedstarttime'] ?? '',
                  hintText: StringConstants.kSelectTime,
                  onTimeChanged: (String time) {
                    workOrderDetailsMap['plannedstarttime'] = time;
                  },
                ),
                const SizedBox(height: xxTinySpacing),
                Text(DatabaseUtil.getText('PlannedEndDate'),
                    style: Theme.of(context)
                        .textTheme
                        .xSmall
                        .copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: xxxTinierSpacing),
                DatePickerTextField(
                  editDate: workOrderDetailsMap['plannedfinishdate'] ?? '',
                  hintText: StringConstants.kSelectDate,
                  onDateChanged: (String date) {
                    workOrderDetailsMap['plannedfinishdate'] = date;
                  },
                ),
                const SizedBox(height: xxTinySpacing),
                Text(DatabaseUtil.getText('PlannedEndTime'),
                    style: Theme.of(context)
                        .textTheme
                        .xSmall
                        .copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: xxxTinierSpacing),
                TimePickerTextField(
                  editTime: workOrderDetailsMap['plannedfinishtime'] ?? '',
                  hintText: StringConstants.kSelectTime,
                  onTimeChanged: (String time) {
                    workOrderDetailsMap['plannedfinishtime'] = time;
                  },
                ),
              ],
            )));
  }
}
