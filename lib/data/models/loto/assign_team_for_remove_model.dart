import 'dart:convert';

AssignTeamForRemoveModel assignTeamForRemoveModelFromJson(String str) =>
    AssignTeamForRemoveModel.fromJson(json.decode(str));

String assignTeamForRemoveModelToJson(AssignTeamForRemoveModel data) =>
    json.encode(data.toJson());

class AssignTeamForRemoveModel {
  final int? status;
  final String? message;
  final Data? data;

  AssignTeamForRemoveModel({
    this.status,
    this.message,
    this.data,
  });

  factory AssignTeamForRemoveModel.fromJson(Map<String, dynamic> json) =>
      AssignTeamForRemoveModel(
        status: json["Status"],
        message: json["Message"],
        data: json["Data"] == null ? null : Data.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": data?.toJson(),
      };
}

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}
