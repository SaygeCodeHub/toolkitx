import 'dart:convert';

MoveDownPermitSwitchingScheduleModel
    moveDownPermitSwitchingScheduleModelFromJson(String str) =>
        MoveDownPermitSwitchingScheduleModel.fromJson(json.decode(str));

String moveDownPermitSwitchingScheduleModelToJson(
        MoveDownPermitSwitchingScheduleModel data) =>
    json.encode(data.toJson());

class MoveDownPermitSwitchingScheduleModel {
  final int status;
  final String message;
  final Data data;

  MoveDownPermitSwitchingScheduleModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory MoveDownPermitSwitchingScheduleModel.fromJson(
          Map<String, dynamic> json) =>
      MoveDownPermitSwitchingScheduleModel(
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
