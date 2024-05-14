import 'package:flutter/material.dart';
import 'package:toolkit/blocs/permit/permit_events.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/permit/fetch_data_for_open_permit_model.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/generic_text_field.dart';

class PermitEditSafetyDocPanel12Section extends StatelessWidget {
  final Map editSafetyDocumentMap;
  final FetchDataForOpenPermitModel fetchDataForOpenPermitModel;

  const PermitEditSafetyDocPanel12Section(
      {super.key,
      required this.editSafetyDocumentMap,
      required this.fetchDataForOpenPermitModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(StringConstants.kPermitIsolation,
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
        Text(StringConstants.kPermitEarthingDevice,
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
        Text(StringConstants.kPermitAction,
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
        const SizedBox(height: xxTinySpacing),
        Text(StringConstants.kPermitPrecautionsTaken,
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: xxxTinierSpacing),
        TextFieldWidget(
            value: fetchDataForOpenPermitModel.data?.ptwPrecautions ?? '',
            onTextFieldChanged: (String textValue) {
              editSafetyDocumentMap['ptw_precautions'] = textValue;
            }),
        const SizedBox(height: xxTinySpacing),
        Text(StringConstants.kPermitPrimaryProcedure,
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: xxxTinierSpacing),
        TextFieldWidget(
            value: fetchDataForOpenPermitModel.data?.ptwPrecautions2 ?? '',
            onTextFieldChanged: (String textValue) {
              editSafetyDocumentMap['ptw_precautions2'] = textValue;
            }),
        const SizedBox(height: xxTinySpacing),
      ],
    );
  }
}
