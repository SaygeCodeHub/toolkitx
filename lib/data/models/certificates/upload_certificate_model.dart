
import 'dart:convert';

UploadCertificateModel uploadCertificateModelFromJson(String str) => UploadCertificateModel.fromJson(json.decode(str));
String uploadCertificateModelToJson(UploadCertificateModel data) => json.encode(data.toJson());
class UploadCertificateModel {
  final int status;
  final String message;
  final Data data;
  UploadCertificateModel({
    required this.status,
    required this.message,
    required this.data,
  });
  factory UploadCertificateModel.fromJson(Map<String, dynamic> json) => UploadCertificateModel(
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
