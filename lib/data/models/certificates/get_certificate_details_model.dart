
import 'dart:convert';

FetchCertificateDetailsModel fetchCertificateDetailsModelFromJson(String str) => FetchCertificateDetailsModel.fromJson(json.decode(str));

String fetchCertificateDetailsModelToJson(FetchCertificateDetailsModel data) => json.encode(data.toJson());

class FetchCertificateDetailsModel {
  final int status;
  final String message;
  final Data data;

  FetchCertificateDetailsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchCertificateDetailsModel.fromJson(Map<String, dynamic> json) => FetchCertificateDetailsModel(
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
  final String id;
  final String newStartDate;
  final String newEndDate;
  final String status;
  final String processedNewDate;
  final String newDates;

  Data({
    required this.id,
    required this.newStartDate,
    required this.newEndDate,
    required this.status,
    required this.processedNewDate,
    required this.newDates,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    newStartDate: json["new_start_date"],
    newEndDate: json["new_end_date"],
    status: json["status"],
    processedNewDate: json["processed_new_date"],
    newDates: json["new_dates"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "new_start_date": newStartDate,
    "new_end_date": newEndDate,
    "status": status,
    "processed_new_date": processedNewDate,
    "new_dates": newDates,
  };
}
