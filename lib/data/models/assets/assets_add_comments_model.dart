import 'dart:convert';

AssetsAddCommentsModel assetsAddCommentsModelFromJson(String str) =>
    AssetsAddCommentsModel.fromJson(json.decode(str));

String assetsAddCommentsModelToJson(AssetsAddCommentsModel data) =>
    json.encode(data.toJson());

class AssetsAddCommentsModel {
  final int status;
  final String message;
  final Data data;

  AssetsAddCommentsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AssetsAddCommentsModel.fromJson(Map<String, dynamic> json) =>
      AssetsAddCommentsModel(
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
