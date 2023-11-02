import 'dart:convert';

DocumentsToLinkModel documentsToLinkModelFromJson(String str) =>
    DocumentsToLinkModel.fromJson(json.decode(str));

String documentsToLinkModelToJson(DocumentsToLinkModel data) =>
    json.encode(data.toJson());

class DocumentsToLinkModel {
  final int status;
  final String message;
  final List<DocumentsToLinkData> data;

  DocumentsToLinkModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory DocumentsToLinkModel.fromJson(Map<String, dynamic> json) =>
      DocumentsToLinkModel(
          status: json["Status"],
          message: json["Message"],
          data: List<DocumentsToLinkData>.from(
              json["Data"].map((x) => DocumentsToLinkData.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson()))
      };
}

class DocumentsToLinkData {
  final String id;
  final String docno;
  final String name;
  final dynamic doctype;
  final String status;

  DocumentsToLinkData(
      {required this.id,
      required this.docno,
      required this.name,
      required this.doctype,
      required this.status});

  factory DocumentsToLinkData.fromJson(Map<String, dynamic> json) =>
      DocumentsToLinkData(
          id: json["id"],
          docno: json["docno"],
          name: json["name"],
          doctype: json["doctype"] ?? '',
          status: json["status"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "docno": docno,
        "name": name,
        "doctype": doctype,
        "status": status
      };
}
