class ExpenseItemCustomFieldsModel {
  final int status;
  final String message;
  final List<CustomFieldData> data;

  ExpenseItemCustomFieldsModel(
      {required this.status, required this.message, required this.data});

  factory ExpenseItemCustomFieldsModel.fromJson(Map<String, dynamic> json) {
    List<CustomFieldData> parsedData = _parseData(json['Data']);

    return ExpenseItemCustomFieldsModel(
      status: json['Status'],
      message: json['Message'],
      data: parsedData,
    );
  }

  static List<CustomFieldData> _parseData(dynamic data) {
    if (data is List) {
      return List<CustomFieldData>.from(
          data.map((x) => CustomFieldData.fromJson(x)));
    } else {
      throw const FormatException("Unexpected type for 'Data'");
    }
  }
}

class CustomFieldData {
  final String id;
  final int type;
  final String title;
  final int ismandatory;
  final int isallowchar;
  final int isallownumber;
  final int isallowspchar;
  final dynamic maxlength;
  final dynamic minval;
  final dynamic maxval;
  final String fileextension;
  final String optiontext;
  final String optiontextid;
  final List<QueOption> queoptions;

  CustomFieldData({
    required this.id,
    required this.type,
    required this.title,
    required this.ismandatory,
    required this.isallowchar,
    required this.isallownumber,
    required this.isallowspchar,
    this.maxlength,
    this.minval,
    this.maxval,
    required this.fileextension,
    required this.optiontext,
    required this.optiontextid,
    required this.queoptions,
  });

  factory CustomFieldData.fromJson(Map<String, dynamic> json) {
    return CustomFieldData(
      id: json['id'],
      type: json['type'],
      title: json['title'],
      ismandatory: json['ismandatory'],
      isallowchar: json['isallowchar'],
      isallownumber: json['isallownumber'],
      isallowspchar: json['isallowspchar'],
      maxlength: json['maxlength'],
      minval: json['minval'],
      maxval: json['maxval'],
      fileextension: json['fileextension'],
      optiontext: json['optiontext'],
      optiontextid: json['optiontextid'],
      queoptions: List<QueOption>.from(
          json['queoptions'].map((x) => QueOption.fromJson(x))),
    );
  }
}

class QueOption {
  final int queoptionid;
  final String queoptiontext;

  QueOption({required this.queoptionid, required this.queoptiontext});

  factory QueOption.fromJson(Map<String, dynamic> json) {
    return QueOption(
      queoptionid: json['queoptionid'],
      queoptiontext: json['queoptiontext'],
    );
  }
}
