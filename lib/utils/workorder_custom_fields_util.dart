import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../widgets/generic_text_field.dart';

class WorkOrderCustomFieldsUtil {
  Widget customFieldWidget(index, customFieldDatum, workOrderDetailsMap) {
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
              workOrderDetailsMap['customfields'][index]['id'] =
                  customFieldDatum[10][index].id.toString();
              workOrderDetailsMap['customfields'][index]['value'] =
                  textField.toString();
              log("custom fields=====>${workOrderDetailsMap['customfields'][index]['id']}");
              log("custom value=====>${workOrderDetailsMap['customfields'][index]['value']}");
            });
      default:
        return const SizedBox.shrink();
    }
  }
}
