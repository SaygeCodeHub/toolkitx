class FetchAccountingMasterModel {
  final int? status;
  final String? message;
  final List<List<AccountingMasterDatum>>? data;

  FetchAccountingMasterModel({this.status, this.message, this.data});

  factory FetchAccountingMasterModel.fromJson(Map<String, dynamic> json) =>
      FetchAccountingMasterModel(
          status: json["Status"],
          message: json["Message"],
          data: List<List<AccountingMasterDatum>>.from((json["Data"] == null)
              ? [
                  [AccountingMasterDatum.fromJson({})]
                ]
              : json["Data"].map((x) => List<AccountingMasterDatum>.from(
                  x.map((x) => AccountingMasterDatum.fromJson(x))))));

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(
            data!.map((x) => List<dynamic>.from(x.map((x) => x.toJson()))))
      };
}

class AccountingMasterDatum {
  final int id;
  final String name;
  final String purpose;
  final String currency;

  AccountingMasterDatum(
      {required this.id,
      required this.name,
      required this.purpose,
      required this.currency});

  factory AccountingMasterDatum.fromJson(Map<String, dynamic> json) =>
      AccountingMasterDatum(
          id: json["id"] ?? 0,
          name: json["name"] ?? '',
          purpose: json["purpose"] ?? '',
          currency: json["currency"] ?? '');

  Map<String, dynamic> toJson() =>
      {"id": id, "name": name, "purpose": purpose, "currency": currency};
}
