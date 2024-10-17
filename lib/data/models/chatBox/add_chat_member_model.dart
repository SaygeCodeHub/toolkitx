import 'dart:convert';

AddChatMemberModel addChatMemberModelFromJson(String str) =>
    AddChatMemberModel.fromJson(json.decode(str));

String addChatMemberModelToJson(AddChatMemberModel data) =>
    json.encode(data.toJson());

class AddChatMemberModel {
  final int status;
  final String message;
  final Data data;

  AddChatMemberModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AddChatMemberModel.fromJson(Map<String, dynamic> json) =>
      AddChatMemberModel(
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
