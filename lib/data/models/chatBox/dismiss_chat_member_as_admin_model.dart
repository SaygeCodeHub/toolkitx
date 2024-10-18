import 'dart:convert';

DismissChatMemberAsAdminModel dismissChatMemberAsAdminModelFromJson(
        String str) =>
    DismissChatMemberAsAdminModel.fromJson(json.decode(str));

String dismissChatMemberAsAdminModelToJson(
        DismissChatMemberAsAdminModel data) =>
    json.encode(data.toJson());

class DismissChatMemberAsAdminModel {
  final int status;
  final String message;
  final Data data;

  DismissChatMemberAsAdminModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory DismissChatMemberAsAdminModel.fromJson(Map<String, dynamic> json) =>
      DismissChatMemberAsAdminModel(
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
