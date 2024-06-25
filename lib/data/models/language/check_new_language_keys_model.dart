import 'dart:convert';

CheckNewLanguageKeysModel downloadLanguageModelFromJson(String str) =>
    CheckNewLanguageKeysModel.fromJson(json.decode(str));

String downloadLanguageModelToJson(CheckNewLanguageKeysModel data) =>
    json.encode(data.toJson());

class CheckNewLanguageKeysModel {
  final int status;
  final String message;
  final Data data;

  CheckNewLanguageKeysModel(
      {required this.status, required this.message, required this.data});

  factory CheckNewLanguageKeysModel.fromJson(Map<String, dynamic> json) =>
      CheckNewLanguageKeysModel(
          status: json["Status"],
          message: json["Message"],
          data: Data.fromJson(json["Data"]));

  Map<String, dynamic> toJson() =>
      {"Status": status, "Message": message, "Data": data.toJson()};
}

class Data {
  final String download;

  Data({required this.download});

  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(download: json["download"]);

  Map<String, dynamic> toJson() => {"download": download};
}
