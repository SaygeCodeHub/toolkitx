import 'dart:convert';

FetchLocationAssetsModel fetchLocationAssetsModelFromJson(String str) =>
    FetchLocationAssetsModel.fromJson(json.decode(str));

String fetchLocationAssetsModelToJson(FetchLocationAssetsModel data) =>
    json.encode(data.toJson());

class FetchLocationAssetsModel {
  final int status;
  final String message;
  final List<LocationAssetsDatum> data;

  FetchLocationAssetsModel(
      {required this.status, required this.message, required this.data});

  factory FetchLocationAssetsModel.fromJson(Map<String, dynamic> json) =>
      FetchLocationAssetsModel(
        status: json["Status"],
        message: json["Message"],
        data: List<LocationAssetsDatum>.from(
            json["Data"].map((x) => LocationAssetsDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class LocationAssetsDatum {
  final String id;
  final String name;
  final String locationname;
  final String tag;
  final String status;

  LocationAssetsDatum(
      {required this.id,
      required this.name,
      required this.locationname,
      required this.tag,
      required this.status});

  factory LocationAssetsDatum.fromJson(Map<String, dynamic> json) =>
      LocationAssetsDatum(
          id: json["id"] ?? '',
          name: json["name"] ?? '',
          locationname: json["locationname"] ?? '',
          tag: json["tag"] ?? '',
          status: json["status"] ?? '');

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "locationname": locationname,
        "tag": tag,
        "status": status
      };
}
