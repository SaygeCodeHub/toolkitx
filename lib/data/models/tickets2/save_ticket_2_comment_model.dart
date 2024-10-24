import 'dart:convert';

SaveTicket2CommentModel saveTicketCommentModelFromJson(String str) =>
    SaveTicket2CommentModel.fromJson(json.decode(str));

String saveTicketCommentModelToJson(SaveTicket2CommentModel data) =>
    json.encode(data.toJson());

class SaveTicket2CommentModel {
  final int status;
  final String message;
  final Data data;

  SaveTicket2CommentModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SaveTicket2CommentModel.fromJson(Map<String, dynamic> json) =>
      SaveTicket2CommentModel(
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
