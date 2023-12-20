import 'dart:convert';

SaveSafetyNoticeFilesModel saveSafetyNoticeFilesModelFromJson(String str) =>
    SaveSafetyNoticeFilesModel.fromJson(json.decode(str));

String saveSafetyNoticeFilesModelToJson(SaveSafetyNoticeFilesModel data) =>
    json.encode(data.toJson());

class SaveSafetyNoticeFilesModel {
  final int status;
  final String message;
  final Data data;

  SaveSafetyNoticeFilesModel(
      {required this.status, required this.message, required this.data});

  factory SaveSafetyNoticeFilesModel.fromJson(Map<String, dynamic> json) =>
      SaveSafetyNoticeFilesModel(
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
