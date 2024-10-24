import 'dart:convert';

FetchNominationChecklistModel fetchNominationChecklistModelFromJson(
        String str) =>
    FetchNominationChecklistModel.fromJson(json.decode(str));

String fetchNominationChecklistModelToJson(
        FetchNominationChecklistModel data) =>
    json.encode(data.toJson());

class FetchNominationChecklistModel {
  final int status;
  final String message;
  final List<Datum> data;

  FetchNominationChecklistModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchNominationChecklistModel.fromJson(Map<String, dynamic> json) =>
      FetchNominationChecklistModel(
        status: json["Status"],
        message: json["Message"],
        data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  final String executionid;
  final String scheduleid;
  final String checklistname;
  final String assigneddate;
  final String assignedusername;
  final String responsedate;
  final String responseby;
  final dynamic responseid;
  final String cansubmitresponse;
  final String canviewresponse;

  Datum({
    required this.executionid,
    required this.scheduleid,
    required this.checklistname,
    required this.assigneddate,
    required this.assignedusername,
    required this.responsedate,
    required this.responseby,
    required this.responseid,
    required this.cansubmitresponse,
    required this.canviewresponse,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        executionid: json["executionid"] ?? '',
        scheduleid: json["scheduleid"] ?? '',
        checklistname: json["checklistname"] ?? '',
        assigneddate: json["assigneddate"] ?? '',
        assignedusername: json["assignedusername"] ?? '',
        responsedate: json["responsedate"] ?? '',
        responseby: json["responseby"] ?? '',
        responseid: json["responseid"] ?? '',
        cansubmitresponse: json["cansubmitresponse"] ?? '',
        canviewresponse: json["canviewresponse"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "executionid": executionid,
        "scheduleid": scheduleid,
        "checklistname": checklistname,
        "assigneddate": assigneddate,
        "assignedusername": assignedusername,
        "responsedate": responsedate,
        "responseby": responseby,
        "responseid": responseid,
        "cansubmitresponse": cansubmitresponse,
        "canviewresponse": canviewresponse,
      };
}
