import 'dart:convert';

ChecklistSubmitHeaderModel checklistSubmitHeaderModelFromJson(String str) =>
    ChecklistSubmitHeaderModel.fromJson(json.decode(str));

String checklistSubmitHeaderModelToJson(ChecklistSubmitHeaderModel data) =>
    json.encode(data.toJson());

class ChecklistSubmitHeaderModel {
  final int status;
  final String? message;
  final Data data;

  ChecklistSubmitHeaderModel({
    required this.status,
    this.message,
    required this.data,
  });

  factory ChecklistSubmitHeaderModel.fromJson(Map<String, dynamic> json) =>
      ChecklistSubmitHeaderModel(
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
