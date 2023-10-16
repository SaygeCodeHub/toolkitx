import 'dart:convert';

UpdatingSafetyNoticeModel updatingSafetyNoticeModelFromJson(String str) =>
    UpdatingSafetyNoticeModel.fromJson(json.decode(str));

String updatingSafetyNoticeModelToJson(UpdatingSafetyNoticeModel data) =>
    json.encode(data.toJson());

class UpdatingSafetyNoticeModel {
  final int status;
  final String message;
  final Data data;

  UpdatingSafetyNoticeModel(
      {required this.status, required this.message, required this.data});

  factory UpdatingSafetyNoticeModel.fromJson(Map<String, dynamic> json) =>
      UpdatingSafetyNoticeModel(
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
