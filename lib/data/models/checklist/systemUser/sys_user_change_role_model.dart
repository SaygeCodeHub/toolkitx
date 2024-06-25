import 'dart:convert';

CheckListRolesModel checkListRolesModelFromJson(String str) =>
    CheckListRolesModel.fromJson(json.decode(str));

String checkListRolesModelToJson(CheckListRolesModel data) =>
    json.encode(data.toJson());

class CheckListRolesModel {
  final int? status;
  final String? message;
  final List<ChecklistRoleData>? data;

  CheckListRolesModel({
    this.status,
    this.message,
    this.data,
  });

  factory CheckListRolesModel.fromJson(Map<String, dynamic> json) =>
      CheckListRolesModel(
        status: json["Status"],
        message: json["Message"],
        data: List<ChecklistRoleData>.from(
            json["Data"].map((x) => ChecklistRoleData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ChecklistRoleData {
  final String? groupId;
  final String? groupName;

  ChecklistRoleData({
    this.groupId,
    this.groupName,
  });

  factory ChecklistRoleData.fromJson(Map<String, dynamic> json) =>
      ChecklistRoleData(
        groupId: json["group_id"],
        groupName: json["group_name"],
      );

  Map<String, dynamic> toJson() => {
        "group_id": groupId,
        "group_name": groupName,
      };
}
