import 'dart:convert';

IncidentUnlinkPermitModel incidentUnlinkPermitBlocFromJson(String str) =>
    IncidentUnlinkPermitModel.fromJson(json.decode(str));

String incidentUnlinkPermitBlocToJson(IncidentUnlinkPermitModel data) =>
    json.encode(data.toJson());

class IncidentUnlinkPermitModel {
  final int? status;
  final String? message;
  final Data? data;

  IncidentUnlinkPermitModel({
    this.status,
    this.message,
    this.data,
  });

  factory IncidentUnlinkPermitModel.fromJson(Map<String, dynamic> json) =>
      IncidentUnlinkPermitModel(
        status: json["Status"],
        message: json["Message"],
        data: Data.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": data!.toJson(),
      };
}

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}
