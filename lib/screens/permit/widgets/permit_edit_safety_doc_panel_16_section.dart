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
        Text(StringConstants.kPermitPrecautions,
            style: Theme.of(context)
                .textTheme
                .small
                .copyWith(fontWeight: FontWeight.w500, color: AppColor.black)),
        const SizedBox(height: xxxTinierSpacing),
        Text(StringConstants.kPermitLimitOfWork,
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: xxxTinierSpacing),
        TextFieldWidget(
            value: fetchDataForOpenPermitModel.data?.ptwIsolation ?? '',
            onTextFieldChanged: (String textValue) {
              editSafetyDocumentMap['ptw_isolation'] = textValue;
            }),
        const SizedBox(height: xxTinySpacing),
        Text(StringConstants.kPermitLimitOfWorkArea,
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: xxxTinierSpacing),
        TextFieldWidget(
            value: fetchDataForOpenPermitModel.data?.ptwCircuit ?? '',
            onTextFieldChanged: (String textValue) {
              editSafetyDocumentMap['ptw_circuit'] = textValue;
            }),
        const SizedBox(height: xxTinySpacing),
        Text(StringConstants.kPermitHazards,
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: xxxTinierSpacing),
        TextFieldWidget(
            value: fetchDataForOpenPermitModel.data?.ptwSafety ?? '',
            onTextFieldChanged: (String textValue) {
              editSafetyDocumentMap['ptw_safety'] = textValue;
            }),
        const SizedBox(height: xxTinySpacing)
      ],
    );
  }
}
