import 'dart:convert';

FetchChatMessagesModel fetchGroupInfoFromJson(String str) =>
    FetchChatMessagesModel.fromJson(json.decode(str));

String fetchGroupInfoToJson(FetchChatMessagesModel data) =>
    json.encode(data.toJson());

class FetchChatMessagesModel {
  final int status;
  final String message;
  final List<FetchChatMessagesDatum> data;

  FetchChatMessagesModel(
      {required this.status, required this.message, required this.data});

  factory FetchChatMessagesModel.fromJson(Map<String, dynamic> json) =>
      FetchChatMessagesModel(
        status: json["Status"],
        message: json["Message"],
        data: List<FetchChatMessagesDatum>.from(
            json["Data"].map((x) => FetchChatMessagesDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class FetchChatMessagesDatum {
  final MsgJson msgJson;
  final int rid;
  final int rType;
  final String userName;

  FetchChatMessagesDatum(
      {required this.rid,
      required this.rType,
      required this.userName,
      required this.msgJson});

  factory FetchChatMessagesDatum.fromJson(Map<String, dynamic> json) =>
      FetchChatMessagesDatum(
          msgJson: MsgJson.fromJson(json["msg_json"]),
          rid: json['rid'] ?? 0,
          rType: json['rtype'] ?? 0,
          userName: json['username'] ?? '');

  Map<String, dynamic> toJson() => {
        "msg_json": msgJson.toJson(),
        'rid': rid,
        'rtype': rType,
        'username': userName
      };
}

class MsgJson {
  final String msgId;
  final String quoteMsgId;
  final String sid;
  final String stype;
  final String rid;
  final String rtype;
  final String msgType;
  final DateTime msgTime;
  final String msg;
  final String sid2;
  final String stype2;
  final int isReceiver;

  MsgJson(
      {required this.msgId,
      required this.quoteMsgId,
      required this.sid,
      required this.stype,
      required this.rid,
      required this.rtype,
      required this.msgType,
      required this.msgTime,
      required this.msg,
      required this.sid2,
      required this.stype2,
      this.isReceiver = 0});

  factory MsgJson.fromJson(Map<String, dynamic> json) => MsgJson(
      msgId: json["msg_id"] ?? '',
      quoteMsgId: json["quote_msg_id"] ?? '',
      sid: json["sid"] ?? '',
      stype: json["stype"] ?? '',
      rid: json["rid"] ?? '',
      rtype: json["rtype"] ?? '',
      msgType: json["msg_type"] ?? '',
      msgTime:
          DateTime.parse(json["msg_time"] ?? DateTime.now().toIso8601String()),
      msg: json["msg"] ?? '',
      sid2: json["sid_2"] ?? '',
      stype2: json["stype_2"] ?? '',
      isReceiver: json['isReceiver'] ?? 1);

  Map<String, dynamic> toJson() => {
        "msg_id": msgId,
        "quote_msg_id": quoteMsgId,
        "sid": sid,
        "stype": stype,
        "rid": rid,
        "rtype": rtype,
        "msg_type": msgType,
        "msg_time": msgTime.toIso8601String(),
        "msg": msg,
        "sid_2": sid2,
        "stype_2": stype2,
        "isReceiver": isReceiver
      };
}
