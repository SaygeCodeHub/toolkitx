import 'dart:convert';

FetchMessagesModel fetchMessagesModelFromJson(String str) =>
    FetchMessagesModel.fromJson(json.decode(str));

String fetchMessagesModelToJson(FetchMessagesModel data) =>
    json.encode(data.toJson());

class FetchMessagesModel {
  final int? status;
  final String? message;
  final List<Datum>? data;

  FetchMessagesModel({
    this.status,
    this.message,
    this.data,
  });

  factory FetchMessagesModel.fromJson(Map<String, dynamic> json) =>
      FetchMessagesModel(
        status: json["Status"],
        message: json["Message"],
        data: json["Data"] == null
            ? []
            : List<Datum>.from(json["Data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  final int? id;
  final String? notificationmessage;
  final String? processedDate;
  final int? userid;
  final int? usertype;
  final Redirect? redirect;
  final String? redirectionkey;
  final DateTime? createddate;
  final int? isread;
  final String? processedDate1;

  Datum({
    this.id,
    this.notificationmessage,
    this.processedDate,
    this.userid,
    this.usertype,
    this.redirect,
    this.redirectionkey,
    this.createddate,
    this.isread,
    this.processedDate1,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] ?? '',
        notificationmessage: json["notificationmessage"] ?? '',
        processedDate: json["processed_date"] ?? '',
        userid: json["userid"] ?? '',
        usertype: json["usertype"] ?? '',
        redirect: redirectValues.map[json["redirect"] ?? ''],
        redirectionkey: json["redirectionkey"] ?? '',
        createddate: json["createddate"] == null
            ? null
            : DateTime.parse(json["createddate"]),
        isread: json["isread"] ?? '',
        processedDate1: json["processed_date1"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "notificationmessage": notificationmessage,
        "processed_date": processedDate,
        "userid": userid,
        "usertype": usertype,
        "redirect": redirectValues.reverse[redirect],
        "redirectionkey": redirectionkey,
        "createddate": createddate?.toIso8601String(),
        "isread": isread,
        "processed_date1": processedDate1,
      };
}

enum Redirect { CERTIFICATECOURSE, EXPENSEREPORT, LOTO, WORKORDER }

final redirectValues = EnumValues({
  "certificatecourse": Redirect.CERTIFICATECOURSE,
  "expensereport": Redirect.EXPENSEREPORT,
  "loto": Redirect.LOTO,
  "workorder": Redirect.WORKORDER
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
