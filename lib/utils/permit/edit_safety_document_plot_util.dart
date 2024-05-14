import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/permit/fetch_data_for_open_permit_model.dart';
import 'package:toolkit/screens/permit/widgets/permit_edit_safety_doc_common_panel.dart';
import 'package:toolkit/screens/permit/widgets/permit_edit_safety_doc_panel_12_section.dart';
import 'package:toolkit/screens/permit/widgets/permit_edit_safety_doc_panel_15_section.dart';
import 'package:toolkit/screens/permit/widgets/permit_edit_safety_doc_panel_16_section.dart';
import 'package:toolkit/screens/permit/widgets/select_location_dropdown_widget.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/generic_text_field.dart';

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
        editSafetyDocumentMap['location'] =
            PlannedLocationDropdown.selectedLocation;
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
      case StringConstants.kPanel12:
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
      case StringConstants.kPanel15:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(StringConstants.kPermitIsolationPanel15,
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
            Text(StringConstants.kPermitEarthingDevicePanel15,
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
            Text(StringConstants.kPermitActionPanel15,
                style: Theme.of(context)
                    .textTheme
                    .xSmall
                    .copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: xxxTinierSpacing),
            TextFieldWidget(
                value: fetchDataForOpenPermitModel.data?.stPrecautions ?? '',
                onTextFieldChanged: (String textValue) {
                  editSafetyDocumentMap['st_precautions'] = textValue;
                }),
            const SizedBox(height: xxTinySpacing),
            Text(StringConstants.kPermitPrecautionsTakenPanel15,
                style: Theme.of(context)
                    .textTheme
                    .xSmall
                    .copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: xxxTinierSpacing),
            TextFieldWidget(
                value: fetchDataForOpenPermitModel.data?.stSafety ?? '',
                onTextFieldChanged: (String textValue) {
                  editSafetyDocumentMap['st_safety'] = textValue;
                }),
            const SizedBox(height: xxTinySpacing),
            Text(StringConstants.kPermitPrimaryEarthingPanel15,
                style: Theme.of(context)
                    .textTheme
                    .xSmall
                    .copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: xxxTinierSpacing),
            TextFieldWidget(
                value: fetchDataForOpenPermitModel.data?.ptwCircuit2 ?? '',
                onTextFieldChanged: (String textValue) {
                  editSafetyDocumentMap['ptw_circuit2'] = textValue;
                }),
            const SizedBox(height: xxTinySpacing),
          ],
        );
      case StringConstants.kPanel16:
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
      default:
        return const SizedBox.shrink();
    }
  }
}
