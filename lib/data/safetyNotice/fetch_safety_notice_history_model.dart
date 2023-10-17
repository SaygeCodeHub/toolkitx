import 'dart:convert';

FetchHistorySafetyNoticeModel fetchHistorySafetyNoticeModelFromJson(
        String str) =>
    FetchHistorySafetyNoticeModel.fromJson(json.decode(str));

String fetchHistorySafetyNoticeModelToJson(
        FetchHistorySafetyNoticeModel data) =>
    json.encode(data.toJson());

class FetchHistorySafetyNoticeModel {
  final int status;
  final String message;
  final Data data;

  FetchHistorySafetyNoticeModel(
      {required this.status, required this.message, required this.data});

  factory FetchHistorySafetyNoticeModel.fromJson(Map<String, dynamic> json) =>
      FetchHistorySafetyNoticeModel(
        status: json["Status"],
        message: json["Message"],
        data: Data.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": data.toJson(),
      };
}

class Data {
  final String canAdd;
  final List<HistoryNotice> noticesHistoryDatum;

  Data({required this.canAdd, required this.noticesHistoryDatum});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        canAdd: json["can_add"],
        noticesHistoryDatum: List<HistoryNotice>.from(
            json["notices"].map((x) => HistoryNotice.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "can_add": canAdd,
        "notices":
            List<dynamic>.from(noticesHistoryDatum.map((x) => x.toJson())),
      };
}

class HistoryNotice {
  final String id;
  final String refno;
  final String datetime;
  final String notice;
  final String status;

  HistoryNotice(
      {required this.id,
      required this.refno,
      required this.datetime,
      required this.notice,
      required this.status});

  factory HistoryNotice.fromJson(Map<String, dynamic> json) => HistoryNotice(
        id: json["id"] ?? '',
        refno: json["refno"] ?? '',
        datetime: json["datetime"] ?? '',
        notice: json["notice"] ?? '',
        status: json["status"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "refno": refno,
        "datetime": datetime,
        "notice": notice,
        "status": status,
      };
}
