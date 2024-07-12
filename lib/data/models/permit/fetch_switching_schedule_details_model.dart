import 'dart:convert';

FetchSwitchingScheduleDetailsModel fetchSwitchingScheduleDetailsModelFromJson(
        String str) =>
    FetchSwitchingScheduleDetailsModel.fromJson(json.decode(str));

String fetchSwitchingScheduleDetailsModelToJson(
        FetchSwitchingScheduleDetailsModel data) =>
    json.encode(data.toJson());

class FetchSwitchingScheduleDetailsModel {
  final int status;
  final String message;
  final Data data;

  FetchSwitchingScheduleDetailsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchSwitchingScheduleDetailsModel.fromJson(
          Map<String, dynamic> json) =>
      FetchSwitchingScheduleDetailsModel(
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
  final String permitswitchingscheduleid;
  final String location;
  final String equipmentuid;
  final String operation;
  final String instructionreceivedby;
  final String instructionreceiveddatetime;
  final String controlengineerid;
  final String carriedoutdatetime;
  final String carriedoutconfirmeddatetime;
  final String safetykeynumber;
  final String permitid;
  final String sortorder;
  final String instructionreceiveddate;
  final String instructionreceivedtime;
  final String carriedoutdate;
  final String carriedouttime;
  final String carriedoutconfirmeddate;
  final String carriedoutconfirmedtime;

  Data({
    required this.permitswitchingscheduleid,
    required this.location,
    required this.equipmentuid,
    required this.operation,
    required this.instructionreceivedby,
    required this.instructionreceiveddatetime,
    required this.controlengineerid,
    required this.carriedoutdatetime,
    required this.carriedoutconfirmeddatetime,
    required this.safetykeynumber,
    required this.permitid,
    required this.sortorder,
    required this.instructionreceiveddate,
    required this.instructionreceivedtime,
    required this.carriedoutdate,
    required this.carriedouttime,
    required this.carriedoutconfirmeddate,
    required this.carriedoutconfirmedtime,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        permitswitchingscheduleid: json["permitswitchingscheduleid"],
        location: json["location"],
        equipmentuid: json["equipmentuid"],
        operation: json["operation"],
        instructionreceivedby: json["instructionreceivedby"],
        instructionreceiveddatetime: json["instructionreceiveddatetime"],
        controlengineerid: json["controlengineerid"],
        carriedoutdatetime: json["carriedoutdatetime"],
        carriedoutconfirmeddatetime: json["carriedoutconfirmeddatetime"],
        safetykeynumber: json["safetykeynumber"],
        permitid: json["permitid"],
        sortorder: json["sortorder"],
        instructionreceiveddate: json["instructionreceiveddate"],
        instructionreceivedtime: json["instructionreceivedtime"],
        carriedoutdate: json["carriedoutdate"],
        carriedouttime: json["carriedouttime"],
        carriedoutconfirmeddate: json["carriedoutconfirmeddate"],
        carriedoutconfirmedtime: json["carriedoutconfirmedtime"],
      );

  Map<String, dynamic> toJson() => {
        "permitswitchingscheduleid": permitswitchingscheduleid,
        "location": location,
        "equipmentuid": equipmentuid,
        "operation": operation,
        "instructionreceivedby": instructionreceivedby,
        "instructionreceiveddatetime": instructionreceiveddatetime,
        "controlengineerid": controlengineerid,
        "carriedoutdatetime": carriedoutdatetime,
        "carriedoutconfirmeddatetime": carriedoutconfirmeddatetime,
        "safetykeynumber": safetykeynumber,
        "permitid": permitid,
        "sortorder": sortorder,
        "instructionreceiveddate": instructionreceiveddate,
        "instructionreceivedtime": instructionreceivedtime,
        "carriedoutdate": carriedoutdate,
        "carriedouttime": carriedouttime,
        "carriedoutconfirmeddate": carriedoutconfirmeddate,
        "carriedoutconfirmedtime": carriedoutconfirmedtime,
      };
}
