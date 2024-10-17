import 'dart:convert';

FetchOutgoingInvoicesModel fetchOutgoingInvoicesModelFromJson(String str) =>
    FetchOutgoingInvoicesModel.fromJson(json.decode(str));

String fetchOutgoingInvoicesModelToJson(FetchOutgoingInvoicesModel data) =>
    json.encode(data.toJson());

class FetchOutgoingInvoicesModel {
  final int status;
  final String message;
  final List<OutgoingInvoicesDatum> data;

  FetchOutgoingInvoicesModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchOutgoingInvoicesModel.fromJson(Map<String, dynamic> json) =>
      FetchOutgoingInvoicesModel(
          status: json["Status"],
          message: json["Message"],
          data: List<OutgoingInvoicesDatum>.from(
              json["Data"].map((x) => OutgoingInvoicesDatum.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class OutgoingInvoicesDatum {
  final String id;
  final String entity;
  final String client;
  final String date;
  final String amount;

  OutgoingInvoicesDatum({
    required this.id,
    required this.entity,
    required this.client,
    required this.date,
    required this.amount,
  });

  factory OutgoingInvoicesDatum.fromJson(Map<String, dynamic> json) =>
      OutgoingInvoicesDatum(
        id: json["id"],
        entity: json["entity"] ?? '',
        client: json["client"] ?? '',
        date: json["date"] ?? '',
        amount: json["amount"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "entity": entity,
        "client": client,
        "date": date,
        "amount": amount,
      };
}
