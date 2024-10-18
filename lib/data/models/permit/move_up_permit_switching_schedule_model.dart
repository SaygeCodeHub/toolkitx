import 'dart:convert';

MoveUpPermitSwitchingScheduleModel moveUpPermitSwitchingScheduleModelFromJson(
        String str) =>
    MoveUpPermitSwitchingScheduleModel.fromJson(json.decode(str));

String moveUpPermitSwitchingScheduleModelToJson(
        MoveUpPermitSwitchingScheduleModel data) =>
    json.encode(data.toJson());

class MoveUpPermitSwitchingScheduleModel {
  final int status;
  final String message;
  final Data data;

  MoveUpPermitSwitchingScheduleModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory MoveUpPermitSwitchingScheduleModel.fromJson(
          Map<String, dynamic> json) =>
      MoveUpPermitSwitchingScheduleModel(
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
