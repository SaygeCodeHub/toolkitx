import 'dart:convert';

DeleteSwitchingScheduleModel deleteSwitchingScheduleModelFromJson(String str) =>
    DeleteSwitchingScheduleModel.fromJson(json.decode(str));

String deleteSwitchingScheduleModelToJson(DeleteSwitchingScheduleModel data) =>
    json.encode(data.toJson());

class DeleteSwitchingScheduleModel {
  final int status;
  final String message;
  final Data data;

  DeleteSwitchingScheduleModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory DeleteSwitchingScheduleModel.fromJson(Map<String, dynamic> json) =>
      DeleteSwitchingScheduleModel(
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
