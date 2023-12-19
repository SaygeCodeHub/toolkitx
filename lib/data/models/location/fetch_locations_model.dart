import 'dart:convert';

FetchLocationsModel fetchLocationsModelFromJson(String str) =>
    FetchLocationsModel.fromJson(json.decode(str));

String fetchLocationsModelToJson(FetchLocationsModel data) =>
    json.encode(data.toJson());

class FetchLocationsModel {
  final int status;
  final String message;
  final List<LocationDatum> data;

  FetchLocationsModel(
      {required this.status, required this.message, required this.data});

  factory FetchLocationsModel.fromJson(Map<String, dynamic> json) =>
      FetchLocationsModel(
        status: json["Status"],
        message: json["Message"],
        data: List<LocationDatum>.from(
            json["Data"].map((x) => LocationDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class LocationDatum {
  final String id;
  final String name;
  final String maptype;

  LocationDatum({required this.id, required this.name, required this.maptype});

  factory LocationDatum.fromJson(Map<String, dynamic> json) => LocationDatum(
      id: json["id"], name: json["name"] ?? '', maptype: json["maptype"] ?? '');

  Map<String, dynamic> toJson() => {"id": id, "name": name, "maptype": maptype};
}
