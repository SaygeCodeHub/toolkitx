import 'dart:convert';

SaveIncidentCommentsFilesModel saveIncidentCommentsModelFromJson(String str) =>
    SaveIncidentCommentsFilesModel.fromJson(json.decode(str));

String saveIncidentCommentsModelToJson(SaveIncidentCommentsFilesModel data) =>
    json.encode(data.toJson());

class SaveIncidentCommentsFilesModel {
  final int status;
  final String message;
  final Data data;

  SaveIncidentCommentsFilesModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SaveIncidentCommentsFilesModel.fromJson(Map<String, dynamic> json) =>
      SaveIncidentCommentsFilesModel(
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
