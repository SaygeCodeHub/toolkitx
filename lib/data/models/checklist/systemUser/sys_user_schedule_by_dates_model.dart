import 'dart:convert';

ChecklistScheduledByDatesModel getChecklistDetailsModelFromJson(String str) =>
    ChecklistScheduledByDatesModel.fromJson(json.decode(str));

String getChecklistDetailsModelToJson(ChecklistScheduledByDatesModel data) =>
    json.encode(data.toJson());

class ChecklistScheduledByDatesModel {
  final int status;
  final String? message;
  final List<GetChecklistDetailsData>? data;

  ChecklistScheduledByDatesModel({
    required this.status,
    this.message,
    this.data,
  });

  factory ChecklistScheduledByDatesModel.fromJson(Map<String, dynamic> json) =>
      ChecklistScheduledByDatesModel(
        status: json["Status"],
        message: json["Message"],
        data: List<GetChecklistDetailsData>.from(
            json["Data"].map((x) => GetChecklistDetailsData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class GetChecklistDetailsData {
  final String id;
  final String checklistname;
  final int responsecount;
  final int rejectcount;
  final int? totalworkforcecount;
  final int approvalpendingcount;
  final int? isoverdue;
  final String dates;

  GetChecklistDetailsData({
    required this.id,
    required this.checklistname,
    required this.responsecount,
    required this.rejectcount,
    this.totalworkforcecount,
    required this.approvalpendingcount,
    this.isoverdue,
    required this.dates,
  });

  factory GetChecklistDetailsData.fromJson(Map<String, dynamic> json) =>
      GetChecklistDetailsData(
        id: json["id"],
        checklistname: json["checklistname"],
        responsecount: json["responsecount"],
        rejectcount: json["rejectcount"],
        totalworkforcecount: json["totalworkforcecount"],
        approvalpendingcount: json["approvalpendingcount"],
        isoverdue: json["isoverdue"],
        dates: json["dates"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "checklistname": checklistname,
        "responsecount": responsecount,
        "rejectcount": rejectcount,
        "totalworkforcecount": totalworkforcecount,
        "approvalpendingcount": approvalpendingcount,
        "isoverdue": isoverdue,
        "dates": dates,
      };
}
