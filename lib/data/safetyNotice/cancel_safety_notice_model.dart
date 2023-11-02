import 'dart:convert';

CancelSafetyNoticeModel cancelSafetyNoticeModelFromJson(String str) =>
    CancelSafetyNoticeModel.fromJson(json.decode(str));

String cancelSafetyNoticeModelToJson(CancelSafetyNoticeModel data) =>
    json.encode(data.toJson());

class CancelSafetyNoticeModel {
  final int status;
  final String message;
  final Data data;

  CancelSafetyNoticeModel(
      {required this.status, required this.message, required this.data});

  factory CancelSafetyNoticeModel.fromJson(Map<String, dynamic> json) =>
      CancelSafetyNoticeModel(
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
