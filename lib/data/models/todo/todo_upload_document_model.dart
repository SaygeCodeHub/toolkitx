import 'dart:convert';

ToDoUploadDocumentModel toDoUploadDocumentModelFromJson(String str) =>
    ToDoUploadDocumentModel.fromJson(json.decode(str));

String toDoUploadDocumentModelToJson(ToDoUploadDocumentModel data) =>
    json.encode(data.toJson());

class ToDoUploadDocumentModel {
  final int status;
  final String message;
  final Data data;

  ToDoUploadDocumentModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ToDoUploadDocumentModel.fromJson(Map<String, dynamic> json) =>
      ToDoUploadDocumentModel(
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
