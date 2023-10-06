import 'dart:convert';

FetchLotoAssignTeamModel fetchLotoAssignTeamModelFromJson(String str) =>
    FetchLotoAssignTeamModel.fromJson(json.decode(str));

String fetchLotoAssignTeamModelToJson(FetchLotoAssignTeamModel data) =>
    json.encode(data.toJson());

class FetchLotoAssignTeamModel {
  final int status;
  final String message;
  final List<Datum> data;

  FetchLotoAssignTeamModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchLotoAssignTeamModel.fromJson(Map<String, dynamic> json) =>
      FetchLotoAssignTeamModel(
        status: json["Status"],
        message: json["Message"],
        data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  final String id;
  final String name;
  final String membersCount;

  Datum({
    required this.id,
    required this.name,
    required this.membersCount,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        membersCount: json["members_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "members_count": membersCount,
      };
}
