import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/qualityManagement/widgets/status_dropdown_widget.dart';
import 'package:toolkit/widgets/generic_text_field.dart';

import '../../configs/app_color.dart';
import '../../data/models/qualityManagement/fetch_qm_details_model.dart';
import '../../screens/incident/widgets/date_picker.dart';

class StatusWidgets {
  Widget renderWidgets(
      FetchQualityManagementDetailsModel fetchQualityManagementDetailsModel,
      BuildContext context,
      Map qmCommentsMap) {
    switch (fetchQualityManagementDetailsModel.data.nextStatus) {
      case '0':
        if (fetchQualityManagementDetailsModel.data.isShowAdditionalInfo ==
            '1') {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Immediate Action Taken',
                  style: Theme.of(context).textTheme.small.copyWith(
                      color: AppColor.black, fontWeight: FontWeight.w500)),
              const SizedBox(height: xxTinierSpacing),
              TextFieldWidget(
                  maxLines: 5,
                  onTextFieldChanged: (String value) {
                    qmCommentsMap['immediateaction'] = value;
                  }),
              const SizedBox(height: xxTinierSpacing),
              Text('Root Cause Analysis',
                  style: Theme.of(context).textTheme.small.copyWith(
                      color: AppColor.black, fontWeight: FontWeight.w500)),
              const SizedBox(height: xxTinierSpacing),
              TextFieldWidget(
                  maxLines: 5,
                  onTextFieldChanged: (String value) {
                    qmCommentsMap['rootcause'] = value;
                  }),
              const SizedBox(height: xxTinierSpacing)
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      case '1':
        if (fetchQualityManagementDetailsModel.data.isShowAdditionalInfo ==
            '1') {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Proposal Description',
                  style: Theme.of(context).textTheme.small.copyWith(
                      color: AppColor.black, fontWeight: FontWeight.w500)),
              const SizedBox(height: xxTinierSpacing),
              TextFieldWidget(
                  maxLines: 5,
                  onTextFieldChanged: (String value) {
                    qmCommentsMap['proposaldescription'] = value;
                  }),
              const SizedBox(height: xxTinierSpacing),
              Text('Disposition',
                  style: Theme.of(context).textTheme.small.copyWith(
                      color: AppColor.black, fontWeight: FontWeight.w500)),
              const SizedBox(height: xxTinierSpacing),
              TextFieldWidget(
                  maxLines: 5,
                  onTextFieldChanged: (String value) {
                    qmCommentsMap['disposition'] = value;
                  }),
              const SizedBox(height: xxTinierSpacing)
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      case '2':
        if (fetchQualityManagementDetailsModel.data.isShowAdditionalInfo ==
            '1') {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Corrective Action ',
                  style: Theme.of(context).textTheme.small.copyWith(
                      color: AppColor.black, fontWeight: FontWeight.w500)),
              const SizedBox(height: xxTinierSpacing),
              TextFieldWidget(
                  maxLines: 5,
                  onTextFieldChanged: (String value) {
                    qmCommentsMap['correctiveaction'] = value;
                  }),
              const SizedBox(height: xxTinierSpacing)
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      case '4':
        if (fetchQualityManagementDetailsModel.data.isShowAdditionalInfo ==
            '1') {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Corrective Measures Implemented By',
                  style: Theme.of(context).textTheme.small.copyWith(
                      color: AppColor.black, fontWeight: FontWeight.w500)),
              const SizedBox(height: xxTinierSpacing),
              TextFieldWidget(onTextFieldChanged: (String value) {
                qmCommentsMap['correctivemeasuresby'] = value;
              }),
              const SizedBox(height: xxTinierSpacing),
              Text('Corrective Action Taken Completion Date',
                  style: Theme.of(context).textTheme.small.copyWith(
                      color: AppColor.black, fontWeight: FontWeight.w500)),
              const SizedBox(height: xxTinierSpacing),
              DatePickerTextField(onDateChanged: (String date) {
                qmCommentsMap['correctivecompletiondate'] = date;
              }),
              const SizedBox(height: xxTinierSpacing),
              Text('Procedure/Drawing Modification?',
                  style: Theme.of(context).textTheme.small.copyWith(
                      color: AppColor.black, fontWeight: FontWeight.w500)),
              const SizedBox(height: xxTinierSpacing),
              StatusDropdownWidget(onStatusChanged: (String selectedValue) {
                qmCommentsMap['proceduremodification'] = selectedValue;
              })
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      case '7':
        if (fetchQualityManagementDetailsModel.data.isShowAdditionalInfo ==
            '1') {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Reinspection By',
                    style: Theme.of(context).textTheme.small.copyWith(
                        color: AppColor.black, fontWeight: FontWeight.w500)),
                const SizedBox(height: xxTinierSpacing),
                TextFieldWidget(onTextFieldChanged: (String value) {
                  qmCommentsMap['reinspectionby'] = value;
                }),
                const SizedBox(height: xxTinierSpacing),
                Text('Reinspection Date',
                    style: Theme.of(context).textTheme.small.copyWith(
                        color: AppColor.black, fontWeight: FontWeight.w500)),
                const SizedBox(height: xxTinierSpacing),
                DatePickerTextField(onDateChanged: (String date) {
                  qmCommentsMap['reinspectiondate'] = date;
                }),
                const SizedBox(height: xxTinierSpacing),
                Text('Reinspection Result',
                    style: Theme.of(context).textTheme.small.copyWith(
                        color: AppColor.black, fontWeight: FontWeight.w500)),
                const SizedBox(height: xxTinierSpacing),
                TextFieldWidget(
                    maxLines: 5,
                    onTextFieldChanged: (String value) {
                      qmCommentsMap['reinspectionresult'] = value;
                    }),
                const SizedBox(height: xxTinierSpacing)
              ]);
        } else {
          return const SizedBox.shrink();
        }
      default:
        return const Text('');
    }
  }
}
