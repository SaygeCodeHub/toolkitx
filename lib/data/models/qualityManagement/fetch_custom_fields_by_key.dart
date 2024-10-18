import 'dart:convert';

FetchCustomFieldsByKeyModel fetchCustomFieldsByKeyModelFromJson(String str) =>
    FetchCustomFieldsByKeyModel.fromJson(json.decode(str));

String fetchCustomFieldsByKeyModelToJson(FetchCustomFieldsByKeyModel data) =>
    json.encode(data.toJson());

class FetchCustomFieldsByKeyModel {
  final int status;
  final String message;
  final List<CustomFieldsDatum> data;

  FetchCustomFieldsByKeyModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchCustomFieldsByKeyModel.fromJson(Map<String, dynamic> json) =>
      FetchCustomFieldsByKeyModel(
        status: json["Status"],
        message: json["Message"],
        data: List<CustomFieldsDatum>.from(
            json["Data"].map((x) => CustomFieldsDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class CustomFieldsDatum {
  final int id;
  final int type;
  final String title;
  final int ismandatory;
  final int isallowchar;
  final int isallownumber;
  final int isallowspchar;
  final dynamic maxlength;
  final dynamic minval;
  final dynamic maxval;
  final dynamic fileextension;
  final int active;
  final int createdby;
  final DateTime createddate;
  final dynamic updateddate;
  final String moduletype;
  final dynamic sortorder;
  final dynamic moreinfo;
  final dynamic moreinfoLink;
  final dynamic moduletype2;
  final dynamic rowvalue;
  final dynamic customlisttype;
  final List<Queoption> queoptions;

  CustomFieldsDatum({
    required this.id,
    required this.type,
    required this.title,
    required this.ismandatory,
    required this.isallowchar,
    required this.isallownumber,
    required this.isallowspchar,
    required this.maxlength,
    required this.minval,
    required this.maxval,
    required this.fileextension,
    required this.active,
    required this.createdby,
    required this.createddate,
    required this.updateddate,
    required this.moduletype,
    required this.sortorder,
    required this.moreinfo,
    required this.moreinfoLink,
    required this.moduletype2,
    required this.rowvalue,
    required this.customlisttype,
    required this.queoptions,
  });

  factory CustomFieldsDatum.fromJson(Map<String, dynamic> json) =>
      CustomFieldsDatum(
        id: json["id"],
        type: json["type"],
        title: json["title"],
        ismandatory: json["ismandatory"],
        isallowchar: json["isallowchar"],
        isallownumber: json["isallownumber"],
        isallowspchar: json["isallowspchar"],
        maxlength: json["maxlength"],
        minval: json["minval"],
        maxval: json["maxval"],
        fileextension: json["fileextension"],
        active: json["active"],
        createdby: json["createdby"],
        createddate: DateTime.parse(json["createddate"]),
        updateddate: json["updateddate"],
        moduletype: json["moduletype"],
        sortorder: json["sortorder"],
        moreinfo: json["moreinfo"],
        moreinfoLink: json["moreinfo_link"],
        moduletype2: json["moduletype_2"],
        rowvalue: json["rowvalue"],
        customlisttype: json["customlisttype"],
        queoptions: List<Queoption>.from(
            json["queoptions"].map((x) => Queoption.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "title": title,
        "ismandatory": ismandatory,
        "isallowchar": isallowchar,
        "isallownumber": isallownumber,
        "isallowspchar": isallowspchar,
        "maxlength": maxlength,
        "minval": minval,
        "maxval": maxval,
        "fileextension": fileextension,
        "active": active,
        "createdby": createdby,
        "createddate": createddate.toIso8601String(),
        "updateddate": updateddate,
        "moduletype": moduletype,
        "sortorder": sortorder,
        "moreinfo": moreinfo,
        "moreinfo_link": moreinfoLink,
        "moduletype_2": moduletype2,
        "rowvalue": rowvalue,
        "customlisttype": customlisttype,
        "queoptions": List<dynamic>.from(queoptions.map((x) => x.toJson())),
      };
}

class Queoption {
  final int optionid;
  final String optiontext;

  Queoption({
    required this.optionid,
    required this.optiontext,
  });

  factory Queoption.fromJson(Map<String, dynamic> json) => Queoption(
        optionid: json["optionid"],
        optiontext: json["optiontext"],
      );

  Map<String, dynamic> toJson() => {
        "optionid": optionid,
        "optiontext": optiontext,
      };
}
