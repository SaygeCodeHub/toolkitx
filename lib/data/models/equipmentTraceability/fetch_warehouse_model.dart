import 'dart:convert';

FetchWarehouseModel fetchWarehouseModelFromJson(String str) =>
    FetchWarehouseModel.fromJson(json.decode(str));

String fetchWarehouseModelToJson(FetchWarehouseModel data) =>
    json.encode(data.toJson());

class FetchWarehouseModel {
  final int status;
  final String message;
  final List<Datum> data;

  FetchWarehouseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchWarehouseModel.fromJson(Map<String, dynamic> json) =>
      FetchWarehouseModel(
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

  Datum({
    required this.id,
    required this.name,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
