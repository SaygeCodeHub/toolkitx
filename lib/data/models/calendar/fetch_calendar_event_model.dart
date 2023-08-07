import 'dart:convert';

FetchCalendarEventsModel fetchCalendarEventsModelFromJson(String str) =>
    FetchCalendarEventsModel.fromJson(json.decode(str));

String fetchCalendarEventsModelToJson(FetchCalendarEventsModel data) =>
    json.encode(data.toJson());

class FetchCalendarEventsModel {
  final int? status;
  final String? message;
  final List<CalendarEventsDatum>? data;

  FetchCalendarEventsModel({
    this.status,
    this.message,
    this.data,
  });

  factory FetchCalendarEventsModel.fromJson(Map<String, dynamic> json) =>
      FetchCalendarEventsModel(
        status: json["Status"],
        message: json["Message"],
        data: List<CalendarEventsDatum>.from(
            json["Data"].map((x) => CalendarEventsDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CalendarEventsDatum {
  final String date;
  final String day;
  final String fulldate;
  final List<CalendarEvent> events;

  CalendarEventsDatum({
    required this.date,
    required this.day,
    required this.fulldate,
    required this.events,
  });

  factory CalendarEventsDatum.fromJson(Map<String, dynamic> json) =>
      CalendarEventsDatum(
        date: json["date"],
        day: json["day"],
        fulldate: json["fulldate"],
        events: List<CalendarEvent>.from(
            json["events"].map((x) => CalendarEvent.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "day": day,
        "fulldate": fulldate,
        "events": List<dynamic>.from(events.map((x) => x.toJson())),
      };
}

class CalendarEvent {
  final String type;
  final String name;
  final String id;
  final DateTime startDate;
  final DateTime endDate;
  final String time;
  final String color;

  CalendarEvent({
    required this.type,
    required this.name,
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.time,
    required this.color,
  });

  factory CalendarEvent.fromJson(Map<String, dynamic> json) => CalendarEvent(
        type: json["type"],
        name: json["name"],
        id: json["id"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        time: json["time"],
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "name": name,
        "id": id,
        "startDate":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "endDate":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "time": time,
        "color": color,
      };
}
