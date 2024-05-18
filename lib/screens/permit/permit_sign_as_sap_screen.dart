import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/permit/permit_bloc.dart';
import 'package:toolkit/blocs/permit/permit_events.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/incident/widgets/date_picker.dart';
import 'package:toolkit/screens/incident/widgets/time_picker.dart';
import 'package:toolkit/screens/profile/widgets/signature.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/offlinePermit/save_offline_data.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/generic_text_field.dart';
import 'package:toolkit/widgets/primary_button.dart';

class PermitSignAsSapScreen extends StatelessWidget {
  static const routeName = 'PermitSignAsSapScreen';
  final Map permitSignAsSapMap;

  const PermitSignAsSapScreen({super.key, required this.permitSignAsSapMap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kSignAsSap),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(xxxTinierSpacing),
            child: Row(children: [
              Expanded(
                  child: PrimaryButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      textValue: StringConstants.kBack)),
              const SizedBox(width: xxTinierSpacing),
              Expanded(
                  child: PrimaryButton(
                      onPressed: () {
                        SaveOfflineData().saveData(
                            context.read<PermitBloc>().statusId,
                            permitSignAsSapMap,
                            context);
                      },
                      textValue: StringConstants.kSignAsSapCap))
            ])),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.only(
                    left: leftRightMargin,
                    right: leftRightMargin,
                    top: topBottomPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(StringConstants.kName,
                        style: Theme.of(context)
                            .textTheme
                            .xSmall
                            .copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: xxxTinierSpacing),
                    TextFieldWidget(onTextFieldChanged: (String textValue) {
                      permitSignAsSapMap['user_name'] = textValue;
                    }),
                    const SizedBox(height: xxTinySpacing),
                    Text(StringConstants.kEmailAndPhoneNo,
                        style: Theme.of(context)
                            .textTheme
                            .xSmall
                            .copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: xxxTinierSpacing),
                    TextFieldWidget(onTextFieldChanged: (String textValue) {
                      permitSignAsSapMap['user_email'] = textValue;
                    }),
                    const SizedBox(height: xxTinySpacing),
                    Text(StringConstants.kDate,
                        style: Theme.of(context)
                            .textTheme
                            .xSmall
                            .copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: xxxTinierSpacing),
                    DatePickerTextField(onDateChanged: (String date) {
                      permitSignAsSapMap['date'] = date;
                    }),
                    const SizedBox(height: xxTinySpacing),
                    Text(StringConstants.kTime,
                        style: Theme.of(context)
                            .textTheme
                            .xSmall
                            .copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: xxxTinierSpacing),
                    TimePickerTextField(onTimeChanged: (String time) {
                      permitSignAsSapMap['time'] = time;
                    }),
                    const SizedBox(height: xxTinySpacing),
                    SignaturePad(map: permitSignAsSapMap, mapKey: 'user_sign'),
                    const SizedBox(height: xxTinySpacing),
                  ],
                ))));
  }
}
