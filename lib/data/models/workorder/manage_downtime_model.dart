import 'dart:convert';

ManageWorkOrderDownTimeModel manageWorkOrderDownTimeModelFromJson(String str) =>
    ManageWorkOrderDownTimeModel.fromJson(json.decode(str));

String manageWorkOrderDownTimeModelToJson(ManageWorkOrderDownTimeModel data) =>
    json.encode(data.toJson());

class ManageWorkOrderDownTimeModel {
  final int status;
  final String message;
  final Data data;

  ManageWorkOrderDownTimeModel(
      {required this.status, required this.message, required this.data});

  factory ManageWorkOrderDownTimeModel.fromJson(Map<String, dynamic> json) =>
      ManageWorkOrderDownTimeModel(
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
