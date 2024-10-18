import 'package:flutter/cupertino.dart';

import '../configs/app_color.dart';
import '../screens/qualityManagement/widgets/qm_custom_field_expansion_tile.dart';
import '../widgets/generic_text_field.dart';

class QualityManagementCustomFieldInfoUtil {
  Widget addCustomFieldsCaseWidget(
      index, customFieldDatum, customFieldList, addAndEditQMMap) {
    customFieldList.add({
      "id": '',
      "value": '',
    });
    switch (customFieldDatum[index].type) {
      case 1:
        return TextFieldWidget(
            value: (addAndEditQMMap['customfields'] == null ||
                    addAndEditQMMap['customfields'].isEmpty)
                ? ""
                : addAndEditQMMap['customfields'][index]['value'],
            maxLength: 250,
            onTextFieldChanged: (String textField) {
              customFieldList[index]['id'] =
                  customFieldDatum[index].id.toString();
              customFieldList[index]['value'] = textField.toString();
            });
      case 2:
        return TextFieldWidget(
            value: (addAndEditQMMap['customfields'] == null ||
                    addAndEditQMMap['customfields'].isEmpty)
                ? ""
                : addAndEditQMMap['customfields'][index]['value'],
            maxLength: 250,
            maxLines: 3,
            onTextFieldChanged: (String textField) {
              customFieldList[index]['id'] =
                  customFieldDatum[index].id.toString();
              customFieldList[index]['value'] = textField.toString();
            });
      case 3:
        return QualityManagementCustomFieldInfoExpansionTile(
          onCustomFieldChanged: (String customFieldOptionId) {
            customFieldList[index]['id'] =
                customFieldDatum[index].id.toString();
            customFieldList[index]['value'] = customFieldOptionId.toString();
          },
          index: index,
          addAndEditIncidentMap: addAndEditQMMap,
          customFieldsDatum: customFieldDatum,
        );

      default:
        return Container(
          color: AppColor.deepBlue,
        );
    }
  }
}
