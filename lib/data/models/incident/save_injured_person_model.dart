import 'dart:convert';

SaveInjuredPersonModel saveInjuredPersonModelFromJson(String str) =>
    SaveInjuredPersonModel.fromJson(json.decode(str));

String saveInjuredPersonModelToJson(SaveInjuredPersonModel data) =>
    json.encode(data.toJson());

class SaveInjuredPersonModel {
  final int status;
  final String message;
  final Data data;

  SaveInjuredPersonModel(
      {required this.status, required this.message, required this.data});

  factory SaveInjuredPersonModel.fromJson(Map<String, dynamic> json) =>
      SaveInjuredPersonModel(
          status: json["Status"],
          message: json["Message"],
          data: Data.fromJson(json["Data"]));

  Map<String, dynamic> toJson() =>
      {"Status": status, "Message": message, "Data": data.toJson()};
}

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}
