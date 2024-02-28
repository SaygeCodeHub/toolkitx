import 'dart:convert';

StartQuizModel startQuizModelFromJson(String str) =>
    StartQuizModel.fromJson(json.decode(str));

String startQuizModelToJson(StartQuizModel data) => json.encode(data.toJson());

class StartQuizModel {
  final int status;
  final String message;
  final Data data;

  StartQuizModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory StartQuizModel.fromJson(Map<String, dynamic> json) => StartQuizModel(
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
