import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:toolkit/blocs/permit/permit_bloc.dart';
import 'package:toolkit/blocs/permit/permit_events.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/permit/permit_sign_as_sap_screen.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/global.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';

import '../../../configs/app_spacing.dart';
import '../../../data/models/permit/open_permit_details_model.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/generic_text_field.dart';
import '../../../widgets/primary_button.dart';
import '../../incident/widgets/date_picker.dart';
import '../../incident/widgets/time_picker.dart';
import 'open_permit_custom_fields.dart';

class OpenPermitBody extends StatelessWidget {
  final Map openPermitMap;
  final GetOpenPermitData getOpenPermitData;

  const OpenPermitBody({
    super.key,
    required this.openPermitMap,
    required this.getOpenPermitData,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
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
                    value: getOpenPermitData.permitName!,
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
                    value: getOpenPermitData.permitStatus!,
                    readOnly: true,
                    hintText: DatabaseUtil.getText('Status'),
                    onTextFieldChanged: (String textField) {}),
                const SizedBox(height: xxTinySpacing),
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
                      openPermitMap['date'] = date;
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
                      openPermitMap['time'] = time;
                    }),
                const SizedBox(height: xxTinySpacing),
                Column(children: [
                  OpenPermitCustomFields(openPermitMap: openPermitMap),
                  const SizedBox(height: xxTinySpacing)
                ]),
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
                      openPermitMap['details'] = textField;
                    }),
                const SizedBox(height: xxTinySpacing),
                PrimaryButton(
                    onPressed: () {
                      if (isNetworkEstablished) {
                        context
                            .read<PermitBloc>()
                            .add(OpenPermit(openPermitMap));
                      } else {
                        if (openPermitMap['date'] == null ||
                            openPermitMap['date'] == '') {
                          showCustomSnackBar(
                              context, StringConstants.kPleaseSelectDate, '');
                        } else if (openPermitMap['time'] == null ||
                            openPermitMap['time'] == '') {
                          showCustomSnackBar(
                              context, StringConstants.kPleaseSelectTime, '');
                        } else {
                          Navigator.pushNamed(
                              context, PermitSignAsSapScreen.routeName,
                              arguments: {
                                'permitId': openPermitMap['permitId'],
                                'date': openPermitMap['date'],
                                'time': openPermitMap['time'],
                                'customfields': openPermitMap['customfields']
                              });
                        }
                      }
                    },
                    textValue: StringConstants.kISSUEPERMIT)
              ],
            )));
  }
}
