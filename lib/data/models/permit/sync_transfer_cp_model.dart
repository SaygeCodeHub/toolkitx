import 'dart:convert';

SyncTransferCpPermitModel openClosePermitModelFromJson(String str) =>
    SyncTransferCpPermitModel.fromJson(json.decode(str));

String openClosePermitModelToJson(SyncTransferCpPermitModel data) =>
    json.encode(data.toJson());

class SyncTransferCpPermitModel {
  final int status;
  final String? message;
  final Data data;

  SyncTransferCpPermitModel(
      {required this.status, this.message, required this.data});

  factory SyncTransferCpPermitModel.fromJson(Map<String, dynamic> json) =>
      SyncTransferCpPermitModel(
          status: json["Status"],
          message: json["Message"],
          data: Data.fromJson(json["Data"]));

  Map<String, dynamic> toJson() =>
      {"Status": status, "Message": message, "Data": data.toJson()};
}

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}
