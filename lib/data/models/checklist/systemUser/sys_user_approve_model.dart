import 'dart:convert';

ChecklistApproveModel postChecklistApproveModelFromJson(String str) =>
    ChecklistApproveModel.fromJson(json.decode(str));

String postChecklistApproveModelToJson(ChecklistApproveModel data) =>
    json.encode(data.toJson());

class ChecklistApproveModel {
  final int status;
  final String? message;
  final Data data;

  ChecklistApproveModel({
    required this.status,
    this.message,
    required this.data,
  });

  factory ChecklistApproveModel.fromJson(Map<String, dynamic> json) =>
      ChecklistApproveModel(
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
