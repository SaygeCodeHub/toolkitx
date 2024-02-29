import 'dart:convert';

CreateChatGroupModel createChatGroupModelFromJson(String str) =>
    CreateChatGroupModel.fromJson(json.decode(str));

String createChatGroupModelToJson(CreateChatGroupModel data) =>
    json.encode(data.toJson());

class CreateChatGroupModel {
  final int status;
  final String message;
  final Data data;

  CreateChatGroupModel(
      {required this.status, required this.message, required this.data});

  factory CreateChatGroupModel.fromJson(Map<String, dynamic> json) =>
      CreateChatGroupModel(
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
  final int groupId;

  Data({required this.groupId});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        groupId: json["group_id"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "group_id": groupId,
      };
}
