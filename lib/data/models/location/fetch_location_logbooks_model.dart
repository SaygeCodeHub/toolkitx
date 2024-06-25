import 'dart:convert';

FetchLocationLogBookModel fetchLocationLogBookModelFromJson(String str) =>
    FetchLocationLogBookModel.fromJson(json.decode(str));

String fetchLocationLogBookModelToJson(FetchLocationLogBookModel data) =>
    json.encode(data.toJson());

class FetchLocationLogBookModel {
  final int status;
  final String message;
  final List<LocationLogBooksDatum> data;

  FetchLocationLogBookModel(
      {required this.status, required this.message, required this.data});

  factory FetchLocationLogBookModel.fromJson(Map<String, dynamic> json) =>
      FetchLocationLogBookModel(
        status: json["Status"],
        message: json["Message"],
        data: List<LocationLogBooksDatum>.from(
            json["Data"].map((x) => LocationLogBooksDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class LocationLogBooksDatum {
  final int id;
  final String logbookname;
  final String eventdatetime;
  final String description;
  final String status;

  LocationLogBooksDatum(
      {required this.id,
      required this.logbookname,
      required this.eventdatetime,
      required this.description,
      required this.status});

  factory LocationLogBooksDatum.fromJson(Map<String, dynamic> json) =>
      LocationLogBooksDatum(
          id: json["id"] ?? '',
          logbookname: json["logbookname"] ?? '',
          eventdatetime: json["eventdatetime"] ?? '',
          description: json["description"] ?? '',
          status: json["status"] ?? '');

  Map<String, dynamic> toJson() => {
        "id": id,
        "logbookname": logbookname,
        "eventdatetime": eventdatetime,
        "description": description,
        "status": status
      };
}
