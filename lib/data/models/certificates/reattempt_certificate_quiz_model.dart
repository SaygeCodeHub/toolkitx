import 'dart:convert';

ReattemptCertificateQuizModel reattemptCertificateQuizModelFromJson(
        String str) =>
    ReattemptCertificateQuizModel.fromJson(json.decode(str));

String reattemptCertificateQuizModelToJson(
        ReattemptCertificateQuizModel data) =>
    json.encode(data.toJson());

class ReattemptCertificateQuizModel {
  final int status;
  final String message;
  final Data data;

  ReattemptCertificateQuizModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ReattemptCertificateQuizModel.fromJson(Map<String, dynamic> json) =>
      ReattemptCertificateQuizModel(
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
