import 'dart:convert';

UploadPictureModel uploadPictureModelFromJson(String str) =>
    UploadPictureModel.fromJson(json.decode(str));

String uploadPictureModelToJson(UploadPictureModel data) =>
    json.encode(data.toJson());

class UploadPictureModel {
  final int status;
  final String message;
  final List<String> data;

  UploadPictureModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UploadPictureModel.fromJson(Map<String, dynamic> json) =>
      UploadPictureModel(
        status: json["Status"],
        message: json["Message"],
        data: List<String>.from(json["Data"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x)),
      };
}
