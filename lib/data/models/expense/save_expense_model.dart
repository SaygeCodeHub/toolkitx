import 'dart:convert';

SaveExpenseModel saveExpenseModelFromJson(String str) =>
    SaveExpenseModel.fromJson(json.decode(str));

String saveExpenseModelToJson(SaveExpenseModel data) =>
    json.encode(data.toJson());

class SaveExpenseModel {
  final int status;
  final String message;
  final Data data;

  SaveExpenseModel(
      {required this.status, required this.message, required this.data});

  factory SaveExpenseModel.fromJson(Map<String, dynamic> json) =>
      SaveExpenseModel(
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
