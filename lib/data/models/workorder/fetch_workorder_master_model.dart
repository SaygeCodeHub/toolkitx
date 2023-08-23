import 'dart:convert';

FetchWorkOrdersMasterModel fetchWorkOrdersModelFromJson(String str) =>
    FetchWorkOrdersMasterModel.fromJson(json.decode(str));

String fetchWorkOrdersMasterModelToJson(FetchWorkOrdersMasterModel data) =>
    json.encode(data.toJson());

class FetchWorkOrdersMasterModel {
  final int status;
  final String message;
  final List<List<WorkOrderMasterDatum>> data;

  FetchWorkOrdersMasterModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchWorkOrdersMasterModel.fromJson(Map<String, dynamic> json) =>
      FetchWorkOrdersMasterModel(
        status: json["Status"],
        message: json["Message"],
        data: List<List<WorkOrderMasterDatum>>.from(json["Data"].map((x) =>
            List<WorkOrderMasterDatum>.from(
                x.map((x) => WorkOrderMasterDatum.fromJson(x))))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(
            data.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
      };
}

class WorkOrderMasterDatum {
  final dynamic id;
  final String name;
  final String location;
  final dynamic groupId;
  final String groupName;
  final String costcenter;
  final String category;
  final String origination;
  final String workordertype;
  final String currency;
  final String certificateList;
  final dynamic type;
  final String title;
  final dynamic ismandatory;
  final dynamic isallowchar;
  final dynamic isallownumber;
  final dynamic isallowspchar;
  final dynamic maxlength;
  final dynamic minval;
  final dynamic maxval;
  final String fileextension;
  final dynamic active;
  final dynamic createdby;
  final String createddate;
  final dynamic updateddate;
  final String moduletype;
  final dynamic sortorder;
  final String moreinfo;
  final dynamic moreinfoLink;
  final dynamic moduletype2;
  final dynamic rowvalue;
  final List<dynamic>? queoptions;

  WorkOrderMasterDatum({
    required this.id,
    required this.name,
    required this.location,
    required this.groupId,
    required this.groupName,
    required this.costcenter,
    required this.category,
    required this.origination,
    required this.workordertype,
    required this.currency,
    required this.certificateList,
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
    required this.active,
    required this.createdby,
    required this.createddate,
    this.updateddate,
    this.moduletype = '',
    this.sortorder,
    this.moreinfo = '',
    this.moreinfoLink,
    this.moduletype2,
    this.rowvalue,
    this.queoptions,
  });

  factory WorkOrderMasterDatum.fromJson(Map<String, dynamic> json) =>
      WorkOrderMasterDatum(
        id: json["id"],
        name: json["name"] ?? '',
        location: json["location"] ?? '',
        groupId: json["group_id"],
        groupName: json["group_name"] ?? '',
        costcenter: json["costcenter"] ?? '',
        category: json["category"] ?? '',
        origination: json["origination"] ?? '',
        workordertype: json["workordertype"] ?? '',
        currency: json["currency"] ?? '',
        certificateList: json["certificate_list"] ?? '',
        type: json["type"],
        title: json["title"] ?? '',
        ismandatory: json["ismandatory"],
        isallowchar: json["isallowchar"],
        isallownumber: json["isallownumber"],
        isallowspchar: json["isallowspchar"],
        maxlength: json["maxlength"],
        minval: json["minval"],
        maxval: json["maxval"],
        fileextension: json["fileextension"] ?? '',
        active: json["active"],
        createdby: json["createdby"],
        createddate: json["createddate"] ?? '',
        updateddate: json["updateddate"],
        moduletype: json["moduletype"] ?? '',
        sortorder: json["sortorder"],
        moreinfo: json["moreinfo"] ?? '',
        moreinfoLink: json["moreinfo_link"],
        moduletype2: json["moduletype_2"],
        rowvalue: json["rowvalue"],
        queoptions: List<dynamic>.from(
            json["queoptions"] == null ? [] : json["queoptions"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "location": location,
        "group_id": groupId,
        "group_name": groupName,
        "costcenter": costcenter,
        "category": category,
        "origination": origination,
        "workordertype": workordertype,
        "currency": currency,
        "certificate_list": certificateList,
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
        "createddate": createddate,
        "updateddate": updateddate,
        "moduletype": moduletype,
        "sortorder": sortorder,
        "moreinfo": moreinfo,
        "moreinfo_link": moreinfoLink,
        "moduletype_2": moduletype2,
        "rowvalue": rowvalue,
        "queoptions": List<dynamic>.from(queoptions!.map((x) => x)),
      };
}
