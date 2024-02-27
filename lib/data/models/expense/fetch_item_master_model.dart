import 'dart:convert';

FetchItemMasterModel fetchItemMasterModelFromJson(String str) =>
    FetchItemMasterModel.fromJson(json.decode(str));

String fetchItemMasterModelToJson(FetchItemMasterModel data) =>
    json.encode(data.toJson());

class FetchItemMasterModel {
  final int status;
  final String message;
  final List<List<ItemMasterDatum>> data;

  FetchItemMasterModel(
      {required this.status, required this.message, required this.data});

  factory FetchItemMasterModel.fromJson(Map<String, dynamic> json) =>
      FetchItemMasterModel(
        status: json["Status"],
        message: json["Message"],
        data: List<List<ItemMasterDatum>>.from(json["Data"].map((x) =>
            List<ItemMasterDatum>.from(
                x.map((x) => ItemMasterDatum.fromJson(x))))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(
            data.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
      };
}

class ItemMasterDatum {
  final dynamic id;
  final String name;
  final dynamic active;
  final String currency;
  final String date;
  final String workingat;
  final String workingatnumber;

  ItemMasterDatum(
      {required this.id,
      required this.name,
      required this.active,
      required this.currency,
      required this.date,
      required this.workingat,
      required this.workingatnumber});

  factory ItemMasterDatum.fromJson(Map<String, dynamic> json) =>
      ItemMasterDatum(
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
