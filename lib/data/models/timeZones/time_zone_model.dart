import 'dart:convert';

TimeZoneModel getTimeZoneModelFromJson(String str) =>
    TimeZoneModel.fromJson(json.decode(str));

String getTimeZoneModelToJson(TimeZoneModel data) => json.encode(data.toJson());

class TimeZoneModel {
  final int status;
  final String? message;
  final List<TimeZoneData>? data;

  TimeZoneModel({
    required this.status,
    this.message,
    this.data,
  });

  factory TimeZoneModel.fromJson(Map<String, dynamic> json) => TimeZoneModel(
        status: json["Status"],
        message: json["Message"],
        data: List<TimeZoneData>.from(
            json["Data"].map((x) => TimeZoneData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class TimeZoneData {
  final String name;
  final String offset;
  final String code;

  TimeZoneData({
    required this.name,
    required this.offset,
    required this.code,
  });

  factory TimeZoneData.fromJson(Map<String, dynamic> json) => TimeZoneData(
        name: json["name"],
        offset: json["offset"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "offset": offset,
        "code": code,
      };
}
