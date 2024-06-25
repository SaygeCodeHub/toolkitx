import 'dart:convert';

SaveToDoDocumentsModel saveToDoDocumentsModelFromJson(String str) =>
    SaveToDoDocumentsModel.fromJson(json.decode(str));

String saveToDoDocumentsModelToJson(SaveToDoDocumentsModel data) =>
    json.encode(data.toJson());

class SaveToDoDocumentsModel {
  final int status;
  final String message;
  final Data data;

  SaveToDoDocumentsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SaveToDoDocumentsModel.fromJson(Map<String, dynamic> json) =>
      SaveToDoDocumentsModel(
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
