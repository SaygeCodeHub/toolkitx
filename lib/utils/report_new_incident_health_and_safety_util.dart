import 'package:flutter/cupertino.dart';
import 'package:toolkit/widgets/generic_text_field.dart';
import '../configs/app_color.dart';
import '../screens/incident/widgets/incident_custom_field_info_expansion_tile.dart';

class ReportNewIncidentHealthAndSafetyUtil {
  Widget addHealthAndSafetyCaseWidget(
      index, customFieldDatum, customFieldList, addAndEditIncidentMap) {
    customFieldList.add({
      "id": '',
      "value": '',
    });
    switch (customFieldDatum[index].type) {
      case 4:
        return IncidentReportCustomFiledInfoExpansionTile(
          onCustomFieldChanged: (String customFieldOptionId) {
            customFieldList[index]['id'] =
                customFieldDatum[index].id.toString();
            customFieldList[index]['value'] = customFieldOptionId.toString();
          },
          index: index,
          addAndEditIncidentMap: addAndEditIncidentMap,
        );
      case 5:
        return IncidentReportCustomFiledInfoExpansionTile(
          onCustomFieldChanged: (String customFieldOptionId) {
            customFieldList[index]['id'] =
                customFieldDatum[index].id.toString();
            customFieldList[index]['value'] = customFieldOptionId.toString();
          },
          index: index,
          addAndEditIncidentMap: addAndEditIncidentMap,
        );
      case 2:
        return TextFieldWidget(
            value: (addAndEditIncidentMap['customfields'] == null ||
                    addAndEditIncidentMap['customfields'].isEmpty) || (addAndEditIncidentMap['customfields'][index]['value'] == null ||
                addAndEditIncidentMap['customfields'].isEmpty)
                ? ""
                : addAndEditIncidentMap['customfields'][index]['value'],
            maxLength: 250,
            onTextFieldChanged: (String textField) {
              customFieldList[index]['id'] =
                  customFieldDatum[index].id.toString();
              customFieldList[index]['value'] = textField.toString();
            });
      default:
        return Container(
          color: AppColor.deepBlue,
        );
    }
  }
}
