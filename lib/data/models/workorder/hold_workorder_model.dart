import 'dart:convert';

HoldWorkOrderModel acceptWorkOrderModelFromJson(String str) =>
    HoldWorkOrderModel.fromJson(json.decode(str));

String acceptWorkOrderModelToJson(HoldWorkOrderModel data) =>
    json.encode(data.toJson());

class HoldWorkOrderModel {
  final int status;
  final String message;
  final Data data;

  HoldWorkOrderModel(
      {required this.status, required this.message, required this.data});

  factory HoldWorkOrderModel.fromJson(Map<String, dynamic> json) =>
      HoldWorkOrderModel(
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
