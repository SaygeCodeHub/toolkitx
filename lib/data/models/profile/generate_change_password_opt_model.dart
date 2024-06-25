import 'dart:convert';

GenerateChangePasswordOtpModel generateChangePasswordOtpModelFromJson(
        String str) =>
    GenerateChangePasswordOtpModel.fromJson(json.decode(str));

String generateChangePasswordOtpModelToJson(
        GenerateChangePasswordOtpModel data) =>
    json.encode(data.toJson());

class GenerateChangePasswordOtpModel {
  final int? status;
  final String? message;
  final Data? data;

  GenerateChangePasswordOtpModel({
    this.status,
    this.message,
    this.data,
  });

  factory GenerateChangePasswordOtpModel.fromJson(Map<String, dynamic> json) =>
      GenerateChangePasswordOtpModel(
        status: json["Status"],
        message: json["Message"],
        data: Data.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": data!.toJson(),
      };
}

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}
