import 'dart:convert';

FetchTicket2MasterModel fetchTicket2MasterModelFromJson(String str) =>
    FetchTicket2MasterModel.fromJson(json.decode(str));

String fetchTicket2MasterModelToJson(FetchTicket2MasterModel data) =>
    json.encode(data.toJson());

class FetchTicket2MasterModel {
  final int status;
  final String message;
  final List<List<Ticket2MasterDatum>> data;

  FetchTicket2MasterModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchTicket2MasterModel.fromJson(Map<String, dynamic> json) =>
      FetchTicket2MasterModel(
        status: json["Status"],
        message: json["Message"],
        data: List<List<Ticket2MasterDatum>>.from(json["Data"].map((x) =>
            List<Ticket2MasterDatum>.from(
                x.map((x) => Ticket2MasterDatum.fromJson(x))))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(
            data.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
      };
}

class Ticket2MasterDatum {
  final int id;
  final String name;
  final String priorityname;
  final String listname;
  final String emailaddress;
  final int active;
  final String text;

  Ticket2MasterDatum({
    required this.id,
    required this.name,
    required this.priorityname,
    required this.listname,
    required this.emailaddress,
    required this.active,
    required this.text,
  });

  factory Ticket2MasterDatum.fromJson(Map<String, dynamic> json) =>
      Ticket2MasterDatum(
        id: json["id"] ?? 0,
        name: json["name"] ?? '',
        priorityname: json["priorityname"] ?? '',
        listname: json["listname"] ?? '',
        emailaddress: json["emailaddress"] ?? '',
        active: json["active"] ?? 0,
        text: json["text"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "priorityname": priorityname,
        "listname": listname,
        "emailaddress": emailaddress,
        "active": active,
        "text": text,
      };
}
