import 'dart:convert';

SubmitQuestionModel submitQuestionModelFromJson(String str) =>
    SubmitQuestionModel.fromJson(json.decode(str));

String submitQuestionModelToJson(SubmitQuestionModel data) =>
    json.encode(data.toJson());

class SubmitQuestionModel {
  final int status;
  final String? message;
  final Data? data;

  SubmitQuestionModel({
    required this.status,
    this.message,
    this.data,
  });

  factory SubmitQuestionModel.fromJson(Map<String, dynamic> json) =>
      SubmitQuestionModel(
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
