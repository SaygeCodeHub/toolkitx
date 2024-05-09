import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/primary_button.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/generic_text_field.dart';

class PreparePermitScreen extends StatelessWidget {
  static const routeName = 'PreparePermitScreen';

  const PreparePermitScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GenericAppBar(title: StringConstants.kPreparePermit),
      body: Padding(
          padding: const EdgeInsets.only(
              left: leftRightMargin,
              right: leftRightMargin,
              top: xxTinierSpacing),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(StringConstants.kPermitNo,
                style: Theme.of(context).textTheme.xSmall.copyWith(
                    fontWeight: FontWeight.w500, color: AppColor.black)),
            const SizedBox(height: tiniestSpacing),
            TextFieldWidget(
                value: '', readOnly: true, onTextFieldChanged: (textField) {}),
            const SizedBox(height: xxTinierSpacing),
            Text(StringConstants.kStatus,
                style: Theme.of(context).textTheme.xSmall.copyWith(
                    fontWeight: FontWeight.w500, color: AppColor.black)),
            const SizedBox(height: tiniestSpacing),
            TextFieldWidget(
                value: '', readOnly: true, onTextFieldChanged: (textField) {}),
            const SizedBox(height: xxTinierSpacing),
            Text(StringConstants.kControlPerson,
                style: Theme.of(context).textTheme.xSmall.copyWith(
                    fontWeight: FontWeight.w500, color: AppColor.black)),
            const SizedBox(height: tiniestSpacing),
            TextFieldWidget(onTextFieldChanged: (textField) {}),
            const SizedBox(height: xxTinierSpacing),
          ])),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(xxTinierSpacing),
        child: PrimaryButton(
            onPressed: () {}, textValue: StringConstants.kMarkAsPrepared),
      ),
    );
  }
}
