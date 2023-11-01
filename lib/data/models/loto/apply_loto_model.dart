import 'dart:convert';

ApplyLotoModel applyLotoModelFromJson(String str) =>
    ApplyLotoModel.fromJson(json.decode(str));

String applyLotoModelToJson(ApplyLotoModel data) => json.encode(data.toJson());

class ApplyLotoModel {
  final int status;
  final String message;
  final Data data;

  ApplyLotoModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ApplyLotoModel.fromJson(Map<String, dynamic> json) => ApplyLotoModel(
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
