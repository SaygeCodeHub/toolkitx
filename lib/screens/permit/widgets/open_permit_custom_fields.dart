import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/enums/permit_custom_fields_title_enum.dart';

import '../../../configs/app_spacing.dart';
import '../../../widgets/generic_text_field.dart';

class OpenPermitCustomFields extends StatelessWidget {
  final Map openPermitMap;

  const OpenPermitCustomFields({super.key, required this.openPermitMap});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).removePadding(removeTop: true),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: PermitCustomFieldsTitleEnum.values.length,
        itemBuilder: (context, index) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(PermitCustomFieldsTitleEnum.values[index].type,
                    style: Theme.of(context)
                        .textTheme
                        .xSmall
                        .copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: xxxTinierSpacing),
                TextFieldWidget(
                    textInputAction: TextInputAction.next,
                    maxLength: 50,
                    hintText: PermitCustomFieldsTitleEnum.values[index].type,
                    onTextFieldChanged: (String textField) {
                      openPermitMap['customfields'][index]['answer'] =
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
