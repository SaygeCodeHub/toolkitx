import 'dart:convert';

SaveLinkedDocumentsModel saveLinkedDocumentsModelFromJson(String str) =>
    SaveLinkedDocumentsModel.fromJson(json.decode(str));

String saveLinkedDocumentsModelToJson(SaveLinkedDocumentsModel data) =>
    json.encode(data.toJson());

class SaveLinkedDocumentsModel {
  final int status;
  final String message;
  final Data data;

  SaveLinkedDocumentsModel(
      {required this.status, required this.message, required this.data});

  factory SaveLinkedDocumentsModel.fromJson(Map<String, dynamic> json) =>
      SaveLinkedDocumentsModel(
          status: json["Status"],
          message: json["Message"],
          data: Data.fromJson(json["Data"]));

  Map<String, dynamic> toJson() =>
      {"Status": status, "Message": message, "Data": data.toJson()};
}

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}
