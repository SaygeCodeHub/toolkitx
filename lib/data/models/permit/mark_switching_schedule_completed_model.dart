import 'dart:convert';

MarkSwitchingScheduleCompletedModel markSwitchingScheduleCompletedModelFromJson(
        String str) =>
    MarkSwitchingScheduleCompletedModel.fromJson(json.decode(str));

String markSwitchingScheduleCompletedModelToJson(
        MarkSwitchingScheduleCompletedModel data) =>
    json.encode(data.toJson());

class MarkSwitchingScheduleCompletedModel {
  final int status;
  final String message;
  final Data data;

  MarkSwitchingScheduleCompletedModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory MarkSwitchingScheduleCompletedModel.fromJson(
          Map<String, dynamic> json) =>
      MarkSwitchingScheduleCompletedModel(
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
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}
