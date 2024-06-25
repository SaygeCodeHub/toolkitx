import 'dart:convert';

SaveQuestionCommentsModel saveQuestionCommentsModelFromJson(String str) =>
    SaveQuestionCommentsModel.fromJson(json.decode(str));

String saveQuestionCommentsModelToJson(SaveQuestionCommentsModel data) =>
    json.encode(data.toJson());

class SaveQuestionCommentsModel {
  final int status;
  final String? message;
  final Data? data;

  SaveQuestionCommentsModel({
    required this.status,
    this.message,
    this.data,
  });

  factory SaveQuestionCommentsModel.fromJson(Map<String, dynamic> json) =>
      SaveQuestionCommentsModel(
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
