import 'dart:convert';

FetchIncidentLocationModel fetchIncidentLocationModelFromJson(String str) =>
    FetchIncidentLocationModel.fromJson(json.decode(str));

String fetchIncidentLocationModelToJson(FetchIncidentLocationModel data) =>
    json.encode(data.toJson());

class FetchIncidentLocationModel {
  final int status;
  final String message;
  final List<LocationDatum> data;

  FetchIncidentLocationModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchIncidentLocationModel.fromJson(Map<String, dynamic> json) =>
      FetchIncidentLocationModel(
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
  final int id;
  final String name;
  final List<Asset> assets;

  LocationDatum({
    required this.id,
    required this.name,
    required this.assets,
  });

  factory LocationDatum.fromJson(Map<String, dynamic> json) => LocationDatum(
        id: json["id"],
        name: json["name"],
        assets: json["assets"] == []
            ? []
            : List<Asset>.from(json["assets"].map((x) => Asset.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "assets": List<dynamic>.from(assets.map((x) => x.toJson())),
      };
}

class Asset {
  final int id;
  final String name;

  Asset({
    required this.id,
    required this.name,
  });

  factory Asset.fromJson(Map<String, dynamic> json) => Asset(
        id: json["id"] ?? 0,
        name: json["name"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
