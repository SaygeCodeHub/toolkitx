class FetchTicketsTwoModel {
  final int status;
  final String message;
  final List<TicketListDatum> data;

  FetchTicketsTwoModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchTicketsTwoModel.fromJson(Map<String, dynamic> json) =>
      FetchTicketsTwoModel(
        status: json["Status"],
        message: json["Message"],
        data: List<TicketListDatum>.from(
            json["Data"].map((x) => TicketListDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class TicketListDatum {
  final String id;
  final String ticketNo;
  final String isbug;
  final String header;
  final int commentscount;
  final int doccount;
  final String appname;
  final String owner;
  final String statusname;
  final String priority;

  TicketListDatum({
    required this.id,
    required this.ticketNo,
    required this.isbug,
    required this.header,
    required this.commentscount,
    required this.doccount,
    required this.appname,
    required this.owner,
    required this.statusname,
    required this.priority,
  });

  factory TicketListDatum.fromJson(Map<String, dynamic> json) =>
      TicketListDatum(
        id: json["id"],
        ticketNo: json["ticket_no"],
        isbug: json["isbug"],
        header: json["header"],
        commentscount: json["commentscount"],
        doccount: json["doccount"],
        appname: json["appname"],
        owner: json["owner"],
        statusname: json["statusname"],
        priority: json["priority"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ticket_no": ticketNo,
        "isbug": isbug,
        "header": header,
        "commentscount": commentscount,
        "doccount": doccount,
        "appname": appname,
        "owner": owner,
        "statusname": statusname,
        "priority": priority,
      };
}
