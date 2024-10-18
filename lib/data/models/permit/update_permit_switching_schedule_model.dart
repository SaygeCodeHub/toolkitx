import 'dart:convert';

UpdatePermitSwitchingScheduleModel updatePermitSwitchingScheduleModelFromJson(
        String str) =>
    UpdatePermitSwitchingScheduleModel.fromJson(json.decode(str));

String updatePermitSwitchingScheduleModelToJson(
        UpdatePermitSwitchingScheduleModel data) =>
    json.encode(data.toJson());

class UpdatePermitSwitchingScheduleModel {
  final int status;
  final String message;
  final Data data;

  UpdatePermitSwitchingScheduleModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UpdatePermitSwitchingScheduleModel.fromJson(
          Map<String, dynamic> json) =>
      UpdatePermitSwitchingScheduleModel(
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
