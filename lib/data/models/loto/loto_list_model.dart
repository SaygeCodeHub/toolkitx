import 'dart:convert';

FetchLotoListModel fetchLotoListModelFromJson(String str) =>
    FetchLotoListModel.fromJson(json.decode(str));

String fetchLotoListModelToJson(FetchLotoListModel data) =>
    json.encode(data.toJson());

class FetchLotoListModel {
  final int status;
  final String message;
  final List<LotoListDatum> data;

  FetchLotoListModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchLotoListModel.fromJson(Map<String, dynamic> json) =>
      FetchLotoListModel(
        status: json["Status"],
        message: json["Message"],
        data: List<LotoListDatum>.from(
            json["Data"].map((x) => LotoListDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class LotoListDatum {
  final String id;
  final String name;
  final String date;
  final String location;
  final dynamic assetname;
  final String purpose;
  final String status;

  LotoListDatum({
    required this.id,
    required this.name,
    required this.date,
    required this.location,
    required this.assetname,
    required this.purpose,
    required this.status,
  });

  factory LotoListDatum.fromJson(Map<String, dynamic> json) => LotoListDatum(
        id: json["id"],
        name: json["name"],
        date: json["date"],
        location: json["location"],
        assetname: json["assetname"],
        purpose: json["purpose"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "date": date,
        "location": location,
        "assetname": assetname,
        "purpose": purpose,
        "status": status,
      };
}
