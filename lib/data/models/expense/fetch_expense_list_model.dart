import 'dart:convert';

FetchExpenseListModel fetchExpenseListModelFromJson(String str) =>
    FetchExpenseListModel.fromJson(json.decode(str));

String fetchExpenseListModelToJson(FetchExpenseListModel data) =>
    json.encode(data.toJson());

class FetchExpenseListModel {
  final int status;
  final String message;
  final List<ExpenseListDatum> expenseListData;

  FetchExpenseListModel(
      {required this.status,
      required this.message,
      required this.expenseListData});

  factory FetchExpenseListModel.fromJson(Map<String, dynamic> json) =>
      FetchExpenseListModel(
        status: json["Status"],
        message: json["Message"],
        expenseListData: List<ExpenseListDatum>.from(
            json["Data"].map((x) => ExpenseListDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(expenseListData.map((x) => x.toJson())),
      };
}

class ExpenseListDatum {
  final String id;
  final String refno;
  final String schedule;
  final String location;
  final String owner;
  final int status;
  final String statustext;
  final int isdraft;
  final int canAdditems;
  final String cost;

  ExpenseListDatum(
      {required this.id,
      required this.refno,
      required this.schedule,
      required this.location,
      required this.owner,
      required this.status,
      required this.statustext,
      required this.isdraft,
      required this.canAdditems,
      required this.cost});

  factory ExpenseListDatum.fromJson(Map<String, dynamic> json) =>
      ExpenseListDatum(
          id: json["id"] ?? '',
          refno: json["refno"] ?? '',
          schedule: json["schedule"] ?? '',
          location: json["location"] ?? '',
          owner: json["owner"] ?? '',
          status: json["status"] ?? '',
          statustext: json["statustext"] ?? '',
          isdraft: json["isdraft"] ?? '',
          canAdditems: json["can_additems"] ?? '',
          cost: json["cost"] ?? '');

  Map<String, dynamic> toJson() => {
        "id": id,
        "refno": refno,
        "schedule": schedule,
        "location": location,
        "owner": owner,
        "status": status,
        "statustext": statustext,
        "isdraft": isdraft,
        "can_additems": canAdditems,
        "cost": cost,
      };
}
