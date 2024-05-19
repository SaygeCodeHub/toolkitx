import 'dart:convert';

FetchTicketMasterModel fetchTicketMasterModelFromJson(String str) =>
    FetchTicketMasterModel.fromJson(json.decode(str));

String fetchTicketMasterModelToJson(FetchTicketMasterModel data) =>
    json.encode(data.toJson());

class FetchTicketMasterModel {
  final int status;
  final String message;
  final List<List<TicketMasterDatum>> data;

  FetchTicketMasterModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchTicketMasterModel.fromJson(Map<String, dynamic> json) =>
      FetchTicketMasterModel(
        status: json["Status"],
        message: json["Message"],
        data: List<List<TicketMasterDatum>>.from(json["Data"].map((x) =>
            List<TicketMasterDatum>.from(
                x.map((x) => TicketMasterDatum.fromJson(x))))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(
            data.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
      };
}

class TicketMasterDatum {
  final int id;
  final String appname;
  final String priorityname;

  TicketMasterDatum({
    required this.id,
    required this.appname,
    required this.priorityname,
  });

  factory TicketMasterDatum.fromJson(Map<String, dynamic> json) =>
      TicketMasterDatum(
        id: json["id"],
        appname: json["appname"] ?? '',
        priorityname: json["priorityname"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "appname": appname,
        "priorityname": priorityname,
      };
}
