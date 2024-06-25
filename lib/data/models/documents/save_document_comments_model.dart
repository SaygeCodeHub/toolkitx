import 'dart:convert';

SaveDocumentCommentsModel saveDocumentCommentsModelFromJson(String str) =>
    SaveDocumentCommentsModel.fromJson(json.decode(str));

String saveDocumentCommentsModelToJson(SaveDocumentCommentsModel data) =>
    json.encode(data.toJson());

class SaveDocumentCommentsModel {
  final int status;
  final String message;
  final Data data;

  SaveDocumentCommentsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SaveDocumentCommentsModel.fromJson(Map<String, dynamic> json) =>
      SaveDocumentCommentsModel(
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
