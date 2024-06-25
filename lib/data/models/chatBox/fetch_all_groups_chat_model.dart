import 'dart:convert';

AllGroupChatList allGroupChatListFromJson(String str) =>
    AllGroupChatList.fromJson(json.decode(str));

String allGroupChatListToJson(AllGroupChatList data) =>
    json.encode(data.toJson());

class AllGroupChatList {
  final int status;
  final String message;
  final List<AllGroupChatListData> data;

  AllGroupChatList({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AllGroupChatList.fromJson(Map<String, dynamic> json) =>
      AllGroupChatList(
        status: json["Status"],
        message: json["Message"],
        data: List<AllGroupChatListData>.from(
            json["Data"].map((x) => AllGroupChatListData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class AllGroupChatListData {
  final String id;
  final String name;
  final String purpose;
  final String date;
  final List<Member> members;

  AllGroupChatListData({
    required this.id,
    required this.name,
    required this.purpose,
    required this.date,
    required this.members,
  });

  factory AllGroupChatListData.fromJson(Map<String, dynamic> json) =>
      AllGroupChatListData(
        id: json["id"],
        name: json["name"],
        purpose: json["purpose"],
        date: json["date"],
        members:
            List<Member>.from(json["members"].map((x) => Member.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "purpose": purpose,
        "date": date,
        "members": List<dynamic>.from(members.map((x) => x.toJson())),
      };
}

class Member {
  final int id;
  final int type;
  final int isowner;
  final String date;
  final String username;
  final String groupId;

  Member({
    required this.id,
    required this.type,
    required this.isowner,
    required this.date,
    required this.username,
    required this.groupId,
  });

  factory Member.fromJson(Map<String, dynamic> json) => Member(
        id: json["id"],
        type: json["type"],
        isowner: json["isowner"],
        date: json["date"],
        username: json["username"],
        groupId: json["group_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "isowner": isowner,
        "date": date,
        "username": username,
        "group_id": groupId,
      };
}
