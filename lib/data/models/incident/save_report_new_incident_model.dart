import 'dart:convert';

SaveReportNewIncidentModel saveReportNewIncidentModelFromJson(String str) =>
    SaveReportNewIncidentModel.fromJson(json.decode(str));

String saveReportNewIncidentModelToJson(SaveReportNewIncidentModel data) =>
    json.encode(data.toJson());

class SaveReportNewIncidentModel {
  final int status;
  final String message;
  final Data data;

  SaveReportNewIncidentModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SaveReportNewIncidentModel.fromJson(Map<String, dynamic> json) =>
      SaveReportNewIncidentModel(
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
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}
