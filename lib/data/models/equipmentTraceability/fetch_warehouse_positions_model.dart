import 'dart:convert';

FetchWarehousePositionsModel fetchWarehousePositionsModelFromJson(String str) =>
    FetchWarehousePositionsModel.fromJson(json.decode(str));

String fetchWarehousePositionsModelToJson(FetchWarehousePositionsModel data) =>
    json.encode(data.toJson());

class FetchWarehousePositionsModel {
  final int status;
  final String message;
  final List<Datum> data;

  FetchWarehousePositionsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchWarehousePositionsModel.fromJson(Map<String, dynamic> json) =>
      FetchWarehousePositionsModel(
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
