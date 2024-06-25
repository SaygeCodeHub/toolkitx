import 'dart:convert';

SaveLinkedPermitModel saveLinkedPermitFromJson(String str) =>
    SaveLinkedPermitModel.fromJson(json.decode(str));

String saveLinkedPermitToJson(SaveLinkedPermitModel data) =>
    json.encode(data.toJson());

class SaveLinkedPermitModel {
  final int? status;
  final String? message;
  final Data? data;

  SaveLinkedPermitModel({
    this.status,
    this.message,
    this.data,
  });

  factory SaveLinkedPermitModel.fromJson(Map<String, dynamic> json) =>
      SaveLinkedPermitModel(
        status: json["Status"],
        message: json["Message"],
        data: json["Data"] == null ? null : Data.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": data?.toJson(),
      };
}

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}
