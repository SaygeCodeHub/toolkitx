import 'dart:convert';

SaveReportNewIncidentPhotosModel saveReportNewIncidentPhotosFromJson(
        String str) =>
    SaveReportNewIncidentPhotosModel.fromJson(json.decode(str));

String saveReportNewIncidentPhotosToJson(
        SaveReportNewIncidentPhotosModel data) =>
    json.encode(data.toJson());

class SaveReportNewIncidentPhotosModel {
  final int status;
  final String message;
  final Data data;

  SaveReportNewIncidentPhotosModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SaveReportNewIncidentPhotosModel.fromJson(
          Map<String, dynamic> json) =>
      SaveReportNewIncidentPhotosModel(
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
