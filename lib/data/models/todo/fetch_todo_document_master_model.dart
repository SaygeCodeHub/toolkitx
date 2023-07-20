import 'dart:convert';

FetchToDoDocumentMasterModel fetchToDoDocumentMasterModelFromJson(String str) =>
    FetchToDoDocumentMasterModel.fromJson(json.decode(str));

String fetchToDoDocumentMasterModelToJson(FetchToDoDocumentMasterModel data) =>
    json.encode(data.toJson());

class FetchToDoDocumentMasterModel {
  final int status;
  final String message;
  final List<List<ToDoDocumentMasterDatum>> data;

  FetchToDoDocumentMasterModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchToDoDocumentMasterModel.fromJson(Map<String, dynamic> json) =>
      FetchToDoDocumentMasterModel(
        status: json["Status"],
        message: json["Message"],
        data: List<List<ToDoDocumentMasterDatum>>.from(json["Data"].map((x) =>
            List<ToDoDocumentMasterDatum>.from(
                x.map((x) => ToDoDocumentMasterDatum.fromJson(x))))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(
            data.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
      };
}

class ToDoDocumentMasterDatum {
  final int id;
  final String name;
  final String notes;

  ToDoDocumentMasterDatum({
    required this.id,
    required this.name,
    required this.notes,
  });

  factory ToDoDocumentMasterDatum.fromJson(Map<String, dynamic> json) =>
      ToDoDocumentMasterDatum(
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
