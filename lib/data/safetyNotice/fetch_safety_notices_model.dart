import 'dart:convert';

FetchSafetyNoticesModel fetchSafetyNoticesModelFromJson(String str) =>
    FetchSafetyNoticesModel.fromJson(json.decode(str));

String fetchSafetyNoticesModelToJson(FetchSafetyNoticesModel data) =>
    json.encode(data.toJson());

class FetchSafetyNoticesModel {
  final int status;
  final String message;
  final Data data;

  FetchSafetyNoticesModel(
      {required this.status, required this.message, required this.data});

  factory FetchSafetyNoticesModel.fromJson(Map<String, dynamic> json) =>
      FetchSafetyNoticesModel(
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
  final List<Notice> notices;

  Data({required this.canAdd, required this.notices});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        canAdd: json["can_add"] ?? '',
        notices:
            List<Notice>.from(json["notices"].map((x) => Notice.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "can_add": canAdd,
        "notices": List<dynamic>.from(notices.map((x) => x.toJson())),
      };
}

class Notice {
  final String id;
  final String refno;
  final String datetime;
  final String isexpired;
  final String notice;
  final String status;

  Notice(
      {required this.id,
      required this.refno,
      required this.datetime,
      required this.isexpired,
      required this.notice,
      required this.status});

  factory Notice.fromJson(Map<String, dynamic> json) => Notice(
        id: json["id"],
        refno: json["refno"] ?? '',
        datetime: json["datetime"] ?? '',
        isexpired: json["isexpired"] ?? '',
        notice: json["notice"] ?? '',
        status: json["status"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "refno": refno,
        "datetime": datetime,
        "isexpired": isexpired,
        "notice": notice,
        "status": status,
      };
}
