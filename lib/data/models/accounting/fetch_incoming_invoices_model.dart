class FetchIncomingInvoicesModel {
  final int status;
  final String message;
  final List<IncomingInvoicesDatum> data;

  FetchIncomingInvoicesModel(
      {required this.status, required this.message, required this.data});

  factory FetchIncomingInvoicesModel.fromJson(Map<String, dynamic> json) =>
      FetchIncomingInvoicesModel(
          status: json["Status"],
          message: json["Message"],
          data: List<IncomingInvoicesDatum>.from(
              json["Data"].map((x) => IncomingInvoicesDatum.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson()))
      };
}

class IncomingInvoicesDatum {
  final String id;
  final String entity;
  final String client;
  final String date;
  final String amount;

  IncomingInvoicesDatum(
      {required this.id,
      required this.entity,
      required this.client,
      required this.date,
      required this.amount});

  factory IncomingInvoicesDatum.fromJson(Map<String, dynamic> json) =>
      IncomingInvoicesDatum(
          id: json["id"],
          entity: json["entity"] ?? '',
          client: json["client"] ?? '',
          date: json["date"] ?? '',
          amount: json["amount"] ?? '');

  Map<String, dynamic> toJson() => {
        "id": id,
        "entity": entity,
        "client": client,
        "date": date,
        "amount": amount
      };
}
