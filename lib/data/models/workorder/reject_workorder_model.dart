import 'dart:convert';

RejectWorkOrderModel acceptWorkOrderModelFromJson(String str) =>
    RejectWorkOrderModel.fromJson(json.decode(str));

String acceptWorkOrderModelToJson(RejectWorkOrderModel data) =>
    json.encode(data.toJson());

class RejectWorkOrderModel {
  final int status;
  final String message;
  final Data data;

  RejectWorkOrderModel(
      {required this.status, required this.message, required this.data});

  factory RejectWorkOrderModel.fromJson(Map<String, dynamic> json) =>
      RejectWorkOrderModel(
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
