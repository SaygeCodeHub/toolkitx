import 'dart:convert';

SaveExpenseItemModel saveExpenseItemModelFromJson(String str) =>
    SaveExpenseItemModel.fromJson(json.decode(str));

String saveExpenseItemModelToJson(SaveExpenseItemModel data) =>
    json.encode(data.toJson());

class SaveExpenseItemModel {
  final int status;
  final String message;
  final Data data;

  SaveExpenseItemModel(
      {required this.status, required this.message, required this.data});

  factory SaveExpenseItemModel.fromJson(Map<String, dynamic> json) =>
      SaveExpenseItemModel(
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
