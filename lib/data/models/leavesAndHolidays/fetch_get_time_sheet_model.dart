import 'dart:convert';

FetchTimeSheetModel fetchTimeSheetModelFromJson(String str) =>
    FetchTimeSheetModel.fromJson(json.decode(str));

String fetchTimeSheetModelToJson(FetchTimeSheetModel data) =>
    json.encode(data.toJson());

class FetchTimeSheetModel {
  final int status;
  final String message;
  final TimesheetData data;

  FetchTimeSheetModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchTimeSheetModel.fromJson(Map<String, dynamic> json) =>
      FetchTimeSheetModel(
        status: json["Status"],
        message: json["Message"],
        data: TimesheetData.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": data.toJson(),
      };
}

class TimesheetData {
  final Settings settings;
  final List<Date> dates;

  TimesheetData({
    required this.settings,
    required this.dates,
  });

  factory TimesheetData.fromJson(Map<String, dynamic> json) => TimesheetData(
        settings: Settings.fromJson(json["settings"]),
        dates: List<Date>.from(json["dates"].map((x) => Date.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "settings": settings.toJson(),
        "dates": List<dynamic>.from(dates.map((x) => x.toJson())),
      };
}

class Date {
  final String date;
  final String day;
  final String fulldate;
  final String id;
  final String hours;
  final String submissionDate;
  final String isoverdue;
  final String isweekend;
  final String rejectionDate;
  final int status;

  Date({
    required this.date,
    required this.day,
    required this.fulldate,
    required this.id,
    required this.hours,
    required this.submissionDate,
    required this.isoverdue,
    required this.isweekend,
    required this.rejectionDate,
    required this.status,
  });

  factory Date.fromJson(Map<String, dynamic> json) => Date(
        date: json["date"],
        day: json["day"],
        fulldate: json["fulldate"],
        id: json["id"],
        hours: json["hours"],
        submissionDate: json["submission_date"],
        isoverdue: json["isoverdue"] ?? '',
        isweekend: json["isweekend"],
        rejectionDate: json["rejection_date"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "day": day,
        "fulldate": fulldate,
        "id": id,
        "hours": hours,
        "submission_date": submissionDate,
        "isoverdue": isoverdue,
        "isweekend": isweekend,
        "rejection_date": rejectionDate,
        "status": status,
      };
}

class Settings {
  final String defaultCurrency;
  final String defaultCountry;
  final String starttime;
  final String endtime;
  final String submisionPeriod;
  final String methodofreporting;
  final String outlookinvitation;
  final String locationreq;
  final String weekend;
  final String privilegeleave;

  Settings({
    required this.defaultCurrency,
    required this.defaultCountry,
    required this.starttime,
    required this.endtime,
    required this.submisionPeriod,
    required this.methodofreporting,
    required this.outlookinvitation,
    required this.locationreq,
    required this.weekend,
    required this.privilegeleave,
  });

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
        defaultCurrency: json["default_currency"],
        defaultCountry: json["default_country"],
        starttime: json["starttime"],
        endtime: json["endtime"],
        submisionPeriod: json["submision_period"],
        methodofreporting: json["methodofreporting"],
        outlookinvitation: json["outlookinvitation"],
        locationreq: json["locationreq"],
        weekend: json["weekend"],
        privilegeleave: json["privilegeleave"],
      );

  Map<String, dynamic> toJson() => {
        "default_currency": defaultCurrency,
        "default_country": defaultCountry,
        "starttime": starttime,
        "endtime": endtime,
        "submision_period": submisionPeriod,
        "methodofreporting": methodofreporting,
        "outlookinvitation": outlookinvitation,
        "locationreq": locationreq,
        "weekend": weekend,
        "privilegeleave": privilegeleave,
      };
}
