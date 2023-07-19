import 'dart:convert';

FetchPermitToLinkModel fetchPermitToLinkModelFromJson(String str) =>
    FetchPermitToLinkModel.fromJson(json.decode(str));

String fetchPermitToLinkModelToJson(FetchPermitToLinkModel data) =>
    json.encode(data.toJson());

class FetchPermitToLinkModel {
  final int? status;
  final String? message;
  final List<Datum>? data;

  FetchPermitToLinkModel({
    this.status,
    this.message,
    this.data,
  });

  factory FetchPermitToLinkModel.fromJson(Map<String, dynamic> json) =>
      FetchPermitToLinkModel(
        status: json["Status"],
        message: json["Message"],
        data: json["Data"] == null
            ? []
            : List<Datum>.from(json["Data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  final String id;
  final String permit;
  final String schedule;
  final String location;
  final String description;
  final String status;
  final String expired;
  final String? pname;
  final String? pcompany;
  final int? emergency;

  Datum({
    required this.id,
    required this.permit,
    required this.schedule,
    required this.location,
    required this.description,
    required this.status,
    required this.expired,
    this.pname,
    this.pcompany,
    this.emergency,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        permit: json["permit"],
        schedule: json["schedule"],
        location: json["location"],
        description: json["description"],
        status: json["status"],
        expired: json["expired"],
        pname: json["pname"],
        pcompany: json["pcompany"],
        emergency: json["emergency"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "permit": permit,
        "schedule": schedule,
        "location": location,
        "description": description,
        "status": status,
        "expired": expired,
        "pname": pname,
        "pcompany": pcompany,
        "emergency": emergency,
      };
}
