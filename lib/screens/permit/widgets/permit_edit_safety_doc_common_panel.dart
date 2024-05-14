import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/permit/fetch_data_for_open_permit_model.dart';
import 'package:toolkit/screens/permit/widgets/select_location_dropdown_widget.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/generic_text_field.dart';

class PermitEditSafetyDocCommonPanel extends StatelessWidget {
  final Map editSafetyDocumentMap;
  final FetchDataForOpenPermitModel fetchDataForOpenPermitModel;

  const PermitEditSafetyDocCommonPanel(
      {super.key,
      required this.editSafetyDocumentMap,
      required this.fetchDataForOpenPermitModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(StringConstants.kPermitPlannedLocation,
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: xxxTinierSpacing),
        PlannedLocationDropdown(
          fetchDataForOpenPermitModel: fetchDataForOpenPermitModel,
          onLocationSelected: (List<String>? selectedLocation) {
            editSafetyDocumentMap['location'] = selectedLocation
                .toString()
                .replaceAll('[', '')
                .replaceAll(']', '')
                .replaceAll(' ', '');
          },
        ),
        const SizedBox(height: xxTinySpacing),
        Text(StringConstants.kPermitEquipmentIdentification,
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: xxxTinierSpacing),
        TextFieldWidget(
            value: fetchDataForOpenPermitModel.data?.methodstatement ?? '',
            onTextFieldChanged: (String textValue) {
              editSafetyDocumentMap['methodstmt'] = textValue;
            }),
        const SizedBox(height: tiniestSpacing),
        Text(StringConstants.kPermitCircuitNumber,
            style: Theme.of(context).textTheme.xxSmall),
        const SizedBox(height: xxTinySpacing),
        Text(StringConstants.kPermitWorkDescription,
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: xxxTinierSpacing),
        TextFieldWidget(
            value: fetchDataForOpenPermitModel.data?.description ?? '',
            onTextFieldChanged: (String textValue) {
              editSafetyDocumentMap['description'] = textValue;
            }),
        const SizedBox(height: xxTinierSpacing)
      ],
    );
  }
}
