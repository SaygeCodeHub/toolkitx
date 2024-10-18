import 'dart:convert';

FetchSearchForRoomsModel fetchSearchForRoomsModelFromJson(String str) =>
    FetchSearchForRoomsModel.fromJson(json.decode(str));

String fetchSearchForRoomsModelToJson(FetchSearchForRoomsModel data) =>
    json.encode(data.toJson());

class FetchSearchForRoomsModel {
  final int status;
  final String message;
  final List<SearchForRoomsDatum> data;

  FetchSearchForRoomsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchSearchForRoomsModel.fromJson(Map<String, dynamic> json) =>
      FetchSearchForRoomsModel(
        status: json["Status"],
        message: json["Message"],
        data: List<SearchForRoomsDatum>.from(
            json["Data"].map((x) => SearchForRoomsDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class SearchForRoomsDatum {
  final String roomid;
  final String roomname;
  final String location;
  final int capacity;
  final String facilityname;

  SearchForRoomsDatum({
    required this.roomid,
    required this.roomname,
    required this.location,
    required this.capacity,
    required this.facilityname,
  });

  factory SearchForRoomsDatum.fromJson(Map<String, dynamic> json) =>
      SearchForRoomsDatum(
        roomid: json["roomid"],
        roomname: json["roomname"],
        location: json["location"],
        capacity: json["capacity"],
        facilityname: json["facilityname"],
      );

  Map<String, dynamic> toJson() => {
        "roomid": roomid,
        "roomname": roomname,
        "location": location,
        "capacity": capacity,
        "facilityname": facilityname,
      };
}
