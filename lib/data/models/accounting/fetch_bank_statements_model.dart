class FetchBankStatementsModel {
  final int status;
  final String message;
  final List<BankStatementsDatum> data;

  FetchBankStatementsModel(
      {required this.status, required this.message, required this.data});

  factory FetchBankStatementsModel.fromJson(Map<String, dynamic> json) =>
      FetchBankStatementsModel(
          status: json["Status"],
          message: json["Message"],
          data: List<BankStatementsDatum>.from(
              json["Data"].map((x) => BankStatementsDatum.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson()))
      };
}

class BankStatementsDatum {
  final String id;
  final String entity;
  final String bank;
  final String date;
  final String file;

  BankStatementsDatum(
      {required this.id,
      required this.entity,
      required this.bank,
      required this.date,
      required this.file});

  factory BankStatementsDatum.fromJson(Map<String, dynamic> json) =>
      BankStatementsDatum(
          id: json["id"],
          entity: json["entity"] ?? '',
          bank: json["bank"] ?? '',
          date: json["date"] ?? '',
          file: json["file"] ?? '');

  Map<String, dynamic> toJson() =>
      {"id": id, "entity": entity, "bank": bank, "date": date, "file": file};
}
