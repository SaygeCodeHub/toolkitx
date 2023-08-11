import 'dart:convert';

FetchQualityManagementClassificationModel
    fetchQualityManagementClassificationModelFromJson(String str) =>
        FetchQualityManagementClassificationModel.fromJson(json.decode(str));

String fetchQualityManagementClassificationModelToJson(
        FetchQualityManagementClassificationModel data) =>
    json.encode(data.toJson());

class FetchQualityManagementClassificationModel {
  final int status;
  final String message;
  final List<List<QMClassificationDatum>> data;

  FetchQualityManagementClassificationModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchQualityManagementClassificationModel.fromJson(
          Map<String, dynamic> json) =>
      FetchQualityManagementClassificationModel(
        status: json["Status"],
        message: json["Message"],
        data: List<List<QMClassificationDatum>>.from(json["Data"].map((x) =>
            List<QMClassificationDatum>.from(
                x.map((x) => QMClassificationDatum.fromJson(x))))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(
            data.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
      };
}

class QMClassificationDatum {
  final int id;
  final String name;
  final int active;

  QMClassificationDatum({
    required this.id,
    required this.name,
    required this.active,
  });

  factory QMClassificationDatum.fromJson(Map<String, dynamic> json) =>
      QMClassificationDatum(
        id: json["id"],
        name: json["name"] ?? '',
        active: json["active"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "active": active,
      };
}
