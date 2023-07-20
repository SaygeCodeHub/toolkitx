import 'dart:convert';

FetchLogBookListModel fetchLogBookListModelFromJson(String str) =>
    FetchLogBookListModel.fromJson(json.decode(str));

String fetchLogBookListModelToJson(FetchLogBookListModel data) =>
    json.encode(data.toJson());

class FetchLogBookListModel {
  final int status;
  final String message;
  final List<Datum> data;

  FetchLogBookListModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchLogBookListModel.fromJson(Map<String, dynamic> json) =>
      FetchLogBookListModel(
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
  final String logbookname;
  final String eventdatetime;
  final String? description;
  final String status;

  Datum({
    required this.id,
    required this.logbookname,
    required this.eventdatetime,
    this.description,
    required this.status,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
