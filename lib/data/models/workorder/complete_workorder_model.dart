import 'dart:convert';

CompleteWorkOrderModel completeWorkOrderModelFromJson(String str) =>
    CompleteWorkOrderModel.fromJson(json.decode(str));

String completeWorkOrderModelToJson(CompleteWorkOrderModel data) =>
    json.encode(data.toJson());

class CompleteWorkOrderModel {
  final int status;
  final String message;
  final Data data;

  CompleteWorkOrderModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CompleteWorkOrderModel.fromJson(Map<String, dynamic> json) =>
      CompleteWorkOrderModel(
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
