import 'dart:convert';

FetchGroupInfoModel fetchGroupInfoModelFromJson(String str) =>
    FetchGroupInfoModel.fromJson(json.decode(str));

String fetchGroupInfoModelToJson(FetchGroupInfoModel data) =>
    json.encode(data.toJson());

class FetchGroupInfoModel {
  final int status;
  final String message;
  final Data data;

  FetchGroupInfoModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchGroupInfoModel.fromJson(Map<String, dynamic> json) =>
      FetchGroupInfoModel(
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
  final String name;
  final String purpose;
  final String date;
  final String isgroupowner;
  final List<Member> members;

  Data({
    required this.name,
    required this.purpose,
    required this.date,
    required this.isgroupowner,
    required this.members,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"] ?? '',
        purpose: json["purpose"] ?? '',
        date: json["date"] ?? '',
        isgroupowner: json["isgroupowner"] ?? '',
        members:
            List<Member>.from(json["members"].map((x) => Member.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "purpose": purpose,
        "date": date,
        "isgroupowner": isgroupowner,
        "members": List<dynamic>.from(members.map((x) => x.toJson())),
      };
}

class Member {
  final int id;
  final int type;
  final int isowner;
  final String date;
  final String username;

  Member({
    required this.id,
    required this.type,
    required this.isowner,
    required this.date,
    required this.username,
  });

  factory Member.fromJson(Map<String, dynamic> json) => Member(
        id: json["id"],
        type: json["type"],
        isowner: json["isowner"],
        date: json["date"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "isowner": isowner,
        "date": date,
        "username": username,
      };
}
