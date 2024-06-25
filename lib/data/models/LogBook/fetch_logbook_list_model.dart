import 'dart:convert';

FetchLogBookListModel fetchLogBookListModelFromJson(String str) =>
    FetchLogBookListModel.fromJson(json.decode(str));

String fetchLogBookListModelToJson(FetchLogBookListModel data) =>
    json.encode(data.toJson());

class FetchLogBookListModel {
  final int status;
  final String message;
  final List<LogBookListDatum> data;

  FetchLogBookListModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchLogBookListModel.fromJson(Map<String, dynamic> json) =>
      FetchLogBookListModel(
        status: json["Status"],
        message: json["Message"],
        data: List<LogBookListDatum>.from(
            json["Data"].map((x) => LogBookListDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class LogBookListDatum {
  final int id;
  final String logbookname;
  final String eventdatetime;
  final String? description;
  final String status;

  LogBookListDatum({
    required this.id,
    required this.logbookname,
    required this.eventdatetime,
    this.description,
    required this.status,
  });

  factory LogBookListDatum.fromJson(Map<String, dynamic> json) =>
      LogBookListDatum(
        id: json["id"],
        logbookname: json["logbookname"],
        eventdatetime: json["eventdatetime"],
        description: json["description"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "logbookname": logbookname,
        "eventdatetime": eventdatetime,
        "description": description,
        "status": status,
      };
}
