import 'dart:convert';

AcceptWorkOrderModel acceptWorkOrderModelFromJson(String str) =>
    AcceptWorkOrderModel.fromJson(json.decode(str));

String acceptWorkOrderModelToJson(AcceptWorkOrderModel data) =>
    json.encode(data.toJson());

class AcceptWorkOrderModel {
  final int status;
  final String message;
  final Data data;

  AcceptWorkOrderModel(
      {required this.status, required this.message, required this.data});

  factory AcceptWorkOrderModel.fromJson(Map<String, dynamic> json) =>
      AcceptWorkOrderModel(
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
