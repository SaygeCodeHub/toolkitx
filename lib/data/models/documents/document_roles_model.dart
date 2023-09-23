// To parse this JSON data, do
//
//     final documentRolesModel = documentRolesModelFromJson(jsonString);

import 'dart:convert';

DocumentRolesModel documentRolesModelFromJson(String str) => DocumentRolesModel.fromJson(json.decode(str));

String documentRolesModelToJson(DocumentRolesModel data) => json.encode(data.toJson());

class DocumentRolesModel {
  final int status;
  final String message;
  final List<Datum> data;

  DocumentRolesModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory DocumentRolesModel.fromJson(Map<String, dynamic> json) => DocumentRolesModel(
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
  final String? groupId;
  final String ?groupName;

  Datum({
    this.groupId,
    this.groupName,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    groupId: json["group_id"],
    groupName: json["group_name"],
  );

  Map<String, dynamic> toJson() => {
    "group_id": groupId,
    "group_name": groupName,
  };
}
