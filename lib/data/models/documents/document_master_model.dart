import 'dart:convert';

FetchDocumentMasterModel fetchDocumentMasterModelFromJson(String str) =>
    FetchDocumentMasterModel.fromJson(json.decode(str));

String fetchDocumentMasterModelToJson(FetchDocumentMasterModel data) =>
    json.encode(data.toJson());

class FetchDocumentMasterModel {
  final int status;
  final String message;
  final List<List<Datum>> data;

  FetchDocumentMasterModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchDocumentMasterModel.fromJson(Map<String, dynamic> json) =>
      FetchDocumentMasterModel(
        status: json["Status"],
        message: json["Message"],
        data: List<List<Datum>>.from(json["Data"]
            .map((x) => List<Datum>.from(x.map((x) => Datum.fromJson(x))))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(
            data.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
      };
}

class Datum {
  final int id;
  final String name;
  final dynamic notes;

  Datum({
    required this.id,
    required this.name,
    required this.notes,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        notes: json["notes"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "notes": notes,
      };
}
