import 'dart:convert';

LotoUploadPhotosModel lotoUploadPhotosModelFromJson(String str) => LotoUploadPhotosModel.fromJson(json.decode(str));

String lotoUploadPhotosModelToJson(LotoUploadPhotosModel data) => json.encode(data.toJson());

class LotoUploadPhotosModel {
  final int status;
  final String message;
  final Data data;

  LotoUploadPhotosModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory LotoUploadPhotosModel.fromJson(Map<String, dynamic> json) => LotoUploadPhotosModel(
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
