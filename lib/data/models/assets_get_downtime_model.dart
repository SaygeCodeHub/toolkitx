import 'dart:convert';

FetchAssetsDowntimeModel fetchAssetsDowntimeModelFromJson(String str) =>
    FetchAssetsDowntimeModel.fromJson(json.decode(str));

String fetchAssetsDowntimeModelToJson(FetchAssetsDowntimeModel data) =>
    json.encode(data.toJson());

class FetchAssetsDowntimeModel {
  final int status;
  final String message;
  final List<Datum> data;

  FetchAssetsDowntimeModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchAssetsDowntimeModel.fromJson(Map<String, dynamic> json) =>
      FetchAssetsDowntimeModel(
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
  final String startdatetime;
  final String enddatetime;
  final int totalmins;
  final String note;

  Datum({
    required this.id,
    required this.startdatetime,
    required this.enddatetime,
    required this.totalmins,
    required this.note,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        startdatetime: json["startdatetime"],
        enddatetime: json["enddatetime"],
        totalmins: json["totalmins"],
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "startdatetime": startdatetime,
        "enddatetime": enddatetime,
        "totalmins": totalmins,
        "note": note,
      };
}
