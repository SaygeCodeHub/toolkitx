class CreateIncomingInvoiceModel {
  final int status;
  final String message;
  final Data data;

  CreateIncomingInvoiceModel(
      {required this.status, required this.message, required this.data});

  factory CreateIncomingInvoiceModel.fromJson(Map<String, dynamic> json) =>
      CreateIncomingInvoiceModel(
          status: json["Status"],
          message: json["Message"],
          data: Data.fromJson(json["Data"]));

  Map<String, dynamic> toJson() =>
      {"Status": status, "Message": message, "Data": data.toJson()};
}

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}
