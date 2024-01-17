import 'dart:convert';

FetchTimeSheetDetailsModel fetchTimeSheetDetailsModelFromJson(String str) =>
    FetchTimeSheetDetailsModel.fromJson(json.decode(str));

String fetchTimeSheetDetailsModelToJson(FetchTimeSheetDetailsModel data) =>
    json.encode(data.toJson());

class FetchTimeSheetDetailsModel {
  int status;
  String message;
  Data data;

  FetchTimeSheetDetailsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchTimeSheetDetailsModel.fromJson(Map<String, dynamic> json) =>
      FetchTimeSheetDetailsModel(
        status: json["Status"],
        message: json["Message"],
        data: Data.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": data.toJson(),
      };
}

class Data {
  String reportdate;
  String starttime;
  String endtime;
  String woid;
  String wbsid;
  String projectid;
  String generalwbsid;
  String checkinFor;
  String breakmins;
  String description;
  String approve;

  Data({
    required this.reportdate,
    required this.starttime,
    required this.endtime,
    required this.woid,
    required this.wbsid,
    required this.projectid,
    required this.generalwbsid,
    required this.checkinFor,
    required this.breakmins,
    required this.description,
    required this.approve,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        reportdate: json["reportdate"],
        starttime: json["starttime"],
        endtime: json["endtime"],
        woid: json["woid"],
        wbsid: json["wbsid"],
        projectid: json["projectid"],
        generalwbsid: json["generalwbsid"],
        checkinFor: json["checkin_for"],
        breakmins: json["breakmins"],
        description: json["description"],
        approve: json["approve"],
      );

  Map<String, dynamic> toJson() => {
        "reportdate": reportdate,
        "starttime": starttime,
        "endtime": endtime,
        "woid": woid,
        "wbsid": wbsid,
        "projectid": projectid,
        "generalwbsid": generalwbsid,
        "checkin_for": checkinFor,
        "breakmins": breakmins,
        "description": description,
        "approve": approve,
      };
}
