// To parse this JSON data, do
//
//     final fetchCertificatesModel = fetchCertificatesModelFromJson(jsonString);
import 'dart:convert';

FetchCertificatesModel fetchCertificatesModelFromJson(String str) =>
    FetchCertificatesModel.fromJson(json.decode(str));

String fetchCertificatesModelToJson(FetchCertificatesModel data) =>
    json.encode(data.toJson());

class FetchCertificatesModel {
  final int status;
  final String message;
  final List<CertificateListDatum> data;

  FetchCertificatesModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchCertificatesModel.fromJson(Map<String, dynamic> json) =>
      FetchCertificatesModel(
        status: json["Status"],
        message: json["Message"],
        data: List<CertificateListDatum>.from(
            json["Data"].map((x) => CertificateListDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class CertificateListDatum {
  final String id;
  final String name;
  final String actualDates;
  final dynamic newDates;
  final String actualCertificate;
  final String newCertificate;
  final dynamic status;
  final String expired;
  final String accesscertificate;
  final String accessfeedback;
  final String accessfeedbackedit;

  CertificateListDatum({
    required this.id,
    required this.name,
    required this.actualDates,
    required this.newDates,
    required this.actualCertificate,
    required this.newCertificate,
    required this.status,
    required this.expired,
    required this.accesscertificate,
    required this.accessfeedback,
    required this.accessfeedbackedit,
  });

  factory CertificateListDatum.fromJson(Map<String, dynamic> json) =>
      CertificateListDatum(
        id: json["id"],
        name: json["name"],
        actualDates: json["actual_dates"] ?? '',
        newDates: json["new_dates"] ?? '',
        actualCertificate: json["actual_certificate"],
        newCertificate: json["new_certificate"],
        status: json["status"] ?? '',
        expired: json["expired"],
        accesscertificate: json["accesscertificate"],
        accessfeedback: json["accessfeedback"],
        accessfeedbackedit: json["accessfeedbackedit"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "actual_dates": actualDates,
        "new_dates": newDates,
        "actual_certificate": actualCertificate,
        "new_certificate": newCertificate,
        "status": status,
        "expired": expired,
        "accesscertificate": accesscertificate,
        "accessfeedback": accessfeedback,
        "accessfeedbackedit": accessfeedbackedit,
      };
}
