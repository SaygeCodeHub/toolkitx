import 'dart:convert';

SaveNewQualityManagementReportingModel saveNewQualityManagementFromJson(
        String str) =>
    SaveNewQualityManagementReportingModel.fromJson(json.decode(str));

String saveNewQualityManagementToJson(
        SaveNewQualityManagementReportingModel data) =>
    json.encode(data.toJson());

class SaveNewQualityManagementReportingModel {
  final int status;
  final String message;
  final Data data;

  SaveNewQualityManagementReportingModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SaveNewQualityManagementReportingModel.fromJson(
          Map<String, dynamic> json) =>
      SaveNewQualityManagementReportingModel(
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
