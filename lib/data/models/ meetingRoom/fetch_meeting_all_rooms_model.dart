import 'dart:convert';

FetchMeetingAllRoomsModel fetchMeetingAllRoomsModelFromJson(String str) =>
    FetchMeetingAllRoomsModel.fromJson(json.decode(str));

String fetchMeetingAllRoomsModelToJson(FetchMeetingAllRoomsModel data) =>
    json.encode(data.toJson());

class FetchMeetingAllRoomsModel {
  final int status;
  final String message;
  final List<Datum> data;

  FetchMeetingAllRoomsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchMeetingAllRoomsModel.fromJson(Map<String, dynamic> json) =>
      FetchMeetingAllRoomsModel(
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
  final String roomid;
  final String roomname;
  final String nextslot;

  Datum({
    required this.roomid,
    required this.roomname,
    required this.nextslot,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        roomid: json["roomid"],
        roomname: json["roomname"],
        nextslot: json["nextslot"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "roomid": roomid,
        "roomname": roomname,
        "nextslot": nextslot,
      };
}
