class FetchBankStatementModel {
  final int status;
  final String message;
  final Data data;

  FetchBankStatementModel(
      {required this.status, required this.message, required this.data});

  factory FetchBankStatementModel.fromJson(Map<String, dynamic> json) =>
      FetchBankStatementModel(
          status: json["Status"],
          message: json["Message"],
          data: Data.fromJson(json["Data"]));

  Map<String, dynamic> toJson() =>
      {"Status": status, "Message": message, "Data": data.toJson()};
}

class Data {
  final String id;
  final String entityid;
  final String bankid;
  final String stmtMonth;
  final String stmtYear;
  final String files;

  Data(
      {required this.id,
      required this.entityid,
      required this.bankid,
      required this.stmtMonth,
      required this.stmtYear,
      required this.files});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
      id: json["id"],
      entityid: json["entityid"] ?? '',
      bankid: json["bankid"] ?? '',
      stmtMonth: json["stmt_month"] ?? '',
      stmtYear: json["stmt_year"] ?? '',
      files: json["files"] ?? '');

  Map<String, dynamic> toJson() => {
        "id": id,
        "entityid": entityid,
        "bankid": bankid,
        "stmt_month": stmtMonth,
        "stmt_year": stmtYear,
        "files": files
      };
}
