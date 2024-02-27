import 'dart:convert';

DocumentUploadFileVersionModel documentUploadFileVersionModelFromJson(
        String str) =>
    DocumentUploadFileVersionModel.fromJson(json.decode(str));

String documentUploadFileVersionModelToJson(
        DocumentUploadFileVersionModel data) =>
    json.encode(data.toJson());

class DocumentUploadFileVersionModel {
  final int status;
  final String message;
  final Data data;

  DocumentUploadFileVersionModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory DocumentUploadFileVersionModel.fromJson(Map<String, dynamic> json) =>
      DocumentUploadFileVersionModel(
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
