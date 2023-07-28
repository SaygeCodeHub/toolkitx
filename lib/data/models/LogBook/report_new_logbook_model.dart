import 'dart:convert';

ReportNewLogBookModel reportNewLogBookModelFromJson(String str) =>
    ReportNewLogBookModel.fromJson(json.decode(str));

String reportNewLogBookModelToJson(ReportNewLogBookModel data) =>
    json.encode(data.toJson());

class ReportNewLogBookModel {
  final int status;
  final String message;
  final Data data;

  ReportNewLogBookModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ReportNewLogBookModel.fromJson(Map<String, dynamic> json) =>
      ReportNewLogBookModel(
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
