import 'dart:convert';

CheckListWorkforceListModel getChecklistStatusModelFromJson(String str) =>
    CheckListWorkforceListModel.fromJson(json.decode(str));

String getChecklistStatusModelToJson(CheckListWorkforceListModel data) =>
    json.encode(data.toJson());

class CheckListWorkforceListModel {
  final int status;
  final String? message;
  final List<GetChecklistStatusData>? data;

  CheckListWorkforceListModel({
    required this.status,
    this.message,
    this.data,
  });

  factory CheckListWorkforceListModel.fromJson(Map<String, dynamic> json) =>
      CheckListWorkforceListModel(
        status: json["Status"],
        message: json["Message"],
        data: List<GetChecklistStatusData>.from(
            json["Data"].map((x) => GetChecklistStatusData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class GetChecklistStatusData {
  final String id;
  final String checklistname;
  final String? isthirdpartyapproval;
  final String startdate;
  final String enddate;
  final dynamic templateid;
  final String responseid;
  final String name;
  final String? responsedate;
  final String company;
  final String? jobtitle;
  final dynamic approvalstatus;
  final dynamic isdeptapprove;
  final String? canaddworklist;

  GetChecklistStatusData({
    required this.id,
    required this.checklistname,
    this.isthirdpartyapproval,
    required this.startdate,
    required this.enddate,
    this.templateid,
    required this.responseid,
    required this.name,
    this.responsedate,
    required this.company,
    this.jobtitle,
    this.approvalstatus,
    this.isdeptapprove,
    this.canaddworklist,
  });

  factory GetChecklistStatusData.fromJson(Map<String, dynamic> json) =>
      GetChecklistStatusData(
        id: json["id"],
        checklistname: json["checklistname"],
        isthirdpartyapproval: json["isthirdpartyapproval"],
        startdate: json["startdate"],
        enddate: json["enddate"],
        templateid: json["templateid"],
        responseid: json["responseid"],
        name: json["name"],
        responsedate: json["responsedate"],
        company: json["company"],
        jobtitle: json["jobtitle"],
        approvalstatus: json["approvalstatus"],
        isdeptapprove: json["isdeptapprove"],
        canaddworklist: json["canaddworklist"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "checklistname": checklistname,
        "isthirdpartyapproval": isthirdpartyapproval,
        "startdate": startdate,
        "enddate": enddate,
        "templateid": templateid,
        "responseid": responseid,
        "name": name,
        "responsedate": responsedate,
        "company": company,
        "jobtitle": jobtitle,
        "approvalstatus": approvalstatus,
        "isdeptapprove": isdeptapprove,
        "canaddworklist": canaddworklist,
      };
}
