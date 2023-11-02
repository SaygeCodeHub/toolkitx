import 'dart:convert';

SaveAssetsDowntimeModel saveAssetsDowntimeModelFromJson(String str) =>
    SaveAssetsDowntimeModel.fromJson(json.decode(str));

String saveAssetsDowntimeModelToJson(SaveAssetsDowntimeModel data) =>
    json.encode(data.toJson());

class SaveAssetsDowntimeModel {
  final int status;
  final String message;
  final Data data;

  SaveAssetsDowntimeModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SaveAssetsDowntimeModel.fromJson(Map<String, dynamic> json) =>
      SaveAssetsDowntimeModel(
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
