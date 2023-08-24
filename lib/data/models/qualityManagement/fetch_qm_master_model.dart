import 'dart:convert';

FetchQualityManagementMasterModel fetchQualityManagementRolesModelFromJson(
        String str) =>
    FetchQualityManagementMasterModel.fromJson(json.decode(str));

String fetchQualityManagementMasterModelToJson(
        FetchQualityManagementMasterModel data) =>
    json.encode(data.toJson());

class FetchQualityManagementMasterModel {
  final int? status;
  final String? message;
  final List<List<QMMasterDatum>>? data;

  FetchQualityManagementMasterModel({
    this.status,
    this.message,
    this.data,
  });

  factory FetchQualityManagementMasterModel.fromJson(
          Map<String, dynamic> json) =>
      FetchQualityManagementMasterModel(
        status: json["Status"],
        message: json["Message"],
        data: List<List<QMMasterDatum>>.from(json["Data"].map((x) =>
            List<QMMasterDatum>.from(x.map((x) => QMMasterDatum.fromJson(x))))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(
            data!.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
      };
}

class QMMasterDatum {
  final String name;
  final String location;
  final dynamic id;
  final dynamic type;
  final String? title;
  final dynamic ismandatory;
  final dynamic isallowchar;
  final dynamic isallownumber;
  final dynamic isallowspchar;
  final dynamic maxlength;
  final dynamic minval;
  final dynamic maxval;
  final dynamic fileextension;
  final dynamic active;
  final dynamic createdby;
  final dynamic createddate;
  final dynamic updateddate;
  final String? moduletype;
  final dynamic sortorder;
  final dynamic moreinfo;
  final dynamic moreinfoLink;
  final dynamic moduletype2;
  final dynamic rowvalue;
  final List<Queoption> queoptions;
  final dynamic groupId;
  final String groupName;

  QMMasterDatum({
    required this.name,
    required this.location,
    this.id,
    this.type,
    this.title,
    this.ismandatory,
    this.isallowchar,
    this.isallownumber,
    this.isallowspchar,
    this.maxlength,
    this.minval,
    this.maxval,
    this.fileextension,
    required this.active,
    required this.createdby,
    required this.createddate,
    this.updateddate,
    this.moduletype,
    this.sortorder,
    this.moreinfo,
    this.moreinfoLink,
    this.moduletype2,
    this.rowvalue,
    required this.queoptions,
    required this.groupId,
    required this.groupName,
  });

  factory QMMasterDatum.fromJson(Map<String, dynamic> json) => QMMasterDatum(
        name: json["name"] ?? '',
        location: json["location"] ?? '',
        id: json["id"] ?? '',
        type: json["type"] ?? '',
        title: json["title"] ?? '',
        ismandatory: json["ismandatory"] ?? '',
        isallowchar: json["isallowchar"] ?? '',
        isallownumber: json["isallownumber"] ?? '',
        isallowspchar: json["isallowspchar"] ?? '',
        maxlength: json["maxlength"] ?? '',
        minval: json["minval"] ?? '',
        maxval: json["maxval"] ?? '',
        fileextension: json["fileextension"] ?? '',
        active: json["active"] ?? '',
        createdby: json["createdby"],
        createddate: json["createddate"] ?? '',
        updateddate: json["updateddate"] ?? '',
        moduletype: json["moduletype"] ?? '',
        sortorder: json["sortorder"] ?? '',
        moreinfo: json["moreinfo"] ?? '',
        moreinfoLink: json["moreinfo_link"] ?? '',
        moduletype2: json["moduletype_2"] ?? '',
        rowvalue: json["rowvalue"] ?? '',
        queoptions: json["queoptions"] == null
            ? []
            : List<Queoption>.from(
                json["queoptions"].map((x) => Queoption.fromJson(x))),
        groupId: json["group_id"] ?? '',
        groupName: json["group_name"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "location": location,
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
        "queoptions": List<dynamic>.from(queoptions.map((x) => x.toJson())),
        "group_id": groupId,
        "group_name": groupName,
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
        optionid: json["optionid"] ?? '',
        optiontext: json["optiontext"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "optionid": optionid,
        "optiontext": optiontext,
      };
}
