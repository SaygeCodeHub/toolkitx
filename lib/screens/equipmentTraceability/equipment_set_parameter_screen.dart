import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_card.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/primary_button.dart';

import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import '../../widgets/generic_text_field.dart';

class EquipmentSetParameterScreen extends StatelessWidget {
  const EquipmentSetParameterScreen({super.key});

  static const routeName = 'EquipmentSetParameterScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GenericAppBar(
        title:'Set Parameter',
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing),
        child: Column(
          children: [
            CustomCard(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Mileage (None)',
                        style: Theme.of(context).textTheme.small.copyWith(
                            fontWeight: FontWeight.w500, color: AppColor.black)),
                    const SizedBox(height: tiniestSpacing),
                    TextFieldWidget(
                      textInputType: TextInputType.number,
                      hintText: "enter mileage here",
                      onTextFieldChanged: (textField) {
                      },
                    ),

                  ],
                ),
              ),
            ),
            const SizedBox(height: tiniestSpacing),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
      padding: const EdgeInsets.all(xxTinierSpacing),
        child: PrimaryButton(
          onPressed: (){

          }, textValue: StringConstants.kSubmit,
        ),
      ),
    );
  }
}
