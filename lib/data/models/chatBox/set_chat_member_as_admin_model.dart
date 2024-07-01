import 'dart:convert';

SetChatMemberAsAdminModel setChatMemberAsAdminModelFromJson(String str) =>
    SetChatMemberAsAdminModel.fromJson(json.decode(str));

String setChatMemberAsAdminModelToJson(SetChatMemberAsAdminModel data) =>
    json.encode(data.toJson());

class SetChatMemberAsAdminModel {
  final int status;
  final String message;
  final Data data;

  SetChatMemberAsAdminModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SetChatMemberAsAdminModel.fromJson(Map<String, dynamic> json) =>
      SetChatMemberAsAdminModel(
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
