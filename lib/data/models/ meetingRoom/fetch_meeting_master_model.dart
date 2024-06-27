import 'dart:convert';

FetchMeetingMasterModel fetchMeetingMasterModelFromJson(String str) =>
    FetchMeetingMasterModel.fromJson(json.decode(str));

String fetchMeetingMasterModelToJson(FetchMeetingMasterModel data) =>
    json.encode(data.toJson());

class FetchMeetingMasterModel {
  final int status;
  final String message;
  final List<List<Datum>> data;

  FetchMeetingMasterModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchMeetingMasterModel.fromJson(Map<String, dynamic> json) =>
      FetchMeetingMasterModel(
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
  final String emailAddress;
  final String facility;

  Datum({
    required this.id,
    required this.name,
    required this.emailAddress,
    required this.facility,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] ?? '',
        name: json["name"] ?? '',
        emailAddress: json["email_address"] ?? '',
        facility: json["facility"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email_address": emailAddress,
        "facility": facility,
      };
}
