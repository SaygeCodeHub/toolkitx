import 'dart:convert';

IncidentFetchRolesModel incidentFetchRolesModelFromJson(String str) =>
    IncidentFetchRolesModel.fromJson(json.decode(str));

String incidentFetchRolesModelToJson(IncidentFetchRolesModel data) =>
    json.encode(data.toJson());

class IncidentFetchRolesModel {
  final int? status;
  final String? message;
  final List<Datum>? data;

  IncidentFetchRolesModel({
    this.status,
    this.message,
    this.data,
  });

  factory IncidentFetchRolesModel.fromJson(Map<String, dynamic> json) =>
      IncidentFetchRolesModel(
        status: json["Status"],
        message: json["Message"],
        data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  final String groupId;
  final String groupName;

  Datum({
    required this.groupId,
    required this.groupName,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        groupId: json["group_id"],
        groupName: json["group_name"],
      );

  Map<String, dynamic> toJson() => {
        "group_id": groupId,
        "group_name": groupName,
      };
}
