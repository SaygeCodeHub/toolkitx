import 'dart:convert';

ChecklistRejectModel postChecklistApproveModelFromJson(String str) =>
    ChecklistRejectModel.fromJson(json.decode(str));

String postChecklistApproveModelToJson(ChecklistRejectModel data) =>
    json.encode(data.toJson());

class ChecklistRejectModel {
  final int status;
  final String? message;
  final Data data;

  ChecklistRejectModel({
    required this.status,
    this.message,
    required this.data,
  });

  factory ChecklistRejectModel.fromJson(Map<String, dynamic> json) =>
      ChecklistRejectModel(
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
