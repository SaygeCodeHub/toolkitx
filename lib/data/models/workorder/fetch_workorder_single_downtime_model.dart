import 'dart:convert';

FetchWorkOrderSingleDownTimeModel fetchWorkOrderSingleDownTimeModelFromJson(
        String str) =>
    FetchWorkOrderSingleDownTimeModel.fromJson(json.decode(str));

String fetchWorkOrderSingleDownTimeModelToJson(
        FetchWorkOrderSingleDownTimeModel data) =>
    json.encode(data.toJson());

class FetchWorkOrderSingleDownTimeModel {
  final int status;
  final String message;
  final Data data;

  FetchWorkOrderSingleDownTimeModel(
      {required this.status, required this.message, required this.data});

  factory FetchWorkOrderSingleDownTimeModel.fromJson(
          Map<String, dynamic> json) =>
      FetchWorkOrderSingleDownTimeModel(
        status: json["Status"],
        message: json["Message"],
        data: Data.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": data.toJson(),
      };
}

class Data {
  final String id;
  final String notes;
  final String startdatetime;
  final String enddatetime;
  final String woid;
  final String startdate;
  final String starttime;
  final String enddate;
  final String endtime;

  Data(
      {required this.id,
      required this.notes,
      required this.startdatetime,
      required this.enddatetime,
      required this.woid,
      required this.startdate,
      required this.starttime,
      required this.enddate,
      required this.endtime});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] ?? '',
        notes: json["notes"] ?? '',
        startdatetime: json["startdatetime"] ?? '',
        enddatetime: json["enddatetime"] ?? '',
        woid: json["woid"] ?? '',
        startdate: json["startdate"] ?? '',
        starttime: json["starttime"] ?? '',
        enddate: json["enddate"] ?? '',
        endtime: json["endtime"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "notes": notes,
        "startdatetime": startdatetime,
        "enddatetime": enddatetime,
        "woid": woid,
        "startdate": startdate,
        "starttime": starttime,
        "enddate": enddate,
        "endtime": endtime,
      };
}
