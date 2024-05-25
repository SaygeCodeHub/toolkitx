import 'dart:convert';

WorkforceGetCheckListModel getCheckListModelFromJson(String str) =>
    WorkforceGetCheckListModel.fromJson(json.decode(str));

String getCheckListModelToJson(WorkforceGetCheckListModel data) =>
    json.encode(data.toJson());

class WorkforceGetCheckListModel {
  final int status;
  final String? message;
  final List<GetChecklistData>? data;

  WorkforceGetCheckListModel({
    required this.status,
    this.message,
    this.data,
  });

  factory WorkforceGetCheckListModel.fromJson(Map<String, dynamic> json) =>
      WorkforceGetCheckListModel(
        status: json["Status"],
        message: json["Message"],
        data: List<GetChecklistData>.from(
            json["Data"].map((x) => GetChecklistData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class GetChecklistData {
  final String id;
  final String scheduleid;
  final String name;
  final String submitdate;
  final String overduedate;
  final int isdraft;
  final String? isoverdue;
  final String categoryname;
  final String subcategoryname;
  final String? location;
  final String? isrejected;

  GetChecklistData({
    required this.id,
    required this.scheduleid,
    required this.name,
    required this.submitdate,
    required this.overduedate,
    required this.isdraft,
    this.isoverdue,
    required this.categoryname,
    required this.subcategoryname,
    this.location,
    this.isrejected,
  });

  factory GetChecklistData.fromJson(Map<String, dynamic> json) =>
      GetChecklistData(
        id: json["id"] ?? '',
        scheduleid: json["scheduleid"] ?? '',
        name: json["name"] ?? '',
        submitdate: json["submitdate"] ?? '',
        overduedate: json["overduedate"] ?? '',
        isdraft: json["isdraft"] ?? '',
        isoverdue: json["isoverdue"] ?? '',
        categoryname: json["categoryname"] ?? '',
        subcategoryname: json["subcategoryname"] ?? '',
        location: json["location"] ?? '',
        isrejected: json["isrejected"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "scheduleid": scheduleid,
        "name": name,
        "submitdate": submitdate,
        "overduedate": overduedate,
        "isdraft": isdraft,
        "isoverdue": isoverdue,
        "categoryname": categoryname,
        "subcategoryname": subcategoryname,
        "location": location,
        "isrejected": isrejected,
      };
}
