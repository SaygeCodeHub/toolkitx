import 'dart:convert';

FetchQualityManagementRolesModel fetchQualityManagementRolesModelFromJson(
        String str) =>
    FetchQualityManagementRolesModel.fromJson(json.decode(str));

String fetchQualityManagementRolesModelToJson(
        FetchQualityManagementRolesModel data) =>
    json.encode(data.toJson());

class FetchQualityManagementRolesModel {
  final int status;
  final String message;
  final List<QMRolesDatum> data;

  FetchQualityManagementRolesModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchQualityManagementRolesModel.fromJson(
          Map<String, dynamic> json) =>
      FetchQualityManagementRolesModel(
        status: json["Status"],
        message: json["Message"],
        data: List<QMRolesDatum>.from(
            json["Data"].map((x) => QMRolesDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class QMRolesDatum {
  final String groupId;
  final String groupName;

  QMRolesDatum({
    required this.groupId,
    required this.groupName,
  });

  factory QMRolesDatum.fromJson(Map<String, dynamic> json) => QMRolesDatum(
        groupId: json["group_id"],
        groupName: json["group_name"],
      );

  Map<String, dynamic> toJson() => {
        "group_id": groupId,
        "group_name": groupName,
      };
}
