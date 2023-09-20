import 'dart:convert';

DocumentsListModel documentsListModelFromJson(String str) =>
    DocumentsListModel.fromJson(json.decode(str));

String documentsListModelToJson(DocumentsListModel data) =>
    json.encode(data.toJson());

class DocumentsListModel {
  final int status;
  final String message;
  final List<DocumentsListDatum> data;

  DocumentsListModel(
      {required this.status, required this.message, required this.data});

  factory DocumentsListModel.fromJson(Map<String, dynamic> json) =>
      DocumentsListModel(
          status: json["Status"],
          message: json["Message"],
          data: List<DocumentsListDatum>.from(
              json["Data"].map((x) => DocumentsListDatum.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson()))
      };
}

class DocumentsListDatum {
  final String id;
  final String name;
  final String docno;
  final String isdue;
  final int opencommentscount;
  final int closecommentscount;
  final dynamic doctype;
  final String owner;
  final String status;

  DocumentsListDatum(
      {required this.id,
      required this.name,
      required this.docno,
      required this.isdue,
      required this.opencommentscount,
      required this.closecommentscount,
      required this.doctype,
      required this.owner,
      required this.status});

  factory DocumentsListDatum.fromJson(Map<String, dynamic> json) =>
      DocumentsListDatum(
          id: json["id"],
          name: json["name"],
          docno: json["docno"],
          isdue: json["isdue"],
          opencommentscount: json["opencommentscount"],
          closecommentscount: json["closecommentscount"],
          doctype: json["doctype"],
          owner: json["owner"],
          status: json["status"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "docno": docno,
        "isdue": isdue,
        "opencommentscount": opencommentscount,
        "closecommentscount": closecommentscount,
        "doctype": doctype,
        "owner": owner,
        "status": status
      };
}
