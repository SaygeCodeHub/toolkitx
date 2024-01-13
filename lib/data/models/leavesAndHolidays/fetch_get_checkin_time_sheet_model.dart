import 'dart:convert';

FetchCheckInTimeSheetModel fetchCheckInTimeSheetModelFromJson(String str) =>
    FetchCheckInTimeSheetModel.fromJson(json.decode(str));

String fetchCheckInTimeSheetModelToJson(FetchCheckInTimeSheetModel data) =>
    json.encode(data.toJson());

class FetchCheckInTimeSheetModel {
  int status;
  String message;
  Data data;

  FetchCheckInTimeSheetModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchCheckInTimeSheetModel.fromJson(Map<String, dynamic> json) =>
      FetchCheckInTimeSheetModel(
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
  String timesheetid;
  int status;
  List<Checkin> checkins;

  Data({
    required this.reportdate,
    required this.timesheetid,
    required this.status,
    required this.checkins,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        reportdate: json["reportdate"],
        timesheetid: json["timesheetid"],
        status: json["status"],
        checkins: List<Checkin>.from(
            json["checkins"].map((x) => Checkin.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "reportdate": reportdate,
        "timesheetid": timesheetid,
        "status": status,
        "checkins": List<dynamic>.from(checkins.map((x) => x.toJson())),
      };
}

class Checkin {
  String id;
  String starttime;
  String endtime;
  String workingat;
  int breakmins;
  String canedit;
  String candelete;
  String cancheckout;

  Checkin({
    required this.id,
    required this.starttime,
    required this.endtime,
    required this.workingat,
    required this.breakmins,
    required this.canedit,
    required this.candelete,
    required this.cancheckout,
  });

  factory Checkin.fromJson(Map<String, dynamic> json) => Checkin(
        id: json["id"],
        starttime: json["starttime"],
        endtime: json["endtime"],
        workingat: json["workingat"],
        breakmins: json["breakmins"],
        canedit: json["canedit"],
        candelete: json["candelete"],
        cancheckout: json["cancheckout"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "starttime": starttime,
        "endtime": endtime,
        "workingat": workingat,
        "breakmins": breakmins,
        "canedit": canedit,
        "candelete": candelete,
        "cancheckout": cancheckout,
      };
}
