import 'dart:convert';

FetchAssetsMasterModel fetchAssetsMasterModelFromJson(String str) =>
    FetchAssetsMasterModel.fromJson(json.decode(str));

String fetchAssetsMasterModelToJson(FetchAssetsMasterModel data) =>
    json.encode(data.toJson());

class FetchAssetsMasterModel {
  final int status;
  final String message;
  final List<List<Datum>> data;

  FetchAssetsMasterModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchAssetsMasterModel.fromJson(Map<String, dynamic> json) =>
      FetchAssetsMasterModel(
        status: json["Status"],
        message: json["Message"],
        data: List<List<Datum>>.from(json["Data"]
            .map((x) => List<Datum>.from(x.map((x) => Datum.fromJson(x))))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(
            data.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
      };
}

class Datum {
  final int id;
  final String name;
  final String assetstatus;
  final dynamic active;
  final String created;
  final dynamic createdby;
  final String updated;
  final dynamic updateby;
  final String meter;
  final String failureSetCode;

  Datum({
    required this.id,
    required this.name,
    required this.assetstatus,
    required this.active,
    required this.created,
    required this.createdby,
    required this.updated,
    required this.updateby,
    required this.meter,
    required this.failureSetCode,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] ?? '',
        name: json["name"] ?? '',
        assetstatus: json["assetstatus"] ?? '',
        active: json["active"] ?? '',
        created: json["created"] ?? '',
        createdby: json["createdby"] ?? '',
        updated: json["updated"] ?? '',
        updateby: json["updateby"] ?? '',
        meter: json["meter"] ?? '',
        failureSetCode: json["Failure_set_code"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "assetstatus": assetstatus,
        "active": active,
        "created": created,
        "createdby": createdby,
        "updated": updated,
        "updateby": updateby,
        "meter": meter,
        "Failure_set_code": failureSetCode,
      };
}
