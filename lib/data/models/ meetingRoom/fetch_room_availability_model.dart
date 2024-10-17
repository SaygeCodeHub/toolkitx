import 'dart:convert';

FetchRoomAvailabilityModel fetchRoomAvailabilityModelFromJson(String str) =>
    FetchRoomAvailabilityModel.fromJson(json.decode(str));

String fetchRoomAvailabilityModelToJson(FetchRoomAvailabilityModel data) =>
    json.encode(data.toJson());

class FetchRoomAvailabilityModel {
  final int status;
  final String message;
  final List<Datum> data;

  FetchRoomAvailabilityModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchRoomAvailabilityModel.fromJson(Map<String, dynamic> json) =>
      FetchRoomAvailabilityModel(
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
  final String slots;
  final String status;

  Datum({
    required this.slots,
    required this.status,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        slots: json["slots"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "slots": slots,
        "status": status,
      };
}
