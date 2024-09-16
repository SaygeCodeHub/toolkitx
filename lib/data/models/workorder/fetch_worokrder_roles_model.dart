import 'dart:convert';

FetchWorkOrderRolesModel fetchWorkOrderRolesModelFromJson(String str) => FetchWorkOrderRolesModel.fromJson(json.decode(str));

String fetchWorkOrderRolesModelToJson(FetchWorkOrderRolesModel data) => json.encode(data.toJson());

class FetchWorkOrderRolesModel {
  final int status;
  final String message;
  final List<Datum> data;

  FetchWorkOrderRolesModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchWorkOrderRolesModel.fromJson(Map<String, dynamic> json) => FetchWorkOrderRolesModel(
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
  final String groupId;
  final String groupName;
  final String groupOcc;

  Datum({
    required this.groupId,
    required this.groupName,
    required this.groupOcc,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    groupId: json["group_id"] ?? '',
    groupName: json["group_name"] ?? '',
    groupOcc: json["group_occ"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "group_id": groupId,
    "group_name": groupName,
    "group_occ": groupOcc,
  };
}
