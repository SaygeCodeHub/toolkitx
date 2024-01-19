import 'dart:convert';

RejectTransferRequestModel rejectTransferRequestModelFromJson(String str) => RejectTransferRequestModel.fromJson(json.decode(str));

String rejectTransferRequestModelToJson(RejectTransferRequestModel data) => json.encode(data.toJson());

class RejectTransferRequestModel {
  final int status;
  final String message;
  final Data data;

  RejectTransferRequestModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory RejectTransferRequestModel.fromJson(Map<String, dynamic> json) => RejectTransferRequestModel(
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
