import 'dart:convert';

SaveTicket2DocumentModel saveTicketDocumentModelFromJson(String str) =>
    SaveTicket2DocumentModel.fromJson(json.decode(str));

String saveTicketDocumentModelToJson(SaveTicket2DocumentModel data) =>
    json.encode(data.toJson());

class SaveTicket2DocumentModel {
  final int status;
  final String message;
  final Data data;

  SaveTicket2DocumentModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SaveTicket2DocumentModel.fromJson(Map<String, dynamic> json) =>
      SaveTicket2DocumentModel(
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
