import 'package:flutter/material.dart';
import 'package:toolkit/data/models/permit/fetch_data_for_open_permit_model.dart';
import 'package:toolkit/screens/permit/widgets/permit_edit_safety_doc_common_panel.dart';
import 'package:toolkit/screens/permit/widgets/permit_edit_safety_doc_panel_12_section.dart';
import 'package:toolkit/screens/permit/widgets/permit_edit_safety_doc_panel_15_section.dart';
import 'package:toolkit/screens/permit/widgets/permit_edit_safety_doc_panel_16_section.dart';
import 'package:toolkit/screens/permit/widgets/select_location_dropdown_widget.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

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
        return PermitEditSafetyDocCommonPanel(
            editSafetyDocumentMap: editSafetyDocumentMap,
            fetchDataForOpenPermitModel: fetchDataForOpenPermitModel);
      case StringConstants.kPanel12:
        return PermitEditSafetyDocPanel12Section(
            editSafetyDocumentMap: editSafetyDocumentMap);
      case StringConstants.kPanel15:
        return PermitEditSafetyDocPanel15Section(
            editSafetyDocumentMap: editSafetyDocumentMap,
            fetchDataForOpenPermitModel: fetchDataForOpenPermitModel);
      case StringConstants.kPanel16:
        return PermitEditSafetyDoc16Section(
            editSafetyDocumentMap: editSafetyDocumentMap,
            fetchDataForOpenPermitModel: fetchDataForOpenPermitModel);
      default:
        return const SizedBox.shrink();
    }
  }
}
