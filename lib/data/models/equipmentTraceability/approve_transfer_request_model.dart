import 'dart:convert';

ApproveTransferRequestModel approveTransferRequestModelFromJson(String str) =>
    ApproveTransferRequestModel.fromJson(json.decode(str));

String approveTransferRequestModelToJson(ApproveTransferRequestModel data) =>
    json.encode(data.toJson());

class ApproveTransferRequestModel {
  final int status;
  final String message;
  final Data data;

  ApproveTransferRequestModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ApproveTransferRequestModel.fromJson(Map<String, dynamic> json) =>
      ApproveTransferRequestModel(
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
