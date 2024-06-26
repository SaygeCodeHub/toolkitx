import 'dart:convert';

AddSafetyNoticeModel addSafetyNoticeModelFromJson(String str) =>
    AddSafetyNoticeModel.fromJson(json.decode(str));

String addSafetyNoticeModelToJson(AddSafetyNoticeModel data) =>
    json.encode(data.toJson());

class AddSafetyNoticeModel {
  final int status;
  final String message;
  final Data data;

  AddSafetyNoticeModel(
      {required this.status, required this.message, required this.data});

  factory AddSafetyNoticeModel.fromJson(Map<String, dynamic> json) =>
      AddSafetyNoticeModel(
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
