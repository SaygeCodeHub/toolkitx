import 'dart:convert';

FetchTicketDetailsModel fetchTicketDetailsModelFromJson(String str) =>
    FetchTicketDetailsModel.fromJson(json.decode(str));

String fetchTicketDetailsModelToJson(FetchTicketDetailsModel data) =>
    json.encode(data.toJson());

class FetchTicketDetailsModel {
  final int status;
  final String message;
  final TicketData data;

  FetchTicketDetailsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchTicketDetailsModel.fromJson(Map<String, dynamic> json) =>
      FetchTicketDetailsModel(
        status: json["Status"],
        message: json["Message"],
        data: TicketData.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": data.toJson(),
      };
}

class TicketData {
  final String ticketno;
  final String header;
  final String description;
  final String application;
  final String appname;
  final String etd;
  final String isbug;
  final String createdby;
  final String author;
  final String authoremail;
  final String createddate;
  final String notifyUserids;
  final String updatedby;
  final String updatedbyauthor;
  final String updateddate;
  final String voneeded;
  final String completiondate;
  final String priority;
  final String priorityname;
  final String status;
  final String statusname;
  final String invoice;
  final String commentscount;
  final String doccount;
  final String candeferred;
  final String canestimateedt;
  final String canapprovedfordevelopment;
  final String canclose;
  final String canwaitingfordevelopmentapproval;
  final String candevelopment;
  final String cantesting;
  final String canapproved;
  final String canrolledout;
  final String canaddcomments;
  final String canadddocuments;
  final String id;

  TicketData({
    required this.ticketno,
    required this.header,
    required this.description,
    required this.application,
    required this.appname,
    required this.etd,
    required this.isbug,
    required this.createdby,
    required this.author,
    required this.authoremail,
    required this.createddate,
    required this.notifyUserids,
    required this.updatedby,
    required this.updatedbyauthor,
    required this.updateddate,
    required this.voneeded,
    required this.completiondate,
    required this.priority,
    required this.priorityname,
    required this.status,
    required this.statusname,
    required this.invoice,
    required this.commentscount,
    required this.doccount,
    required this.candeferred,
    required this.canestimateedt,
    required this.canapprovedfordevelopment,
    required this.canclose,
    required this.canwaitingfordevelopmentapproval,
    required this.candevelopment,
    required this.cantesting,
    required this.canapproved,
    required this.canrolledout,
    required this.canaddcomments,
    required this.canadddocuments,
    required this.id,
  });

  factory TicketData.fromJson(Map<String, dynamic> json) => TicketData(
        ticketno: json["ticketno"],
        header: json["header"],
        description: json["description"],
        application: json["application"],
        appname: json["appname"],
        etd: json["etd"],
        isbug: json["isbug"],
        createdby: json["createdby"],
        author: json["author"],
        authoremail: json["authoremail"],
        createddate: json["createddate"],
        notifyUserids: json["notify_userids"],
        updatedby: json["updatedby"],
        updatedbyauthor: json["updatedbyauthor"],
        updateddate: json["updateddate"],
        voneeded: json["voneeded"],
        completiondate: json["completiondate"],
        priority: json["priority"],
        priorityname: json["priorityname"],
        status: json["status"],
        statusname: json["statusname"],
        invoice: json["invoice"],
        commentscount: json["commentscount"],
        doccount: json["doccount"],
        candeferred: json["candeferred"],
        canestimateedt: json["canestimateedt"],
        canapprovedfordevelopment: json["canapprovedfordevelopment"],
        canclose: json["canclose"],
        canwaitingfordevelopmentapproval:
            json["canwaitingfordevelopmentapproval"],
        candevelopment: json["candevelopment"],
        cantesting: json["cantesting"],
        canapproved: json["canapproved"],
        canrolledout: json["canrolledout"],
        canaddcomments: json["canaddcomments"],
        canadddocuments: json["canadddocuments"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "ticketno": ticketno,
        "header": header,
        "description": description,
        "application": application,
        "appname": appname,
        "etd": etd,
        "isbug": isbug,
        "createdby": createdby,
        "author": author,
        "authoremail": authoremail,
        "createddate": createddate,
        "notify_userids": notifyUserids,
        "updatedby": updatedby,
        "updatedbyauthor": updatedbyauthor,
        "updateddate": updateddate,
        "voneeded": voneeded,
        "completiondate": completiondate,
        "priority": priority,
        "priorityname": priorityname,
        "status": status,
        "statusname": statusname,
        "invoice": invoice,
        "commentscount": commentscount,
        "doccount": doccount,
        "candeferred": candeferred,
        "canestimateedt": canestimateedt,
        "canapprovedfordevelopment": canapprovedfordevelopment,
        "canclose": canclose,
        "canwaitingfordevelopmentapproval": canwaitingfordevelopmentapproval,
        "candevelopment": candevelopment,
        "cantesting": cantesting,
        "canapproved": canapproved,
        "canrolledout": canrolledout,
        "canaddcomments": canaddcomments,
        "canadddocuments": canadddocuments,
        "id": id,
      };
}
