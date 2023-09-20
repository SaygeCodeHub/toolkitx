import 'dart:convert';

FinishQuizCertificateModel finishQuizCertificateModelFromJson(String str) =>
    FinishQuizCertificateModel.fromJson(json.decode(str));

String finishQuizCertificateModelToJson(FinishQuizCertificateModel data) =>
    json.encode(data.toJson());

class FinishQuizCertificateModel {
  final int status;
  final String message;
  final Data data;

  FinishQuizCertificateModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FinishQuizCertificateModel.fromJson(Map<String, dynamic> json) =>
      FinishQuizCertificateModel(
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
