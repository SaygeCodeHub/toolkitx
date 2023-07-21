import 'dart:convert';

SendReminderTodoModel sendReminderTodoModelFromJson(String str) =>
    SendReminderTodoModel.fromJson(json.decode(str));

String sendReminderTodoModelToJson(SendReminderTodoModel data) =>
    json.encode(data.toJson());

class SendReminderTodoModel {
  final int status;
  final String message;
  final Data data;

  SendReminderTodoModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SendReminderTodoModel.fromJson(Map<String, dynamic> json) =>
      SendReminderTodoModel(
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
