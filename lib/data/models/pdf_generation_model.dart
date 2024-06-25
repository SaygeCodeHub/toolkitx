import 'dart:convert';

PdfGenerationModel pdfGenerationModelFromJson(String str) =>
    PdfGenerationModel.fromJson(json.decode(str));

String pdfGenerationModelToJson(PdfGenerationModel data) =>
    json.encode(data.toJson());

class PdfGenerationModel {
  final int status;
  final String message;
  final Data data;

  PdfGenerationModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory PdfGenerationModel.fromJson(Map<String, dynamic> json) =>
      PdfGenerationModel(
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
