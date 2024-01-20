import 'dart:convert';

FetchExpenseItemDetailsModel fetchExpenseDetailsModelFromJson(String str) =>
    FetchExpenseItemDetailsModel.fromJson(json.decode(str));

String fetchExpenseDetailsModelToJson(FetchExpenseItemDetailsModel data) =>
    json.encode(data.toJson());

class FetchExpenseItemDetailsModel {
  final int status;
  final String message;
  final Data data;

  FetchExpenseItemDetailsModel(
      {required this.status, required this.message, required this.data});

  factory FetchExpenseItemDetailsModel.fromJson(Map<String, dynamic> json) =>
      FetchExpenseItemDetailsModel(
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
  final String id;
  final String reportid;
  final String expensedate;
  final String itemid;
  final String currency;
  final String description;
  final String amount;
  final String exchangerate;
  final String filenames;
  final String workingat;
  final String woid;
  final String wbsid;
  final String projectid;
  final String generalwbsid;

  Data(
      {required this.id,
      required this.reportid,
      required this.expensedate,
      required this.itemid,
      required this.currency,
      required this.description,
      required this.amount,
      required this.exchangerate,
      required this.filenames,
      required this.workingat,
      required this.woid,
      required this.wbsid,
      required this.projectid,
      required this.generalwbsid});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
      id: json["id"] ?? '',
      reportid: json["reportid"] ?? '',
      expensedate: json["expensedate"] ?? '',
      itemid: json["itemid"] ?? '',
      currency: json["currency"] ?? '',
      description: json["description"] ?? '',
      amount: json["amount"] ?? '',
      exchangerate: json["exchangerate"] ?? '',
      filenames: json["filenames"] ?? '',
      workingat: json["workingat"] ?? '',
      woid: json["woid"] ?? '',
      wbsid: json["wbsid"] ?? '',
      projectid: json["projectid"] ?? '',
      generalwbsid: json["generalwbsid"] ?? '');

  Map<String, dynamic> toJson() => {
        "id": id,
        "reportid": reportid,
        "expensedate": expensedate,
        "itemid": itemid,
        "currency": currency,
        "description": description,
        "amount": amount,
        "exchangerate": exchangerate,
        "filenames": filenames,
        "workingat": workingat,
        "woid": woid,
        "wbsid": wbsid,
        "projectid": projectid,
        "generalwbsid": generalwbsid
      };
}
