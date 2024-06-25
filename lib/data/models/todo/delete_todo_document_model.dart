import 'dart:convert';

DeleteToDoDocumentModel deleteToDoDocumentModelFromJson(String str) =>
    DeleteToDoDocumentModel.fromJson(json.decode(str));

String deleteToDoDocumentModelToJson(DeleteToDoDocumentModel data) =>
    json.encode(data.toJson());

class DeleteToDoDocumentModel {
  final int status;
  final String message;
  final Data data;

  DeleteToDoDocumentModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory DeleteToDoDocumentModel.fromJson(Map<String, dynamic> json) =>
      DeleteToDoDocumentModel(
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
