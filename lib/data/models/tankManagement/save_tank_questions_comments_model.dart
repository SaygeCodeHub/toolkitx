import 'dart:convert';

SaveTankQuestionCommentsModel saveTankQuestionCommentsModelFromJson(
        String str) =>
    SaveTankQuestionCommentsModel.fromJson(json.decode(str));

String saveTankQuestionCommentsModelToJson(
        SaveTankQuestionCommentsModel data) =>
    json.encode(data.toJson());

class SaveTankQuestionCommentsModel {
  final int status;
  final String message;
  final Data data;

  SaveTankQuestionCommentsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SaveTankQuestionCommentsModel.fromJson(Map<String, dynamic> json) =>
      SaveTankQuestionCommentsModel(
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
