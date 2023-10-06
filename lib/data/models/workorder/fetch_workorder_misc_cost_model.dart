import 'dart:convert';

FetchWorkOrderSingleMiscCostModel fetchWorkOrderSingleMiscCostFromJson(
        String str) =>
    FetchWorkOrderSingleMiscCostModel.fromJson(json.decode(str));

String fetchWorkOrderSingleMiscCostToJson(
        FetchWorkOrderSingleMiscCostModel data) =>
    json.encode(data.toJson());

class FetchWorkOrderSingleMiscCostModel {
  final int status;
  final String message;
  final Data data;

  FetchWorkOrderSingleMiscCostModel(
      {required this.status, required this.message, required this.data});

  factory FetchWorkOrderSingleMiscCostModel.fromJson(
          Map<String, dynamic> json) =>
      FetchWorkOrderSingleMiscCostModel(
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
  final String service;
  final String vendor;
  final String quan;
  final String plannedquan;
  final String currency;
  final String amount;
  final String workorderid;
  final String marginpercent;
  final String taxid;
  final String taxpercent;
  final String categoryid;

  Data({
    required this.id,
    required this.service,
    required this.vendor,
    required this.quan,
    required this.plannedquan,
    required this.currency,
    required this.amount,
    required this.workorderid,
    required this.marginpercent,
    required this.taxid,
    required this.taxpercent,
    required this.categoryid,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
      id: json["id"] ?? '',
      service: json["service"] ?? '',
      vendor: json["vendor"] ?? '',
      quan: json["quan"] ?? '',
      plannedquan: json["plannedquan"] ?? '',
      currency: json["currency"] ?? '',
      amount: json["amount"] ?? '',
      workorderid: json["workorderid"] ?? '',
      marginpercent: json["marginpercent"] ?? '',
      taxid: json["taxid"] ?? '',
      taxpercent: json["taxpercent"] ?? '',
      categoryid: json["categoryid"] ?? '');

  Map<String, dynamic> toJson() => {
        "id": id,
        "service": service,
        "vendor": vendor,
        "quan": quan,
        "plannedquan": plannedquan,
        "currency": currency,
        "amount": amount,
        "workorderid": workorderid,
        "marginpercent": marginpercent,
        "taxid": taxid,
        "taxpercent": taxpercent,
        "categoryid": categoryid,
      };
}
