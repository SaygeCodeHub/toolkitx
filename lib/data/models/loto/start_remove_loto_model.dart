import 'dart:convert';

StartRemoveLotoModel startRemoveLotoModelFromJson(String str) =>
    StartRemoveLotoModel.fromJson(json.decode(str));

String startRemoveLotoModelToJson(StartRemoveLotoModel data) =>
    json.encode(data.toJson());

class StartRemoveLotoModel {
  final int status;
  final String message;
  final Data data;

  StartRemoveLotoModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory StartRemoveLotoModel.fromJson(Map<String, dynamic> json) =>
      StartRemoveLotoModel(
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
