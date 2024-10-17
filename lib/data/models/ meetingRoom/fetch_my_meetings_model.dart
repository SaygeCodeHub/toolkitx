import 'dart:convert';

FetchMyMeetingsModel fetchMyMeetingsModelFromJson(String str) =>
    FetchMyMeetingsModel.fromJson(json.decode(str));

String fetchMyMeetingsModelToJson(FetchMyMeetingsModel data) =>
    json.encode(data.toJson());

class FetchMyMeetingsModel {
  final int status;
  final String message;
  final List<Datum> data;

  FetchMyMeetingsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchMyMeetingsModel.fromJson(Map<String, dynamic> json) =>
      FetchMyMeetingsModel(
        status: json["Status"],
        message: json["Message"],
        data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  final String bookingid;
  final String roomname;
  final String location;
  final String startdatetime;
  final String enddatetime;
  final String shortagenda;
  final String participantname;

  Datum({
    required this.bookingid,
    required this.roomname,
    required this.location,
    required this.startdatetime,
    required this.enddatetime,
    required this.shortagenda,
    required this.participantname,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        bookingid: json["bookingid"],
        roomname: json["roomname"],
        location: json["location"],
        startdatetime: json["startdatetime"],
        enddatetime: json["enddatetime"],
        shortagenda: json["shortagenda"],
        participantname: json["participantname"],
      );

  Map<String, dynamic> toJson() => {
        "bookingid": bookingid,
        "roomname": roomname,
        "location": location,
        "startdatetime": startdatetime,
        "enddatetime": enddatetime,
        "shortagenda": shortagenda,
        "participantname": participantname,
      };
}
