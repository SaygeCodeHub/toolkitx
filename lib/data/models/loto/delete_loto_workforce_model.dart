import 'dart:convert';

DeleteLotoWorkforceModel deleteLotoWorkforceModelFromJson(String str) =>
    DeleteLotoWorkforceModel.fromJson(json.decode(str));

String deleteLotoWorkforceModelToJson(DeleteLotoWorkforceModel data) =>
    json.encode(data.toJson());

class DeleteLotoWorkforceModel {
  final int? status;
  final String? message;
  final Data? data;

  DeleteLotoWorkforceModel({
    this.status,
    this.message,
    this.data,
  });

  factory DeleteLotoWorkforceModel.fromJson(Map<String, dynamic> json) =>
      DeleteLotoWorkforceModel(
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
