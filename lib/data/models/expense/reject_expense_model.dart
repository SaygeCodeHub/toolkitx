import 'dart:convert';

ExpenseRejectModel expenseRejectModelFromJson(String str) =>
    ExpenseRejectModel.fromJson(json.decode(str));

String expenseRejectModelToJson(ExpenseRejectModel data) =>
    json.encode(data.toJson());

class ExpenseRejectModel {
  final int status;
  final String message;
  final Data data;

  ExpenseRejectModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ExpenseRejectModel.fromJson(Map<String, dynamic> json) =>
      ExpenseRejectModel(
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
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}
