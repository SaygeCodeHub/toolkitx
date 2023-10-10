
import 'dart:convert';

RejectLotoModel rejectLotoModelFromJson(String str) => RejectLotoModel.fromJson(json.decode(str));

String rejectLotoModelToJson(RejectLotoModel data) => json.encode(data.toJson());

class RejectLotoModel {
  final int status;
  final String message;
  final Data data;

  RejectLotoModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory RejectLotoModel.fromJson(Map<String, dynamic> json) => RejectLotoModel(
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
