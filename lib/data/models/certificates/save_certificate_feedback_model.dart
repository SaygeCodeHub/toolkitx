import 'dart:convert';

SaveCertificateFeedbackModel saveCertificateFeedbackModelFromJson(String str) =>
    SaveCertificateFeedbackModel.fromJson(json.decode(str));

String saveCertificateFeedbackModelToJson(SaveCertificateFeedbackModel data) =>
    json.encode(data.toJson());

class SaveCertificateFeedbackModel {
  final int? status;
  final String? message;
  final Data? data;

  SaveCertificateFeedbackModel({
    this.status,
    this.message,
    this.data,
  });

  factory SaveCertificateFeedbackModel.fromJson(Map<String, dynamic> json) =>
      SaveCertificateFeedbackModel(
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
