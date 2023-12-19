
import 'dart:convert';

FetchLotoAssignedChecklistModel fetchLotoAssignedChecklistModelFromJson(String str) => FetchLotoAssignedChecklistModel.fromJson(json.decode(str));

String fetchLotoAssignedChecklistModelToJson(FetchLotoAssignedChecklistModel data) => json.encode(data.toJson());

class FetchLotoAssignedChecklistModel {
  final int? status;
  final String? message;
  final List<Datum>? data;

  FetchLotoAssignedChecklistModel({
    this.status,
    this.message,
    this.data,
  });

  factory FetchLotoAssignedChecklistModel.fromJson(Map<String, dynamic> json) => FetchLotoAssignedChecklistModel(
    status: json["Status"],
    message: json["Message"],
    data: json["Data"] == null ? [] : List<Datum>.from(json["Data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "Data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  final int? checklistid;
  final String? checklistname;
  final dynamic responseid;

  Datum({
    this.checklistid,
    this.checklistname,
    this.responseid,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    checklistid: json["checklistid"],
    checklistname: json["checklistname"],
    responseid: json["responseid"],
  );

  Map<String, dynamic> toJson() => {
    "checklistid": checklistid,
    "checklistname": checklistname,
    "responseid": responseid,
  };
}
