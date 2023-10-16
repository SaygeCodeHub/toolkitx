import 'dart:convert';

HoldSafetyNoticeModel holdSafetyNoticeModelFromJson(String str) =>
    HoldSafetyNoticeModel.fromJson(json.decode(str));

String holdSafetyNoticeModelToJson(HoldSafetyNoticeModel data) =>
    json.encode(data.toJson());

class HoldSafetyNoticeModel {
  final int status;
  final String message;
  final Data data;

  HoldSafetyNoticeModel(
      {required this.status, required this.message, required this.data});

  factory HoldSafetyNoticeModel.fromJson(Map<String, dynamic> json) =>
      HoldSafetyNoticeModel(
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
