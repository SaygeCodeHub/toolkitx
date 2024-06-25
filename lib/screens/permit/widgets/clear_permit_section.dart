import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/permit/fetch_clear_permit_details_model.dart';
import 'package:toolkit/screens/permit/widgets/clear_permit_custom_fields.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/generic_text_field.dart';

class ClearPermitSection extends StatelessWidget {
  final Map clearPermitMap;
  final ClearPermitData data;

  const ClearPermitSection(
      {super.key, required this.clearPermitMap, required this.data});

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
                    value: data.permitName,
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
                    value: data.permitStatus,
                    readOnly: true,
                    hintText: DatabaseUtil.getText('Status'),
                    onTextFieldChanged: (String textField) {}),
                const SizedBox(height: xxTinySpacing),
                Column(children: [
                  ClearPermitCustomFields(clearPermitMap: clearPermitMap),
                  const SizedBox(height: xxTinySpacing)
                ]),
                const SizedBox(height: xxTinySpacing),
              ],
            )));
  }
}
