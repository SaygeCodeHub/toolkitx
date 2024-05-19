import 'dart:convert';

SendMessageModel sendMessageModelFromJson(String str) =>
    SendMessageModel.fromJson(json.decode(str));

String sendMessageModelToJson(SendMessageModel data) =>
    json.encode(data.toJson());

class SendMessageModel {
  final int status;
  final String message;
  final Data data;

  SendMessageModel(
      {required this.status, required this.message, required this.data});

  factory SendMessageModel.fromJson(Map<String, dynamic> json) =>
      SendMessageModel(
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
  final String msgId;
  final String msgStatus;

  Data({required this.msgId, required this.msgStatus});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        msgId: json["msg_id"],
        msgStatus: json["msg_status"],
      );

  Map<String, dynamic> toJson() => {
        "msg_id": msgId,
        "msg_status": msgStatus,
      };
}
