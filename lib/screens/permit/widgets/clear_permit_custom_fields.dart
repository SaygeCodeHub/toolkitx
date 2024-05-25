import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/widgets/generic_text_field.dart';

import '../../../data/enums/clear_permit_custom_fields_enum.dart';

class ClearPermitCustomFields extends StatelessWidget {
  final Map clearPermitMap;

  const ClearPermitCustomFields({super.key, required this.clearPermitMap});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).removePadding(removeTop: true),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: ClearPermitCustomFieldsEnum.values.length,
        itemBuilder: (context, index) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(ClearPermitCustomFieldsEnum.values[index].type,
                    style: Theme.of(context)
                        .textTheme
                        .xSmall
                        .copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: xxxTinierSpacing),
                TextFieldWidget(
                    value: clearPermitMap['customfields'][index]['answer'],
                    textInputAction: TextInputAction.next,
                    maxLength: 50,
                    onTextFieldChanged: (String textField) {
                      clearPermitMap['customfields'][index]['answer'] =
                          textField;
                    })
              ]);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: xxTinySpacing);
        },
      ),
    );
  }
}
