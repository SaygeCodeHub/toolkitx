import 'dart:convert';

SendTransferRequestModel sendTransferRequestModelFromJson(String str) => SendTransferRequestModel.fromJson(json.decode(str));

String sendTransferRequestModelToJson(SendTransferRequestModel data) => json.encode(data.toJson());

class SendTransferRequestModel {
  final int status;
  final String message;
  final Data data;

  SendTransferRequestModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SendTransferRequestModel.fromJson(Map<String, dynamic> json) => SendTransferRequestModel(
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
  );

  Map<String, dynamic> toJson() => {
  };
}
