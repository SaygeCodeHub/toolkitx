import 'dart:convert';

FetchTicketMasterModel fetchTicketMasterModelFromJson(String str) =>
    FetchTicketMasterModel.fromJson(json.decode(str));

String fetchTicketMasterModelToJson(FetchTicketMasterModel data) =>
    json.encode(data.toJson());

class FetchTicketMasterModel {
  final int status;
  final String message;
  final List<List<Datum>> data;

  FetchTicketMasterModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchTicketMasterModel.fromJson(Map<String, dynamic> json) =>
      FetchTicketMasterModel(
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
  final int id;
  final String appname;

  Datum({
    required this.id,
    required this.appname,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        appname: json["appname"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "appname": appname,
      };
}
