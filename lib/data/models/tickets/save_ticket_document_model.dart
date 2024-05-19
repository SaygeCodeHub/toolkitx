import 'dart:convert';

SaveTicketDocumentModel saveTicketDocumentModelFromJson(String str) =>
    SaveTicketDocumentModel.fromJson(json.decode(str));

String saveTicketDocumentModelToJson(SaveTicketDocumentModel data) =>
    json.encode(data.toJson());

class SaveTicketDocumentModel {
  final int status;
  final String message;
  final Data data;

  SaveTicketDocumentModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SaveTicketDocumentModel.fromJson(Map<String, dynamic> json) =>
      SaveTicketDocumentModel(
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

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}
