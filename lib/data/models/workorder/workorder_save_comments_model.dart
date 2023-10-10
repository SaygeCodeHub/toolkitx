import 'dart:convert';

SaveWorkOrderCommentsModel saveWorkOrderCommentsModelFromJson(String str) =>
    SaveWorkOrderCommentsModel.fromJson(json.decode(str));

String saveWorkOrderCommentsModelToJson(SaveWorkOrderCommentsModel data) =>
    json.encode(data.toJson());

class SaveWorkOrderCommentsModel {
  final int status;
  final String message;
  final Data data;

  SaveWorkOrderCommentsModel(
      {required this.status, required this.message, required this.data});

  factory SaveWorkOrderCommentsModel.fromJson(Map<String, dynamic> json) =>
      SaveWorkOrderCommentsModel(
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
