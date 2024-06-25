import 'dart:convert';

SaveIncidentAndQMCommentsFilesModel saveIncidentCommentsModelFromJson(
        String str) =>
    SaveIncidentAndQMCommentsFilesModel.fromJson(json.decode(str));

String saveIncidentCommentsModelToJson(
        SaveIncidentAndQMCommentsFilesModel data) =>
    json.encode(data.toJson());

class SaveIncidentAndQMCommentsFilesModel {
  final int? status;
  final String? message;
  final Data? data;

  SaveIncidentAndQMCommentsFilesModel({
    this.status,
    this.message,
    this.data,
  });

  factory SaveIncidentAndQMCommentsFilesModel.fromJson(
          Map<String, dynamic> json) =>
      SaveIncidentAndQMCommentsFilesModel(
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
