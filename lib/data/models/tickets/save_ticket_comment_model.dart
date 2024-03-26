import 'dart:convert';

SaveTicketCommentModel saveTicketCommentModelFromJson(String str) => SaveTicketCommentModel.fromJson(json.decode(str));

String saveTicketCommentModelToJson(SaveTicketCommentModel data) => json.encode(data.toJson());

class SaveTicketCommentModel {
  final int status;
  final String message;
  final Data data;

  SaveTicketCommentModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SaveTicketCommentModel.fromJson(Map<String, dynamic> json) => SaveTicketCommentModel(
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
