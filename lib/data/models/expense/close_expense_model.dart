import 'dart:convert';

CloseExpenseModel closeExpenseModelFromJson(String str) =>
    CloseExpenseModel.fromJson(json.decode(str));

String closeExpenseModelToJson(CloseExpenseModel data) =>
    json.encode(data.toJson());

class CloseExpenseModel {
  final int status;
  final String message;
  final Data data;

  CloseExpenseModel(
      {required this.status, required this.message, required this.data});

  factory CloseExpenseModel.fromJson(Map<String, dynamic> json) =>
      CloseExpenseModel(
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
