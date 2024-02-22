import 'dart:convert';

ExpenseWorkingAtNumberDataModel expenseWorkingAtNumberDataModelFromJson(
        String str) =>
    ExpenseWorkingAtNumberDataModel.fromJson(json.decode(str));

String expenseWorkingAtNumberDataModelToJson(
        ExpenseWorkingAtNumberDataModel data) =>
    json.encode(data.toJson());

class ExpenseWorkingAtNumberDataModel {
  final int status;
  final String message;
  final List<Datum> data;

  ExpenseWorkingAtNumberDataModel(
      {required this.status, required this.message, required this.data});

  factory ExpenseWorkingAtNumberDataModel.fromJson(Map<String, dynamic> json) =>
      ExpenseWorkingAtNumberDataModel(
        status: json["Status"],
        message: json["Message"],
        data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  final String id;
  final String name;

  Datum({required this.id, required this.name});

  factory Datum.fromJson(Map<String, dynamic> json) =>
      Datum(id: json["id"] ?? '', name: json["name"] ?? '');

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}
