import 'dart:convert';

CloseSafetyNoticeModel closeSafetyNoticeModelFromJson(String str) =>
    CloseSafetyNoticeModel.fromJson(json.decode(str));

String closeSafetyNoticeModelToJson(CloseSafetyNoticeModel data) =>
    json.encode(data.toJson());

class CloseSafetyNoticeModel {
  final int status;
  final String message;
  final Data data;

  CloseSafetyNoticeModel(
      {required this.status, required this.message, required this.data});

  factory CloseSafetyNoticeModel.fromJson(Map<String, dynamic> json) =>
      CloseSafetyNoticeModel(
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
