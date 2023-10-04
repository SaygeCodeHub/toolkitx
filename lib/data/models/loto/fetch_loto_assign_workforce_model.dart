import 'dart:convert';

FetchLotoAssignWorkforceModel fetchLotoAssignWorkforceModelFromJson(
        String str) =>
    FetchLotoAssignWorkforceModel.fromJson(json.decode(str));

String fetchLotoAssignWorkforceModelToJson(
        FetchLotoAssignWorkforceModel data) =>
    json.encode(data.toJson());

class FetchLotoAssignWorkforceModel {
  final int status;
  final String message;
  final List<LotoWorkforceDatum> data;

  FetchLotoAssignWorkforceModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchLotoAssignWorkforceModel.fromJson(Map<String, dynamic> json) =>
      FetchLotoAssignWorkforceModel(
        status: json["Status"],
        message: json["Message"],
        data: List<LotoWorkforceDatum>.from(
            json["Data"].map((x) => LotoWorkforceDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class LotoWorkforceDatum {
  final int id;
  final String name;
  final String jobTitle;

  LotoWorkforceDatum({
    required this.id,
    required this.name,
    required this.jobTitle,
  });

  factory LotoWorkforceDatum.fromJson(Map<String, dynamic> json) =>
      LotoWorkforceDatum(
        id: json["id"],
        name: json["name"],
        jobTitle: json["job_title"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "job_title": jobTitle,
      };
}
