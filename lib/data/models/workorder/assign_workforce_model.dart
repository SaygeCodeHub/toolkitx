import 'dart:convert';

AssignWorkOrderModel assignWorkOrderModelFromJson(String str) =>
    AssignWorkOrderModel.fromJson(json.decode(str));

String assignWorkOrderModelToJson(AssignWorkOrderModel data) =>
    json.encode(data.toJson());

class AssignWorkOrderModel {
  final int status;
  final String message;
  final Data data;

  AssignWorkOrderModel(
      {required this.status, required this.message, required this.data});

  factory AssignWorkOrderModel.fromJson(Map<String, dynamic> json) =>
      AssignWorkOrderModel(
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
