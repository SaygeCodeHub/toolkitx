import 'dart:convert';

FetchMonthlyScheduleModel fetchMonthlyScheduleModelFromJson(String str) =>
    FetchMonthlyScheduleModel.fromJson(json.decode(str));

String fetchMonthlyScheduleModelToJson(FetchMonthlyScheduleModel data) =>
    json.encode(data.toJson());

class FetchMonthlyScheduleModel {
  final int status;
  final String message;
  final List<Datum> data;

  FetchMonthlyScheduleModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchMonthlyScheduleModel.fromJson(Map<String, dynamic> json) =>
      FetchMonthlyScheduleModel(
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
  final String date;
  final List<Booking> bookings;

  Datum({
    required this.date,
    required this.bookings,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        date: json["date"],
        bookings: List<Booking>.from(
            json["bookings"].map((x) => Booking.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "bookings": List<dynamic>.from(bookings.map((x) => x.toJson())),
      };
}

class Booking {
  final String bookingid;
  final String startdatetime;
  final String enddatetime;

  Booking({
    required this.bookingid,
    required this.startdatetime,
    required this.enddatetime,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        bookingid: json["bookingid"],
        startdatetime: json["startdatetime"],
        enddatetime: json["enddatetime"],
      );

  Map<String, dynamic> toJson() => {
        "bookingid": bookingid,
        "startdatetime": startdatetime,
        "enddatetime": enddatetime,
      };
}
