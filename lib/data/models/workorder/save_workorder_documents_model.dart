import 'dart:convert';

SaveWorkOrderDocumentsModel saveWorkOrderDocumentsFromJson(String str) =>
    SaveWorkOrderDocumentsModel.fromJson(json.decode(str));

String saveWorkOrderDocumentsToJson(SaveWorkOrderDocumentsModel data) =>
    json.encode(data.toJson());

class SaveWorkOrderDocumentsModel {
  final int status;
  final String message;
  final Data data;

  SaveWorkOrderDocumentsModel(
      {required this.status, required this.message, required this.data});

  factory SaveWorkOrderDocumentsModel.fromJson(Map<String, dynamic> json) =>
      SaveWorkOrderDocumentsModel(
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
