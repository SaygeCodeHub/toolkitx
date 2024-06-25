import 'dart:convert';

FetchAssignWorkForceModel fetchAssignWorkForceModelFromJson(String str) =>
    FetchAssignWorkForceModel.fromJson(json.decode(str));

String fetchAssignWorkForceModelToJson(FetchAssignWorkForceModel data) =>
    json.encode(data.toJson());

class FetchAssignWorkForceModel {
  final int status;
  final String message;
  final List<AssignWorkForceDatum> data;

  FetchAssignWorkForceModel(
      {required this.status, required this.message, required this.data});

  factory FetchAssignWorkForceModel.fromJson(Map<String, dynamic> json) =>
      FetchAssignWorkForceModel(
        status: json["Status"],
        message: json["Message"],
        data: List<AssignWorkForceDatum>.from(
            json["Data"].map((x) => AssignWorkForceDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class AssignWorkForceDatum {
  final String id;
  final String name;
  final dynamic team;
  final String jobTitle;
  final String certificatecode;
  final dynamic plannedhrs;

  AssignWorkForceDatum({
    required this.id,
    required this.name,
    this.team,
    required this.jobTitle,
    required this.certificatecode,
    this.plannedhrs,
  });

  factory AssignWorkForceDatum.fromJson(Map<String, dynamic> json) =>
      AssignWorkForceDatum(
        id: json["id"],
        name: json["name"] ?? '',
        team: json["team"] ?? '',
        jobTitle: json["job_title"] ?? '',
        certificatecode: json["certificatecode"] ?? '',
        plannedhrs: json["plannedhrs"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "team": team,
        "job_title": jobTitle,
        "certificatecode": certificatecode,
        "plannedhrs": plannedhrs,
      };
}
