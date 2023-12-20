import 'dart:convert';

FetchAssetsDowntimeModel fetchAssetsDowntimeModelFromJson(String str) =>
    FetchAssetsDowntimeModel.fromJson(json.decode(str));

String fetchAssetsDowntimeModelToJson(FetchAssetsDowntimeModel data) =>
    json.encode(data.toJson());

class FetchAssetsDowntimeModel {
  final int status;
  final String message;
  final List<AssetsDowntimeDatum> data;

  FetchAssetsDowntimeModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchAssetsDowntimeModel.fromJson(Map<String, dynamic> json) =>
      FetchAssetsDowntimeModel(
        status: json["Status"],
        message: json["Message"],
        data: List<AssetsDowntimeDatum>.from(
            json["Data"].map((x) => AssetsDowntimeDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class AssetsDowntimeDatum {
  final String id;
  final String startdatetime;
  final String enddatetime;
  final int totalmins;
  final String note;

  AssetsDowntimeDatum({
    required this.id,
    required this.startdatetime,
    required this.enddatetime,
    required this.totalmins,
    required this.note,
  });

  factory AssetsDowntimeDatum.fromJson(Map<String, dynamic> json) =>
      AssetsDowntimeDatum(
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
