import 'package:flutter/cupertino.dart';

import '../widgets/generic_text_field.dart';

class WorkOrderCustomFieldsUtil {
  Widget customFieldWidget(
      index, customFieldList, customFieldDatum, workOrderDetailsMap) {
    customFieldList.add({'id': '', 'value': ''});
    switch (customFieldDatum[10][index].type) {
      case 1:
        return TextFieldWidget(
            value: (workOrderDetailsMap['customfields'] == null ||
                    workOrderDetailsMap['customfields'].isEmpty)
                ? ""
                : workOrderDetailsMap['customfields'][index]['value'],
            maxLength: 10,
            textInputType: TextInputType.number,
            onTextFieldChanged: (String textField) {
              customFieldList[index]['id'] =
                  customFieldDatum[10][index].id.toString();
              customFieldList[index]['value'] = textField.toString();
            });
      default:
        return const SizedBox.shrink();
    }
  }
}
