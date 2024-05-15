
import 'dart:convert';

UpdateCountModel updateCountModelFromJson(String str) => UpdateCountModel.fromJson(json.decode(str));

String updateCountModelToJson(UpdateCountModel data) => json.encode(data.toJson());

class UpdateCountModel {
  final int? status;
  final String? message;
  final Data? data;

  UpdateCountModel({
    this.status,
    this.message,
    this.data,
  });

  factory UpdateCountModel.fromJson(Map<String, dynamic> json) => UpdateCountModel(
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
  );

  Map<String, dynamic> toJson() => {
  };
}
