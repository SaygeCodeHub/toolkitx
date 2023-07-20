import 'dart:convert';

FetchDocumentForToDoModel toDoMarkAsDoneModelFromJson(String str) =>
    FetchDocumentForToDoModel.fromJson(json.decode(str));

String toDoMarkAsDoneModelToJson(FetchDocumentForToDoModel data) =>
    json.encode(data.toJson());

class FetchDocumentForToDoModel {
  final int? status;
  final String? message;
  final List<FetchToDoDocumentDatum>? fetchDocumentDatum;

  FetchDocumentForToDoModel({
    this.status,
    this.message,
    this.fetchDocumentDatum,
  });

  factory FetchDocumentForToDoModel.fromJson(Map<String, dynamic> json) =>
      FetchDocumentForToDoModel(
        status: json["Status"],
        message: json["Message"],
        fetchDocumentDatum: List<FetchToDoDocumentDatum>.from(
            json["Data"].map((x) => FetchToDoDocumentDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(fetchDocumentDatum!.map((x) => x.toJson())),
      };
}

class FetchToDoDocumentDatum {
  final String docid;
  final String docname;
  final String doctypename;

  FetchToDoDocumentDatum({
    required this.docid,
    required this.docname,
    required this.doctypename,
  });

  factory FetchToDoDocumentDatum.fromJson(Map<String, dynamic> json) =>
      FetchToDoDocumentDatum(
        docid: json["docid"],
        docname: json["docname"],
        doctypename: json["doctypename"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "docid": docid,
        "docname": docname,
        "doctypename": doctypename,
      };
}
