import 'dart:convert';

LogBookFetchMasterModel logBookFetchMasterModelFromJson(String str) =>
    LogBookFetchMasterModel.fromJson(json.decode(str));

String logBookFetchMasterModelToJson(LogBookFetchMasterModel data) =>
    json.encode(data.toJson());

class LogBookFetchMasterModel {
  final int status;
  final String message;
  final List<List<LogBokFetchMaster>> data;

  LogBookFetchMasterModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory LogBookFetchMasterModel.fromJson(Map<String, dynamic> json) =>
      LogBookFetchMasterModel(
        status: json["Status"],
        message: json["Message"],
        data: List<List<LogBokFetchMaster>>.from(json["Data"].map((x) =>
            List<LogBokFetchMaster>.from(
                x.map((x) => LogBokFetchMaster.fromJson(x))))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(
            data.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
      };
}

class LogBokFetchMaster {
  final dynamic id;
  final String name;
  final String locid;
  final String locname;
  final String flagname;
  final String shortname;
  final dynamic isstatic;
  final String activityname;

  LogBokFetchMaster({
    required this.id,
    required this.name,
    required this.locid,
    required this.locname,
    required this.flagname,
    required this.shortname,
    required this.isstatic,
    required this.activityname,
  });

  factory LogBokFetchMaster.fromJson(Map<String, dynamic> json) =>
      LogBokFetchMaster(
        id: json["id"],
        name: json["name"] ?? '',
        locid: json["locid"] ?? '',
        locname: json["locname"] ?? '',
        flagname: json["flagname"] ?? '',
        shortname: json["shortname"] ?? '',
        isstatic: json["isstatic"] ?? '',
        activityname: json["activityname"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "locid": locid,
        "locname": locname,
        "flagname": flagname,
        "shortname": shortname,
        "isstatic": isstatic,
        "activityname": activityname,
      };
}
