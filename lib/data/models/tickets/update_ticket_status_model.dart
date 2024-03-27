import 'dart:convert';

UpdateTicketStatusModel updateTicketStatusModelFromJson(String str) =>
    UpdateTicketStatusModel.fromJson(json.decode(str));

String updateTicketStatusModelToJson(UpdateTicketStatusModel data) =>
    json.encode(data.toJson());

class UpdateTicketStatusModel {
  final int status;
  final String message;
  final Data data;

  UpdateTicketStatusModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UpdateTicketStatusModel.fromJson(Map<String, dynamic> json) =>
      UpdateTicketStatusModel(
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
