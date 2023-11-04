import 'dart:convert';

FetchExpenseMasterModel fetchExpenseMasterModelFromJson(String str) =>
    FetchExpenseMasterModel.fromJson(json.decode(str));

String fetchExpenseMasterModelToJson(FetchExpenseMasterModel data) =>
    json.encode(data.toJson());

class FetchExpenseMasterModel {
  final int status;
  final String message;
  final List<List<ExpenseMasterDatum>> data;

  FetchExpenseMasterModel(
      {required this.status, required this.message, required this.data});

  factory FetchExpenseMasterModel.fromJson(Map<String, dynamic> json) =>
      FetchExpenseMasterModel(
        status: json["Status"],
        message: json["Message"],
        data: List<List<ExpenseMasterDatum>>.from(json["Data"].map((x) =>
            List<ExpenseMasterDatum>.from(
                x.map((x) => ExpenseMasterDatum.fromJson(x))))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(
            data.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
      };
}

class ExpenseMasterDatum {
  final dynamic id;
  final String currency;
  final String key;
  final String value;

  ExpenseMasterDatum(
      {required this.id,
      required this.currency,
      required this.key,
      required this.value});

  factory ExpenseMasterDatum.fromJson(Map<String, dynamic> json) =>
      ExpenseMasterDatum(
          id: json["id"] ?? '',
          currency: json["currency"] ?? '',
          key: json["key"] ?? '',
          value: json["value"] ?? '');

  Map<String, dynamic> toJson() => {
        "id": id,
        "currency": currency,
        "key": key,
        "value": value,
      };
}
