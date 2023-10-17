import 'dart:convert';

ReIssueSafetyNoticeModel reIssueSafetyNoticeModelFromJson(String str) =>
    ReIssueSafetyNoticeModel.fromJson(json.decode(str));

String reIssueSafetyNoticeModelToJson(ReIssueSafetyNoticeModel data) =>
    json.encode(data.toJson());

class ReIssueSafetyNoticeModel {
  final int status;
  final String message;
  final Data data;

  ReIssueSafetyNoticeModel(
      {required this.status, required this.message, required this.data});

  factory ReIssueSafetyNoticeModel.fromJson(Map<String, dynamic> json) =>
      ReIssueSafetyNoticeModel(
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