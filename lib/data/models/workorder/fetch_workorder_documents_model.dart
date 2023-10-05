import 'dart:convert';

FetchWorkOrderDocumentsModel assignWorkOrderModelFromJson(String str) =>
    FetchWorkOrderDocumentsModel.fromJson(json.decode(str));

String assignWorkOrderModelToJson(FetchWorkOrderDocumentsModel data) =>
    json.encode(data.toJson());

class FetchWorkOrderDocumentsModel {
  final int status;
  final String message;
  final List<Datum> data;

  FetchWorkOrderDocumentsModel(
      {required this.status, required this.message, required this.data});

  factory FetchWorkOrderDocumentsModel.fromJson(Map<String, dynamic> json) =>
      FetchWorkOrderDocumentsModel(
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
  final String docid;
  final String docname;
  final String doctypename;

  Datum({
    required this.docid,
    required this.docname,
    required this.doctypename,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        docid: json["docid"],
        docname: json["docname"] ?? '',
        doctypename: json["doctypename"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "docid": docid,
        "docname": docname,
        "doctypename": doctypename,
      };
}
