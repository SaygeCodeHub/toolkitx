import 'dart:convert';

FetchExpenseDetailsModel fetchExpenseDetailsModelFromJson(String str) =>
    FetchExpenseDetailsModel.fromJson(json.decode(str));

String fetchExpenseDetailsModelToJson(FetchExpenseDetailsModel data) =>
    json.encode(data.toJson());

class FetchExpenseDetailsModel {
  final int status;
  final String message;
  final ExpenseDetailsData data;

  FetchExpenseDetailsModel(
      {required this.status, required this.message, required this.data});

  factory FetchExpenseDetailsModel.fromJson(Map<String, dynamic> json) =>
      FetchExpenseDetailsModel(
        status: json["Status"],
        message: json["Message"],
        data: ExpenseDetailsData.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": data.toJson(),
      };
}

class ExpenseDetailsData {
  final String id;
  final String startdate;
  final String enddate;
  final String status;
  final String purpose;
  final String location;
  final String createdworkforceby;
  final String createduserby;
  final String reportdate;
  final String createdbyname;
  final String itemscount;
  final String currency;
  final String currencyname;
  final String isdraft;
  final String rejectedcount;
  final String employeeid;
  final String statustext;
  final String canEdit;
  final String canSubmitforapproval;
  final String canAdditems;
  final String canApprove;
  final String canClose;
  final String ref;
  final String schedule;
  final List<dynamic> itemlist;
  final String total;
  final List<Log> logs;

  ExpenseDetailsData(
      {required this.logs,
      required this.id,
      required this.startdate,
      required this.enddate,
      required this.status,
      required this.purpose,
      required this.location,
      required this.createdworkforceby,
      required this.createduserby,
      required this.reportdate,
      required this.createdbyname,
      required this.itemscount,
      required this.currency,
      required this.currencyname,
      required this.isdraft,
      required this.rejectedcount,
      required this.employeeid,
      required this.statustext,
      required this.canEdit,
      required this.canSubmitforapproval,
      required this.canAdditems,
      required this.canApprove,
      required this.canClose,
      required this.ref,
      required this.schedule,
      required this.itemlist,
      required this.total});

  factory ExpenseDetailsData.fromJson(Map<String, dynamic> json) =>
      ExpenseDetailsData(
          id: json["id"] ?? '',
          startdate: json["startdate"] ?? '',
          enddate: json["enddate"] ?? '',
          status: json["status"] ?? '',
          purpose: json["purpose"] ?? '',
          location: json["location"] ?? '',
          createdworkforceby: json["createdworkforceby"] ?? '',
          createduserby: json["createduserby"] ?? '',
          reportdate: json["reportdate"] ?? '',
          createdbyname: json["createdbyname"] ?? '',
          itemscount: json["itemscount"] ?? '',
          currency: json["currency"] ?? '',
          currencyname: json["currencyname"] ?? '',
          isdraft: json["isdraft"] ?? '',
          rejectedcount: json["rejectedcount"] ?? '',
          employeeid: json["employeeid"] ?? '',
          statustext: json["statustext"] ?? '',
          canEdit: json["can_edit"] ?? '',
          canSubmitforapproval: json["can_submitforapproval"] ?? '',
          canAdditems: json["can_additems"] ?? '',
          canApprove: json["can_approve"] ?? '',
          canClose: json["can_close"] ?? '',
          ref: json["ref"] ?? '',
          schedule: json["schedule"] ?? '',
          itemlist: List<dynamic>.from(json["itemlist"].map((x) => x)),
          total: json["total"] ?? '',
          logs: List<Log>.from(json["logs"].map((x) => Log.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "id": id,
        "startdate": startdate,
        "enddate": enddate,
        "status": status,
        "purpose": purpose,
        "location": location,
        "createdworkforceby": createdworkforceby,
        "createduserby": createduserby,
        "reportdate": reportdate,
        "createdbyname": createdbyname,
        "itemscount": itemscount,
        "currency": currency,
        "currencyname": currencyname,
        "isdraft": isdraft,
        "rejectedcount": rejectedcount,
        "employeeid": employeeid,
        "statustext": statustext,
        "can_edit": canEdit,
        "can_submitforapproval": canSubmitforapproval,
        "can_additems": canAdditems,
        "can_approve": canApprove,
        "can_close": canClose,
        "ref": ref,
        "schedule": schedule,
        "itemlist": List<dynamic>.from(itemlist.map((x) => x)),
        "total": total,
        "logs": List<dynamic>.from(logs.map((x) => x.toJson())),
      };
}

class Log {
  final String createdAt;
  final String action;
  final String createdBy;

  Log({required this.createdAt, required this.action, required this.createdBy});

  factory Log.fromJson(Map<String, dynamic> json) => Log(
      createdAt: json["created_at"] ?? '',
      action: json["action"] ?? '',
      createdBy: json["created_by"] ?? '');

  Map<String, dynamic> toJson() => {
        "created_at": createdAt,
        "action": action,
        "created_by": createdBy,
      };
}
