import 'dart:convert';

ChangePermitCpModel changePermitCpModelFromJson(String str) =>
    ChangePermitCpModel.fromJson(json.decode(str));

String changePermitCpModelToJson(ChangePermitCpModel data) =>
    json.encode(data.toJson());

class ChangePermitCpModel {
  final int? status;
  final String? message;
  final Data? data;

  ChangePermitCpModel({
    this.status,
    this.message,
    this.data,
  });

  factory ChangePermitCpModel.fromJson(Map<String, dynamic> json) =>
      ChangePermitCpModel(
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
