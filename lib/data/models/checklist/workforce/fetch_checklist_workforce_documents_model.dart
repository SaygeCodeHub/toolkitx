import 'dart:convert';

FetchChecklistWorkforceDocumentsModel fetchChecklistViewDocumentsModelFromJson(
        String str) =>
    FetchChecklistWorkforceDocumentsModel.fromJson(json.decode(str));

String fetchChecklistViewDocumentsModelToJson(
        FetchChecklistWorkforceDocumentsModel data) =>
    json.encode(data.toJson());

class FetchChecklistWorkforceDocumentsModel {
  final int status;
  final String message;
  final List<Datum> data;

  FetchChecklistWorkforceDocumentsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchChecklistWorkforceDocumentsModel.fromJson(
          Map<String, dynamic> json) =>
      FetchChecklistWorkforceDocumentsModel(
        status: json["Status"],
        message: json["Message"],
        data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  final int id;
  final String name;
  final String type;
  final String files;

  Datum({
    required this.id,
    required this.name,
    required this.type,
    required this.files,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        files: json["files"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "files": files,
      };
}
