import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../../../configs/app_spacing.dart';
import '../../../../widgets/generic_text_field.dart';

class ExpenseAddItemHotelLayout extends StatelessWidget {
  const ExpenseAddItemHotelLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Name of hotel :',
              style: Theme.of(context)
                  .textTheme
                  .xSmall
                  .copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: xxxTinierSpacing),
          TextFieldWidget(
              value: '',
              maxLength: 100,
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.text,
              onTextFieldChanged: (String textField) {
                // manageExpenseMap['location'] = textField;
              }),
          const SizedBox(height: xxTinySpacing),
          RichText(
            text: TextSpan(
              text: StringConstants.kTypeOfRoom,
              style: Theme.of(context)
                  .textTheme
                  .xSmall
                  .copyWith(fontWeight: FontWeight.w600),
              children: <TextSpan>[
                TextSpan(
                    text: '* ',
                    style: Theme.of(context).textTheme.xSmall.copyWith(
                        fontWeight: FontWeight.w600, color: AppColor.errorRed)),
                TextSpan(
                  text: ' :',
                  style: Theme.of(context)
                      .textTheme
                      .xSmall
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          const SizedBox(height: xxxTinierSpacing),
        ],
      ),
    );
  }
}
