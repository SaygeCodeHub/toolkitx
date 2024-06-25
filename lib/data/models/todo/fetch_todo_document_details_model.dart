import 'dart:convert';

FetchToDoDocumentDetailsModel fetchToDoDocumentDetailsModelFromJson(
        String str) =>
    FetchToDoDocumentDetailsModel.fromJson(json.decode(str));

String fetchToDoDocumentDetailsModelToJson(
        FetchToDoDocumentDetailsModel data) =>
    json.encode(data.toJson());

class FetchToDoDocumentDetailsModel {
  final int status;
  final String message;
  final List<ToDoDocumentDetailsDatum> documentDetailsDatum;

  FetchToDoDocumentDetailsModel({
    required this.status,
    required this.message,
    required this.documentDetailsDatum,
  });

  factory FetchToDoDocumentDetailsModel.fromJson(Map<String, dynamic> json) =>
      FetchToDoDocumentDetailsModel(
        status: json["Status"],
        message: json["Message"],
        documentDetailsDatum: List<ToDoDocumentDetailsDatum>.from(
            json["Data"].map((x) => ToDoDocumentDetailsDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(documentDetailsDatum.map((x) => x.toJson())),
      };
}

class ToDoDocumentDetailsDatum {
  final String tododocid;
  final String docid;
  final String docname;
  final String doctypename;
  final dynamic files;

  ToDoDocumentDetailsDatum({
    required this.tododocid,
    required this.docid,
    required this.docname,
    required this.doctypename,
    this.files,
  });

  factory ToDoDocumentDetailsDatum.fromJson(Map<String, dynamic> json) =>
      ToDoDocumentDetailsDatum(
        tododocid: json["tododocid"],
        docid: json["docid"],
        docname: json["docname"],
        doctypename: json["doctypename"] ?? '',
        files: json["files"],
      );

  Map<String, dynamic> toJson() => {
        "tododocid": tododocid,
        "docid": docid,
        "docname": docname,
        "doctypename": doctypename,
        "files": files,
      };
}
