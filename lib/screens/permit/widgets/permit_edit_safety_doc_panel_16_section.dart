import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/permit/fetch_data_for_open_permit_model.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/generic_text_field.dart';

class PermitEditSafetyDoc16Section extends StatelessWidget {
  final Map editSafetyDocumentMap;
  final FetchDataForOpenPermitModel fetchDataForOpenPermitModel;

  const PermitEditSafetyDoc16Section(
      {super.key,
      required this.editSafetyDocumentMap,
      required this.fetchDataForOpenPermitModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(StringConstants.kPermitLimitOfWork,
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: xxxTinierSpacing),
        TextFieldWidget(
            value: fetchDataForOpenPermitModel.data?.lwcAccessto ?? '',
            onTextFieldChanged: (String textValue) {
              editSafetyDocumentMap['lwc_accessto'] = textValue;
            }),
        const SizedBox(height: xxTinySpacing),
        Text(StringConstants.kPermitLimitOfWorkArea,
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: xxxTinierSpacing),
        TextFieldWidget(
            value: fetchDataForOpenPermitModel.data?.lwcEnvironment ?? '',
            onTextFieldChanged: (String textValue) {
              editSafetyDocumentMap['lwc_environment'] = textValue;
            }),
        const SizedBox(height: xxTinySpacing),
        Text(StringConstants.kPermitHazards,
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: xxxTinierSpacing),
        TextFieldWidget(
            value: fetchDataForOpenPermitModel.data?.lwcPrecautions ?? '',
            onTextFieldChanged: (String textValue) {
              editSafetyDocumentMap['lwc_precautions'] = textValue;
            }),
        const SizedBox(height: xxTinySpacing)
      ],
    );
  }
}
