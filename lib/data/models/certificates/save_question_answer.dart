import 'dart:convert';

SaveQuestionAnswerModel saveQuestionAnswerModelFromJson(String str) =>
    SaveQuestionAnswerModel.fromJson(json.decode(str));

String saveQuestionAnswerModelToJson(SaveQuestionAnswerModel data) =>
    json.encode(data.toJson());

class SaveQuestionAnswerModel {
  final int status;
  final String message;
  final Data data;

  SaveQuestionAnswerModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SaveQuestionAnswerModel.fromJson(Map<String, dynamic> json) =>
      SaveQuestionAnswerModel(
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
