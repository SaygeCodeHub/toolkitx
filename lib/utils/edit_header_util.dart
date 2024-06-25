import 'package:flutter/material.dart';

import '../configs/app_color.dart';
import '../widgets/generic_text_field.dart';

class EditHeader {
  Widget fetchEditHeaderSwitchCaseWidget(
      index, editHeaderData, editHeaderList) {
    editHeaderList.add({
      "id": editHeaderData.id,
      "value":
          (editHeaderData.fieldvalue == '') ? '' : editHeaderData.fieldvalue,
      "ismandatory": editHeaderData.ismandatory
    });

    switch (editHeaderData.id) {
      case 4:
        return TextFieldWidget(
            value: (editHeaderData.fieldvalue == 'null')
                ? ''
                : editHeaderData.fieldvalue,
            maxLength: 3,
            onTextFieldChanged: (String textValue) {
              editHeaderList[index]["value"] = textValue;
            });
      case 5:
        return TextFieldWidget(
          value: (editHeaderData.fieldvalue == 'null')
              ? ''
              : editHeaderData.fieldvalue,
          maxLength: 7,
          onTextFieldChanged: (String textValue) {
            editHeaderList[index]["value"] = textValue;
          },
        );
      case 6:
        return TextFieldWidget(
          value: (editHeaderData.fieldvalue == 'null')
              ? ''
              : editHeaderData.fieldvalue,
          onTextFieldChanged: (String textValue) {
            editHeaderList[index]["value"] = textValue;
          },
        );
      default:
        return Container(
          color: AppColor.deepBlue,
        );
    }
  }
}
