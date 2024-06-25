import 'dart:convert';

AssetsDeleteDowntimeModel assetsDeleteDowntimeModelFromJson(String str) =>
    AssetsDeleteDowntimeModel.fromJson(json.decode(str));

String assetsDeleteDowntimeModelToJson(AssetsDeleteDowntimeModel data) =>
    json.encode(data.toJson());

class AssetsDeleteDowntimeModel {
  final int status;
  final String message;
  final Data data;

  AssetsDeleteDowntimeModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AssetsDeleteDowntimeModel.fromJson(Map<String, dynamic> json) =>
      AssetsDeleteDowntimeModel(
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
