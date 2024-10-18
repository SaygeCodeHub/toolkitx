import 'dart:convert';

GenerateSwitchingSchedulePdfModel generateSwitchingSchedulePdfModelFromJson(
        String str) =>
    GenerateSwitchingSchedulePdfModel.fromJson(json.decode(str));

String generateSwitchingSchedulePdfModelToJson(
        GenerateSwitchingSchedulePdfModel data) =>
    json.encode(data.toJson());

class GenerateSwitchingSchedulePdfModel {
  final int status;
  final String message;
  final Data data;

  GenerateSwitchingSchedulePdfModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GenerateSwitchingSchedulePdfModel.fromJson(
          Map<String, dynamic> json) =>
      GenerateSwitchingSchedulePdfModel(
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
