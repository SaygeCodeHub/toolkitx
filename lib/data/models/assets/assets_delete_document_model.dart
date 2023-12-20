import 'dart:convert';

AssetsDeleteDocumentModel assetsDeleteDocumentModelFromJson(String str) =>
    AssetsDeleteDocumentModel.fromJson(json.decode(str));

String assetsDeleteDocumentModelToJson(AssetsDeleteDocumentModel data) =>
    json.encode(data.toJson());

class AssetsDeleteDocumentModel {
  final int status;
  final String message;
  final Data data;

  AssetsDeleteDocumentModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AssetsDeleteDocumentModel.fromJson(Map<String, dynamic> json) =>
      AssetsDeleteDocumentModel(
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
