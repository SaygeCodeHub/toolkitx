
import 'dart:convert';

FetchAddAssetsDocumentModel fetchAddAssetsDocumentModelFromJson(String str) => FetchAddAssetsDocumentModel.fromJson(json.decode(str));

String fetchAddAssetsDocumentModelToJson(FetchAddAssetsDocumentModel data) => json.encode(data.toJson());

class FetchAddAssetsDocumentModel {
  final int status;
  final String message;
  final List<AddDocumentDatum> data;

  FetchAddAssetsDocumentModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchAddAssetsDocumentModel.fromJson(Map<String, dynamic> json) => FetchAddAssetsDocumentModel(
    status: json["Status"],
    message: json["Message"],
    data: List<AddDocumentDatum>.from(json["Data"].map((x) => AddDocumentDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class AddDocumentDatum {
  final String docid;
  final String docname;
  final String doctypename;

  AddDocumentDatum({
    required this.docid,
    required this.docname,
    required this.doctypename,
  });

  factory AddDocumentDatum.fromJson(Map<String, dynamic> json) => AddDocumentDatum(
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
