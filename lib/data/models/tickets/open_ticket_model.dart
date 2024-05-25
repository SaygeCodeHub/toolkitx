import 'dart:convert';

OpenTicketModel openTicketModelFromJson(String str) =>
    OpenTicketModel.fromJson(json.decode(str));

String openTicketModelToJson(OpenTicketModel data) =>
    json.encode(data.toJson());

class OpenTicketModel {
  final int status;
  final String message;
  final Data data;

  OpenTicketModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory OpenTicketModel.fromJson(Map<String, dynamic> json) =>
      OpenTicketModel(
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
