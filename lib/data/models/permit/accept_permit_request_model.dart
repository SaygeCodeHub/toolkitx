import 'dart:convert';

AcceptPermitRequestModel acceptPermitRequestModelFromJson(String str) =>
    AcceptPermitRequestModel.fromJson(json.decode(str));

String acceptPermitRequestModelToJson(AcceptPermitRequestModel data) =>
    json.encode(data.toJson());

class AcceptPermitRequestModel {
  final int? status;
  final String? message;
  final AcceptPermitRequestData? data;

  AcceptPermitRequestModel({
    this.status,
    this.message,
    this.data,
  });

  factory AcceptPermitRequestModel.fromJson(Map<String, dynamic> json) =>
      AcceptPermitRequestModel(
        status: json["Status"],
        message: json["Message"],
        data: json["Data"] == null
            ? null
            : AcceptPermitRequestData.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": data?.toJson(),
      };
}

class AcceptPermitRequestData {
  AcceptPermitRequestData();

  factory AcceptPermitRequestData.fromJson(Map<String, dynamic> json) =>
      AcceptPermitRequestData();

  Map<String, dynamic> toJson() => {};
}
