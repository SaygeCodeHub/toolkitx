import 'dart:convert';

ValidateEmailModel validateEmailModelFromJson(String str) =>
    ValidateEmailModel.fromJson(json.decode(str));

String validateEmailModelToJson(ValidateEmailModel data) =>
    json.encode(data.toJson());

class ValidateEmailModel {
  final int status;
  final String message;
  final Data data;

  ValidateEmailModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ValidateEmailModel.fromJson(Map<String, dynamic> json) =>
      ValidateEmailModel(
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
