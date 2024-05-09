import 'dart:convert';

SaveMarkAsPreparedModel saveMarkAsPreparedModelFromJson(String str) =>
    SaveMarkAsPreparedModel.fromJson(json.decode(str));

String saveMarkAsPreparedModelToJson(SaveMarkAsPreparedModel data) =>
    json.encode(data.toJson());

class SaveMarkAsPreparedModel {
  final int? status;
  final String? message;
  final Data? data;

  SaveMarkAsPreparedModel({
    this.status,
    this.message,
    this.data,
  });

  factory SaveMarkAsPreparedModel.fromJson(Map<String, dynamic> json) =>
      SaveMarkAsPreparedModel(
        status: json["Status"],
        message: json["Message"],
        data: json["Data"] == null ? null : Data.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": data?.toJson(),
      };
}

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}
