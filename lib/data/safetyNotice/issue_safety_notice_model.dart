import 'dart:convert';

IssueSafetyNoticeModel issueSafetyNoticeModelFromJson(String str) =>
    IssueSafetyNoticeModel.fromJson(json.decode(str));

String issueSafetyNoticeModelToJson(IssueSafetyNoticeModel data) =>
    json.encode(data.toJson());

class IssueSafetyNoticeModel {
  final int status;
  final String message;
  final Data data;

  IssueSafetyNoticeModel(
      {required this.status, required this.message, required this.data});

  factory IssueSafetyNoticeModel.fromJson(Map<String, dynamic> json) =>
      IssueSafetyNoticeModel(
        status: json["Status"],
        message: json["Message"],
        data: Data.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() =>
      {"Status": status, "Message": message, "Data": data.toJson()};
}

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}
