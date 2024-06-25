import 'dart:convert';

GetPdfModel getPdfModelFromJson(String str) =>
    GetPdfModel.fromJson(json.decode(str));

String getPdfModelToJson(GetPdfModel data) => json.encode(data.toJson());

class GetPdfModel {
  final int status;
  final String message;
  final Data? data;

  GetPdfModel({
    required this.status,
    required this.message,
    this.data,
  });

  factory GetPdfModel.fromJson(Map<String, dynamic> json) => GetPdfModel(
        status: json["Status"],
        message: json["Message"],
        data: Data.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": data!.toJson(),
      };
}

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}
