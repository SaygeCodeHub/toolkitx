import 'dart:convert';

SaveClearPermitModel acceptPermitRequestModelFromJson(String str) =>
    SaveClearPermitModel.fromJson(json.decode(str));

String acceptPermitRequestModelToJson(SaveClearPermitModel data) =>
    json.encode(data.toJson());

class SaveClearPermitModel {
  final int? status;
  final String? message;
  final Data? data;

  SaveClearPermitModel({
    this.status,
    this.message,
    this.data,
  });

  factory SaveClearPermitModel.fromJson(Map<String, dynamic> json) =>
      SaveClearPermitModel(
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
