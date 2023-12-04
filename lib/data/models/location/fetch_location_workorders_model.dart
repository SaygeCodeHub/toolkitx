import 'dart:convert';

FetchLocationWorkOrdersModel fetchLocationWorkOrdersModelFromJson(String str) =>
    FetchLocationWorkOrdersModel.fromJson(json.decode(str));

String fetchLocationWorkOrdersModelToJson(FetchLocationWorkOrdersModel data) =>
    json.encode(data.toJson());

class FetchLocationWorkOrdersModel {
  final int status;
  final String message;
  final List<LocationWorkOrdersDatum> data;

  FetchLocationWorkOrdersModel(
      {required this.status, required this.message, required this.data});

  factory FetchLocationWorkOrdersModel.fromJson(Map<String, dynamic> json) =>
      FetchLocationWorkOrdersModel(
        status: json["Status"],
        message: json["Message"],
        data: List<LocationWorkOrdersDatum>.from(
            json["Data"].map((x) => LocationWorkOrdersDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class LocationWorkOrdersDatum {
  final String id;
  final String woname;
  final String contractorname;
  final String type;
  final String status;
  final String schedule;
  final String subject;
  final int istender;

  LocationWorkOrdersDatum(
      {required this.id,
      required this.woname,
      required this.contractorname,
      required this.type,
      required this.status,
      required this.schedule,
      required this.subject,
      required this.istender});

  factory LocationWorkOrdersDatum.fromJson(Map<String, dynamic> json) =>
      LocationWorkOrdersDatum(
          id: json["id"] ?? '',
          woname: json["woname"] ?? '',
          contractorname: json["contractorname"] ?? '',
          type: json["type"] ?? '',
          status: json["status"] ?? '',
          schedule: json["schedule"] ?? '',
          subject: json["subject"] ?? '',
          istender: json["istender"] ?? '');

  Map<String, dynamic> toJson() => {
        "id": id,
        "woname": woname,
        "contractorname": contractorname,
        "type": type,
        "status": status,
        "schedule": schedule,
        "subject": subject,
        "istender": istender,
      };
}
