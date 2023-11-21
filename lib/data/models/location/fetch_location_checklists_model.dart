import 'dart:convert';

FetchLocationCheckListsModel fetchLocationCheckListsModelFromJson(String str) =>
    FetchLocationCheckListsModel.fromJson(json.decode(str));

String fetchLocationCheckListsModelToJson(FetchLocationCheckListsModel data) =>
    json.encode(data.toJson());

class FetchLocationCheckListsModel {
  final int status;
  final String message;
  final List<LocationCheckListsDatum> data;

  FetchLocationCheckListsModel(
      {required this.status, required this.message, required this.data});

  factory FetchLocationCheckListsModel.fromJson(Map<String, dynamic> json) =>
      FetchLocationCheckListsModel(
        status: json["Status"],
        message: json["Message"],
        data: List<LocationCheckListsDatum>.from(
            json["Data"].map((x) => LocationCheckListsDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class LocationCheckListsDatum {
  final String id;
  final String name;
  final int responsecount;
  final String categoryname;
  final String subcategoryname;
  final int overduecount;
  final int approvalpendingcount;

  LocationCheckListsDatum(
      {required this.id,
      required this.name,
      required this.responsecount,
      required this.categoryname,
      required this.subcategoryname,
      required this.overduecount,
      required this.approvalpendingcount});

  factory LocationCheckListsDatum.fromJson(Map<String, dynamic> json) =>
      LocationCheckListsDatum(
          id: json["id"] ?? '',
          name: json["name"] ?? '',
          responsecount: json["responsecount"] ?? '',
          categoryname: json["categoryname"] ?? '',
          subcategoryname: json["subcategoryname"] ?? '',
          overduecount: json["overduecount"] ?? '',
          approvalpendingcount: json["approvalpendingcount"] ?? '');

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "responsecount": responsecount,
        "categoryname": categoryname,
        "subcategoryname": subcategoryname,
        "overduecount": overduecount,
        "approvalpendingcount": approvalpendingcount,
      };
}
