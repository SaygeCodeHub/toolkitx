import 'dart:convert';

SaveTicketModel saveTicketModelFromJson(String str) => SaveTicketModel.fromJson(json.decode(str));

String saveTicketModelToJson(SaveTicketModel data) => json.encode(data.toJson());

class SaveTicketModel {
  final int status;
  final String message;
  final Data data;

  SaveTicketModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SaveTicketModel.fromJson(Map<String, dynamic> json) => SaveTicketModel(
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
