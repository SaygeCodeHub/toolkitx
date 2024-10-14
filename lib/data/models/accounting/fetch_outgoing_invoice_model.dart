class FetchOutgoingInvoiceModel {
  final int status;
  final String message;
  final Data data;

  FetchOutgoingInvoiceModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchOutgoingInvoiceModel.fromJson(Map<String, dynamic> json) =>
      FetchOutgoingInvoiceModel(
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
  final String clientid;
  final String projectid;
  final String invoicedate;
  final String comments;
  final String files;
  final String othercurrency;
  final String invoiceamount;
  final String otherinvoiceamount;
  final String entityname;
  final String clientname;
  final String projectname;
  final String othercurrencyname;
  final String defaultcurrency;

  Data({
    required this.id,
    required this.entityid,
    required this.clientid,
    required this.projectid,
    required this.invoicedate,
    required this.comments,
    required this.files,
    required this.othercurrency,
    required this.invoiceamount,
    required this.otherinvoiceamount,
    required this.entityname,
    required this.clientname,
    required this.projectname,
    required this.othercurrencyname,
    required this.defaultcurrency,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        entityid: json["entityid"],
        clientid: json["clientid"],
        projectid: json["projectid"],
        invoicedate: json["invoicedate"],
        comments: json["comments"],
        files: json["files"],
        othercurrency: json["othercurrency"],
        invoiceamount: json["invoiceamount"],
        otherinvoiceamount: json["otherinvoiceamount"],
        entityname: json["entityname"],
        clientname: json["clientname"],
        projectname: json["projectname"],
        othercurrencyname: json["othercurrencyname"],
        defaultcurrency: json["defaultcurrency"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "entityid": entityid,
        "clientid": clientid,
        "projectid": projectid,
        "invoicedate": invoicedate,
        "comments": comments,
        "files": files,
        "othercurrency": othercurrency,
        "invoiceamount": invoiceamount,
        "otherinvoiceamount": otherinvoiceamount,
        "entityname": entityname,
        "clientname": clientname,
        "projectname": projectname,
        "othercurrencyname": othercurrencyname,
        "defaultcurrency": defaultcurrency,
      };
}
