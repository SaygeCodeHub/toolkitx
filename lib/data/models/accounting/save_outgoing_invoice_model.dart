import 'dart:convert';

SaveOutgoingInvoiceModel saveOutgoingInvoiceModelFromJson(String str) => SaveOutgoingInvoiceModel.fromJson(json.decode(str));

String saveOutgoingInvoiceModelToJson(SaveOutgoingInvoiceModel data) => json.encode(data.toJson());

class SaveOutgoingInvoiceModel {
  final int status;
  final String message;
  final Data data;

  SaveOutgoingInvoiceModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SaveOutgoingInvoiceModel.fromJson(Map<String, dynamic> json) => SaveOutgoingInvoiceModel(
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
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data(
  );

  Map<String, dynamic> toJson() => {
  };
}
