import 'dart:convert';

FetchItemMasterModel fetchItemMasterModelFromJson(String str) =>
    FetchItemMasterModel.fromJson(json.decode(str));

String fetchItemMasterModelToJson(FetchItemMasterModel data) =>
    json.encode(data.toJson());

class FetchItemMasterModel {
  final int status;
  final String message;
  final List<List<Datum>> data;

  FetchItemMasterModel(
      {required this.status, required this.message, required this.data});

  factory FetchItemMasterModel.fromJson(Map<String, dynamic> json) =>
      FetchItemMasterModel(
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
  final dynamic id;
  final String name;
  final dynamic active;
  final String currency;
  final String date;
  final String workingat;
  final String workingatnumber;

  Datum(
      {required this.id,
      required this.name,
      required this.active,
      required this.currency,
      required this.date,
      required this.workingat,
      required this.workingatnumber});

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
      id: json["id"] ?? '',
      name: json["name"] ?? '',
      active: json["active"] ?? '',
      currency: json["currency"] ?? '',
      date: json["date"] ?? '',
      workingat: json["workingat"] ?? '',
      workingatnumber: json["workingatnumber"] ?? '');

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "active": active,
        "currency": currency,
        "date": date,
        "workingat": workingat,
        "workingatnumber": workingatnumber,
      };
}
