import 'dart:convert';

UpdateTicket2StatusModel updateTicketStatusModelFromJson(String str) =>
    UpdateTicket2StatusModel.fromJson(json.decode(str));

String updateTicketStatusModelToJson(UpdateTicket2StatusModel data) =>
    json.encode(data.toJson());

class UpdateTicket2StatusModel {
  final int status;
  final String message;
  final Data data;

  UpdateTicket2StatusModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UpdateTicket2StatusModel.fromJson(Map<String, dynamic> json) =>
      UpdateTicket2StatusModel(
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
