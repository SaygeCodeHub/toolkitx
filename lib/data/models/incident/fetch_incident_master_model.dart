import 'dart:convert';

FetchIncidentMasterModel fetchIncidentMasterModelFromJson(String str) =>
    FetchIncidentMasterModel.fromJson(json.decode(str));

String fetchIncidentMasterModelToJson(FetchIncidentMasterModel data) =>
    json.encode(data.toJson());

class FetchIncidentMasterModel {
  final int? status;
  final String? message;
  final List<List<IncidentMasterDatum>>? incidentMasterDatum;

  FetchIncidentMasterModel({
    this.status,
    this.message,
    this.incidentMasterDatum,
  });

  factory FetchIncidentMasterModel.fromJson(Map<String, dynamic> json) =>
      FetchIncidentMasterModel(
        status: json["Status"],
        message: json["Message"],
        incidentMasterDatum: List<List<IncidentMasterDatum>>.from(json["Data"]
            .map((x) => List<IncidentMasterDatum>.from(
                x.map((x) => IncidentMasterDatum.fromJson(x))))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(incidentMasterDatum!
            .map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
      };
}

class IncidentMasterDatum {
  final String? name;
  final String? location;
  final int? id;
  final String? typename;
  final int? type;
  final String? title;
  final int? ismandatory;
  final int? isallowchar;
  final int? isallownumber;
  final int? isallowspchar;
  final dynamic maxlength;
  final dynamic minval;
  final dynamic maxval;
  final String? fileextension;
  final int? active;
  final int? createdby;
  final dynamic createddate;
  final dynamic updateddate;
  final String? moduletype;
  final int? sortorder;
  final dynamic moreinfo;
  final dynamic moreinfoLink;
  final dynamic moduletype2;
  final dynamic rowvalue;
  final List<dynamic> queoptions;
  final int? groupId;
  final String? groupName;

  IncidentMasterDatum({
    this.name,
    this.location,
    this.id,
    this.typename,
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
    this.active,
    this.createdby,
    this.createddate,
    this.updateddate,
    this.moduletype,
    this.sortorder,
    this.moreinfo,
    this.moreinfoLink,
    this.moduletype2,
    this.rowvalue,
    required this.queoptions,
    this.groupId,
    this.groupName,
  });

  factory IncidentMasterDatum.fromJson(Map<String, dynamic> json) =>
      IncidentMasterDatum(
        name: json["name"],
        location: json["location"],
        id: json["id"],
        typename: json["typename"],
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
        createddate: json["createddate"],
        updateddate: json["updateddate"],
        moduletype: json["moduletype"],
        sortorder: json["sortorder"],
        moreinfo: json["moreinfo"],
        moreinfoLink: json["moreinfo_link"],
        moduletype2: json["moduletype_2"],
        rowvalue: json["rowvalue"],
        queoptions: json["queoptions"] != null
            ? List<dynamic>.from(json["queoptions"].map((x) => x))
            : <dynamic>[],
        groupId: json["group_id"],
        groupName: json["group_name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "location": location,
        "id": id,
        "typename": typename,
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
  final int? optionid;
  final String? optiontext;

  Queoption({
    this.optionid,
    this.optiontext,
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
