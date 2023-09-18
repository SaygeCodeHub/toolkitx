import 'dart:convert';

DeleteDocumentModel deleteDocumentModelFromJson(String str) =>
    DeleteDocumentModel.fromJson(json.decode(str));

String deleteDocumentModelToJson(DeleteDocumentModel data) =>
    json.encode(data.toJson());

class DeleteDocumentModel {
  final int status;
  final String message;
  final Data data;

  DeleteDocumentModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory DeleteDocumentModel.fromJson(Map<String, dynamic> json) =>
      DeleteDocumentModel(
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
