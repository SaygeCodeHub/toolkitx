import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/incident/widgets/date_picker.dart';
import 'package:toolkit/screens/incident/widgets/time_picker.dart';
import 'package:toolkit/screens/profile/widgets/signature.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/generic_text_field.dart';
import 'package:toolkit/widgets/primary_button.dart';

class PermitSignAsCpScreen extends StatelessWidget {
  static const routeName = 'PermitSignAsCpScreen';
  final Map permitSignAsCpMap = {};

  PermitSignAsCpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kSignAsCp),
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
                      onPressed: () {},
                      textValue: StringConstants.kSignAsCpCap))
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
                      TextFieldWidget(
                          onTextFieldChanged: (String textValue) {}),
                      const SizedBox(height: xxTinySpacing),
                      Text(StringConstants.kAuthNumber,
                          style: Theme.of(context)
                              .textTheme
                              .xSmall
                              .copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: xxxTinierSpacing),
                      TextFieldWidget(
                          onTextFieldChanged: (String textValue) {}),
                      const SizedBox(height: xxTinySpacing),
                      Text(StringConstants.kCompanyName,
                          style: Theme.of(context)
                              .textTheme
                              .xSmall
                              .copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: xxxTinierSpacing),
                      TextFieldWidget(
                          onTextFieldChanged: (String textValue) {}),
                      const SizedBox(height: xxTinySpacing),
                      Text(StringConstants.kEmailAndPhoneNo,
                          style: Theme.of(context)
                              .textTheme
                              .xSmall
                              .copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: xxxTinierSpacing),
                      TextFieldWidget(
                          onTextFieldChanged: (String textValue) {}),
                      const SizedBox(height: xxTinySpacing),
                      Text(StringConstants.kDate,
                          style: Theme.of(context)
                              .textTheme
                              .xSmall
                              .copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: xxxTinierSpacing),
                      DatePickerTextField(onDateChanged: (String textValue) {}),
                      const SizedBox(height: xxTinySpacing),
                      Text(StringConstants.kTime,
                          style: Theme.of(context)
                              .textTheme
                              .xSmall
                              .copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: xxxTinierSpacing),
                      TimePickerTextField(
                        onTimeChanged: (String date) {},
                      ),
                      const SizedBox(height: xxTinySpacing),
                      const SignaturePad(map: {}, mapKey: ''),
                      const SizedBox(height: xxTinySpacing)
                    ]))));
  }
}
