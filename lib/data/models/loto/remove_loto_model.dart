import 'dart:convert';

RemoveLotoModel removeLotoModelFromJson(String str) =>
    RemoveLotoModel.fromJson(json.decode(str));

String removeLotoModelToJson(RemoveLotoModel data) =>
    json.encode(data.toJson());

class RemoveLotoModel {
  final int status;
  final String message;
  final Data data;

  RemoveLotoModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory RemoveLotoModel.fromJson(Map<String, dynamic> json) =>
      RemoveLotoModel(
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
