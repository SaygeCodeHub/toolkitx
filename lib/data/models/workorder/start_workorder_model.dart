import 'dart:convert';

StartWorkOrderModel acceptWorkOrderModelFromJson(String str) =>
    StartWorkOrderModel.fromJson(json.decode(str));

String acceptWorkOrderModelToJson(StartWorkOrderModel data) =>
    json.encode(data.toJson());

class StartWorkOrderModel {
  final int status;
  final String message;
  final Data data;

  StartWorkOrderModel(
      {required this.status, required this.message, required this.data});

  factory StartWorkOrderModel.fromJson(Map<String, dynamic> json) =>
      StartWorkOrderModel(
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
