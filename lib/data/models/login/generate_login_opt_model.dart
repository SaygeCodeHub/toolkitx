import 'dart:convert';

GenerateLoginOtpModel generateOtpLoginModelFromJson(String str) =>
    GenerateLoginOtpModel.fromJson(json.decode(str));

String generateOtpLoginModelToJson(GenerateLoginOtpModel data) =>
    json.encode(data.toJson());

class GenerateLoginOtpModel {
  final int status;
  final String message;
  final Data data;

  GenerateLoginOtpModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GenerateLoginOtpModel.fromJson(Map<String, dynamic> json) =>
      GenerateLoginOtpModel(
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
