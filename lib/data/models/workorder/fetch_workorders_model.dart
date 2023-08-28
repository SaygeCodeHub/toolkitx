import 'dart:convert';

FetchWorkOrdersModel fetchWorkOrdersModelFromJson(String str) =>
    FetchWorkOrdersModel.fromJson(json.decode(str));

String fetchWorkOrdersModelToJson(FetchWorkOrdersModel data) =>
    json.encode(data.toJson());

class FetchWorkOrdersModel {
  final int status;
  final String message;
  final List<WorkOrderDatum> data;

  FetchWorkOrdersModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchWorkOrdersModel.fromJson(Map<String, dynamic> json) =>
      FetchWorkOrdersModel(
        status: json["Status"],
        message: json["Message"],
        data: List<WorkOrderDatum>.from(
            json["Data"].map((x) => WorkOrderDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class WorkOrderDatum {
  final String id;
  final String woname;
  final String contractorname;
  final String type;
  final String status;
  final String schedule;
  final String subject;
  final int istender;

  WorkOrderDatum({
    required this.id,
    required this.woname,
    required this.contractorname,
    required this.type,
    required this.status,
    required this.schedule,
    required this.subject,
    required this.istender,
  });

  factory WorkOrderDatum.fromJson(Map<String, dynamic> json) => WorkOrderDatum(
        id: json["id"],
        woname: json["woname"],
        contractorname: json["contractorname"],
        type: json["type"],
        status: json["status"],
        schedule: json["schedule"],
        subject: json["subject"],
        istender: json["istender"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "woname": woname,
        "contractorname": contractorname,
        "type": type,
        "status": status,
        "schedule": schedule,
        "subject": subject,
        "istender": istender,
      };
}
