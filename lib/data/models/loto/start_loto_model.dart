import 'dart:convert';

StartLotoModel startLotoModelFromJson(String str) =>
    StartLotoModel.fromJson(json.decode(str));

String startLotoModelToJson(StartLotoModel data) => json.encode(data.toJson());

class StartLotoModel {
  final int status;
  final String message;
  final Data data;

  StartLotoModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory StartLotoModel.fromJson(Map<String, dynamic> json) => StartLotoModel(
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
