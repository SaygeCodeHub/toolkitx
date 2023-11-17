import 'dart:convert';

ExpenseSubmitForApprovalModel expenseSubmitForApprovalModelFromJson(
        String str) =>
    ExpenseSubmitForApprovalModel.fromJson(json.decode(str));

String expenseSubmitForApprovalModelToJson(
        ExpenseSubmitForApprovalModel data) =>
    json.encode(data.toJson());

class ExpenseSubmitForApprovalModel {
  final int status;
  final String message;
  final Data data;

  ExpenseSubmitForApprovalModel(
      {required this.status, required this.message, required this.data});

  factory ExpenseSubmitForApprovalModel.fromJson(Map<String, dynamic> json) =>
      ExpenseSubmitForApprovalModel(
        status: json["Status"],
        message: json["Message"],
        data: Data.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() =>
      {"Status": status, "Message": message, "Data": data.toJson()};
}

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}
