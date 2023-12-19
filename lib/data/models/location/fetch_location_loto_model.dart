import 'dart:convert';

FetchLocationLoToModel fetchLocationLotoModelFromJson(String str) =>
    FetchLocationLoToModel.fromJson(json.decode(str));

String fetchLocationLoToModelToJson(FetchLocationLoToModel data) =>
    json.encode(data.toJson());

class FetchLocationLoToModel {
  final int status;
  final String message;
  final List<LocationLotoDatum> data;

  FetchLocationLoToModel(
      {required this.status, required this.message, required this.data});

  factory FetchLocationLoToModel.fromJson(Map<String, dynamic> json) =>
      FetchLocationLoToModel(
        status: json["Status"],
        message: json["Message"],
        data: List<LocationLotoDatum>.from(
            json["Data"].map((x) => LocationLotoDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class LocationLotoDatum {
  final String id;
  final String name;
  final String date;
  final String location;
  final String purpose;
  final String status;

  LocationLotoDatum(
      {required this.id,
      required this.name,
      required this.date,
      required this.location,
      required this.purpose,
      required this.status});

  factory LocationLotoDatum.fromJson(Map<String, dynamic> json) =>
      LocationLotoDatum(
          id: json["id"] ?? '',
          name: json["name"] ?? '',
          date: json["date"] ?? '',
          location: json["location"] ?? '',
          purpose: json["purpose"] ?? '',
          status: json["status"] ?? '');

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "date": date,
        "location": location,
        "purpose": purpose,
        "status": status,
      };
}
