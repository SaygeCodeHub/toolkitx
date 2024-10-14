class FetchIncomingInvoiceModel {
  final int status;
  final String message;
  final Data data;

  FetchIncomingInvoiceModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchIncomingInvoiceModel.fromJson(Map<String, dynamic> json) =>
      FetchIncomingInvoiceModel(
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
  final String entityid;
  final String billable;
  final String clientid;
  final String projectid;
  final String invoicedate;
  final String purposeid;
  final String modeid;
  final String comments;
  final String files;
  final String purposename;
  final String othercurrency;
  final String invoiceamount;
  final String otherinvoiceamount;
  final String creditcardid;
  final String entityname;
  final String clientname;
  final String projectname;
  final String othercurrencyname;
  final String creditcardname;
  final String defaultcurrency;

  Data({
    required this.id,
    required this.entityid,
    required this.billable,
    required this.clientid,
    required this.projectid,
    required this.invoicedate,
    required this.purposeid,
    required this.modeid,
    required this.comments,
    required this.files,
    required this.purposename,
    required this.othercurrency,
    required this.invoiceamount,
    required this.otherinvoiceamount,
    required this.creditcardid,
    required this.entityname,
    required this.clientname,
    required this.projectname,
    required this.othercurrencyname,
    required this.creditcardname,
    required this.defaultcurrency,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] ?? "",
        entityid: json["entityid"] ?? "",
        billable: json["billable"] ?? "",
        clientid: json["clientid"] ?? "",
        projectid: json["projectid"] ?? "",
        invoicedate: json["invoicedate"] ?? "",
        purposeid: json["purposeid"] ?? "",
        modeid: json["modeid"] ?? "",
        comments: json["comments"] ?? "",
        files: json["files"] ?? "",
        purposename: json["purposename"] ?? "",
        othercurrency: json["othercurrency"] ?? "",
        invoiceamount: json["invoiceamount"] ?? "",
        otherinvoiceamount: json["otherinvoiceamount"] ?? "",
        creditcardid: json["creditcardid"] ?? "",
        entityname: json["entityname"] ?? "",
        clientname: json["clientname"] ?? "",
        projectname: json["projectname"] ?? "",
        othercurrencyname: json["othercurrencyname"] ?? "",
        creditcardname: json["creditcardname"] ?? "",
        defaultcurrency: json["defaultcurrency"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "entityid": entityid,
        "billable": billable,
        "clientid": clientid,
        "projectid": projectid,
        "invoicedate": invoicedate,
        "purposeid": purposeid,
        "modeid": modeid,
        "comments": comments,
        "files": files,
        "purposename": purposename,
        "othercurrency": othercurrency,
        "invoiceamount": invoiceamount,
        "otherinvoiceamount": otherinvoiceamount,
        "creditcardid": creditcardid,
        "entityname": entityname,
        "clientname": clientname,
        "projectname": projectname,
        "othercurrencyname": othercurrencyname,
        "creditcardname": creditcardname,
        "defaultcurrency": defaultcurrency,
      };
}
