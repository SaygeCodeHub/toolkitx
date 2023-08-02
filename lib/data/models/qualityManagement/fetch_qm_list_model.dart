import 'dart:convert';

FetchQualityManagementListModel fetchQualityManagementListModelFromJson(
        String str) =>
    FetchQualityManagementListModel.fromJson(json.decode(str));

String fetchQualityManagementListModelToJson(
        FetchQualityManagementListModel data) =>
    json.encode(data.toJson());

class FetchQualityManagementListModel {
  final int status;
  final String message;
  final List<QMListDatum> data;

  FetchQualityManagementListModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchQualityManagementListModel.fromJson(Map<String, dynamic> json) =>
      FetchQualityManagementListModel(
        status: json["Status"],
        message: json["Message"],
        data: List<QMListDatum>.from(
            json["Data"].map((x) => QMListDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class QMListDatum {
  final String id;
  final String refno;
  final String eventdatetime;
  final String location;
  final String description;
  final String status;

  QMListDatum({
    required this.id,
    required this.refno,
    required this.eventdatetime,
    required this.location,
    required this.description,
    required this.status,
  });

  factory QMListDatum.fromJson(Map<String, dynamic> json) => QMListDatum(
        id: json["id"],
        refno: json["refno"],
        eventdatetime: json["eventdatetime"],
        location: json["location"],
        description: json["description"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "refno": refno,
        "eventdatetime": eventdatetime,
        "location": location,
        "description": description,
        "status": status,
      };
}
