import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/permit/fetch_data_for_open_permit_model.dart';
import 'package:toolkit/screens/permit/widgets/select_location_dropdown_widget.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/generic_text_field.dart';

import '../../configs/app_color.dart';

class EditSafetyDocumentPlotUtil {
  Widget renderUI(
      String question,
      BuildContext context,
      Map editSafetyDocumentMap,
      FetchDataForOpenPermitModel fetchDataForOpenPermitModel) {
    switch (question) {
      case StringConstants.kPermitFirstQuestion:
        PlannedLocationDropdown.selectedLocation =
            fetchDataForOpenPermitModel.data?.location ?? '';
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(StringConstants.kPermitIdentification,
                style: Theme.of(context).textTheme.small.copyWith(
                    fontWeight: FontWeight.w500, color: AppColor.black)),
            const SizedBox(height: xxxTinierSpacing),
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
      case StringConstants.kPermitSecondQuestion:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(StringConstants.kPermitPrecautions,
                style: Theme.of(context).textTheme.small.copyWith(
                    fontWeight: FontWeight.w500, color: AppColor.black)),
            const SizedBox(height: xxxTinierSpacing),
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
            Text(StringConstants.kPermitPrimaryEarthing,
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
      default:
        return const SizedBox.shrink();
    }
  }
}
