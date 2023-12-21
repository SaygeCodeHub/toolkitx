import 'dart:convert';

FetchLogBookDetailsModel fetchLogBookDetailsModelFromJson(String str) =>
    FetchLogBookDetailsModel.fromJson(json.decode(str));

String fetchLogBookDetailsModelToJson(FetchLogBookDetailsModel data) =>
    json.encode(data.toJson());

class FetchLogBookDetailsModel {
  final int status;
  final String message;
  final Data data;

  FetchLogBookDetailsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchLogBookDetailsModel.fromJson(Map<String, dynamic> json) =>
      FetchLogBookDetailsModel(
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
  final String createdbytype;
  final String author;
  final String component;
  final String createdby;
  final String createddate;
  final String description;
  final String priority;
  final String status;
  final String handover;
  final String handoverlog;
  final String offshore;
  final String flags;
  final String locid;
  final String locationname;
  final String logbookid;
  final String logbookname;
  final String activityid;
  final String activityname;
  final String eventdatetime;
  final String editmode;
  final String eventdate;
  final String priorityText;
  final String statusText;

  Data({
    required this.createdbytype,
    required this.author,
    required this.component,
    required this.createdby,
    required this.createddate,
    required this.description,
    required this.priority,
    required this.status,
    required this.handover,
    required this.handoverlog,
    required this.offshore,
    required this.flags,
    required this.locid,
    required this.locationname,
    required this.logbookid,
    required this.logbookname,
    required this.activityid,
    required this.activityname,
    required this.eventdatetime,
    required this.editmode,
    required this.eventdate,
    required this.priorityText,
    required this.statusText,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
      createdbytype: json["createdbytype"] ?? '',
      author: json["author"] ?? '',
      component: json["component"] ?? '',
      createdby: json["createdby"] ?? '',
      createddate: json["createddate"] ?? '',
      description: json["description"] ?? '',
      priority: json["priority"] ?? '',
      status: json["status"] ?? '',
      handover: json["handover"] ?? '',
      handoverlog: json["handoverlog"] ?? '',
      offshore: json["offshore"] ?? '',
      flags: json["flags"] ?? '',
      locid: json["locid"] ?? '',
      locationname: json["locationname"] ?? '',
      logbookid: json["logbookid"] ?? '',
      logbookname: json["logbookname"] ?? '',
      activityid: json["activityid"] ?? '',
      activityname: json["activityname"] ?? '',
      eventdatetime: json["eventdatetime"] ?? '',
      editmode: json["editmode"] ?? '',
      eventdate: json["eventdate"] ?? '',
      priorityText: json["priority_text"] ?? '',
      statusText: json["status_text"] ?? '');

  Map<String, dynamic> toJson() => {
        "createdbytype": createdbytype,
        "author": author,
        "component": component,
        "createdby": createdby,
        "createddate": createddate,
        "description": description,
        "priority": priority,
        "status": status,
        "handover": handover,
        "handoverlog": handoverlog,
        "offshore": offshore,
        "flags": flags,
        "locid": locid,
        "locationname": locationname,
        "logbookid": logbookid,
        "logbookname": logbookname,
        "activityid": activityid,
        "activityname": activityname,
        "eventdatetime": eventdatetime,
        "editmode": editmode,
        "eventdate": eventdate,
        "priority_text": priorityText,
        "status_text": statusText,
      };
}
