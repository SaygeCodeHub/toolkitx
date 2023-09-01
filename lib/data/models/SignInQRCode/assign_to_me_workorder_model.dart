import 'dart:convert';

AssignToMeWorkOrderModel assignToMeWorkOrderModelFromJson(String str) =>
    AssignToMeWorkOrderModel.fromJson(json.decode(str));

String assignToMeWorkOrderModelToJson(AssignToMeWorkOrderModel data) =>
    json.encode(data.toJson());

class AssignToMeWorkOrderModel {
  final int status;
  final String message;
  final Data data;

  AssignToMeWorkOrderModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AssignToMeWorkOrderModel.fromJson(Map<String, dynamic> json) =>
      AssignToMeWorkOrderModel(
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
