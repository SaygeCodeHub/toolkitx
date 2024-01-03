import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';

import '../../../blocs/permit/permit_bloc.dart';
import '../../../blocs/permit/permit_events.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/permit/close_permit_details_model.dart';
import '../../../widgets/generic_text_field.dart';
import '../../../widgets/primary_button.dart';
import '../../incident/widgets/date_picker.dart';
import '../../incident/widgets/time_picker.dart';

class ClosePermitBody extends StatelessWidget {
  final Map closePermitMap;
  final GetClosePermitData getClosePermitData;

  const ClosePermitBody(
      {super.key,
      required this.closePermitMap,
      required this.getClosePermitData});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: topBottomPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(StringConstants.kPermitNo,
                    style: Theme.of(context)
                        .textTheme
                        .xSmall
                        .copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: xxxTinierSpacing),
                TextFieldWidget(
                    value: getClosePermitData.permitName!,
                    readOnly: true,
                    hintText: StringConstants.kPermitNo,
                    onTextFieldChanged: (String textField) {}),
                const SizedBox(height: xxTinySpacing),
                Text(DatabaseUtil.getText('Status'),
                    style: Theme.of(context)
                        .textTheme
                        .xSmall
                        .copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: xxxTinierSpacing),
                TextFieldWidget(
                    value: getClosePermitData.permitStatus!,
                    readOnly: true,
                    hintText: DatabaseUtil.getText('Status'),
                    onTextFieldChanged: (String textField) {}),
                const SizedBox(height: xxTinySpacing),
                Visibility(
                    visible: getClosePermitData.panelSaint == '1',
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(StringConstants.kControlPerson,
                              style: Theme.of(context)
                                  .textTheme
                                  .xSmall
                                  .copyWith(fontWeight: FontWeight.w600)),
                          const SizedBox(height: xxxTinierSpacing),
                          TextFieldWidget(
                              maxLength: 100,
                              hintText: StringConstants.kControlPerson,
                              onTextFieldChanged: (String textField) {
                                closePermitMap['controlPerson'] = textField;
                              }),
                          const SizedBox(height: xxTinySpacing)
                        ])),
                Text(DatabaseUtil.getText('Date'),
                    style: Theme.of(context)
                        .textTheme
                        .xSmall
                        .copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: xxxTinierSpacing),
                DatePickerTextField(
                    editDate: DateFormat('dd MMM yyyy').format(DateTime.now()),
                    hintText: DatabaseUtil.getText('Date'),
                    onDateChanged: (String date) {
                      closePermitMap['date'] = date;
                    }),
                const SizedBox(height: xxTinySpacing),
                Text(DatabaseUtil.getText('Time'),
                    style: Theme.of(context)
                        .textTheme
                        .xSmall
                        .copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: xxxTinierSpacing),
                TimePickerTextField(
                    hintText: DatabaseUtil.getText('Time'),
                    onTimeChanged: (String time) {
                      closePermitMap['time'] = time;
                    }),
                const SizedBox(height: xxTinySpacing),
                Visibility(
                    visible: getClosePermitData.panelSaint == '1',
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(DatabaseUtil.getText('Comments'),
                              style: Theme.of(context)
                                  .textTheme
                                  .xSmall
                                  .copyWith(fontWeight: FontWeight.w600)),
                          const SizedBox(height: xxxTinierSpacing),
                          TextFieldWidget(
                              maxLength: 255,
                              hintText: DatabaseUtil.getText('Comments'),
                              onTextFieldChanged: (String textField) {
                                closePermitMap['details'] = textField;
                              }),
                          const SizedBox(height: xxTinySpacing)
                        ])),
                PrimaryButton(
                    onPressed: () {
                      context
                          .read<PermitBloc>()
                          .add(ClosePermit(closePermitMap));
                    },
                    textValue: StringConstants.kCLOSEPERMIT)
              ],
            )));
  }
}
