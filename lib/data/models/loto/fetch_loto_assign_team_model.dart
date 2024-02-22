import 'dart:convert';

FetchLotoAssignTeamModel fetchLotoAssignTeamModelFromJson(String str) =>
    FetchLotoAssignTeamModel.fromJson(json.decode(str));

String fetchLotoAssignTeamModelToJson(FetchLotoAssignTeamModel data) =>
    json.encode(data.toJson());

class FetchLotoAssignTeamModel {
  final int status;
  final String message;
  final List<LotoAssignTeamDatum> data;

  FetchLotoAssignTeamModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchLotoAssignTeamModel.fromJson(Map<String, dynamic> json) =>
      FetchLotoAssignTeamModel(
        status: json["Status"],
        message: json["Message"],
        data: List<LotoAssignTeamDatum>.from(
            json["Data"].map((x) => LotoAssignTeamDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class LotoAssignTeamDatum {
  final String id;
  final String name;
  final String membersCount;

  LotoAssignTeamDatum({
    required this.id,
    required this.name,
    required this.membersCount,
  });

  factory LotoAssignTeamDatum.fromJson(Map<String, dynamic> json) =>
      LotoAssignTeamDatum(
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
