import 'dart:convert';

UpdateQualityManagementDetailsModel updateQualityManagementDetailsModelFromJson(
        String str) =>
    UpdateQualityManagementDetailsModel.fromJson(json.decode(str));

String updateQualityManagementDetailsModelToJson(
        UpdateQualityManagementDetailsModel data) =>
    json.encode(data.toJson());

class UpdateQualityManagementDetailsModel {
  final int status;
  final String message;
  final Data data;

  UpdateQualityManagementDetailsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UpdateQualityManagementDetailsModel.fromJson(
          Map<String, dynamic> json) =>
      UpdateQualityManagementDetailsModel(
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
