import 'dart:convert';

FetchAssetsListModel fetchAssetsListModelFromJson(String str) =>
    FetchAssetsListModel.fromJson(json.decode(str));

String fetchAssetsListModelToJson(FetchAssetsListModel data) =>
    json.encode(data.toJson());

class FetchAssetsListModel {
  final int status;
  final String message;
  final List<Datum> data;

  FetchAssetsListModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchAssetsListModel.fromJson(Map<String, dynamic> json) =>
      FetchAssetsListModel(
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
  final String id;
  final String name;
  final String locationname;
  final String tag;
  final String status;

  Datum({
    required this.id,
    required this.name,
    required this.locationname,
    required this.tag,
    required this.status,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        locationname: json["locationname"],
        tag: json["tag"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "locationname": locationname,
        "tag": tag,
        "status": status,
      };
}
