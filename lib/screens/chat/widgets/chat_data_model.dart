import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_color.dart';

class ChatData {
  String employeeId;
  String employeeName;
  String message;
  int groupId;
  String groupName;
  String groupPurpose;
  List<Members> members;
  bool isGroup;
  AttachementOptions? options;

  ChatData(
      {this.employeeId = '',
      this.employeeName = '',
      this.message = '',
      this.groupName = '',
      this.groupId = 0,
      this.groupPurpose = '',
      List<Members>? members,
      AttachementOptions? options,
      this.isGroup = false})
      : members = members ?? [];

  List<Map<String, dynamic>> membersToMap() {
    return members.map((member) => member.toMap()).toList();
  }

  Map<String, dynamic> chatToMap() {
    return {
      'employee_id': employeeId,
      'employee_name': employeeName,
      'msg': message,
      'group_name': groupName,
      'group_id': groupId,
      'purpose': groupPurpose
    };
  }

  List<AttachementOptions> attachementOptions() {
    return [
      AttachementOptions(
          icon: Icons.camera_alt, optionName: 'Camera', color: AppColor.pink),
      AttachementOptions(
          icon: Icons.folder, optionName: 'Gallery', color: AppColor.blue),
      AttachementOptions(
          icon: Icons.file_copy,
          optionName: 'Document',
          color: AppColor.darkViolet),
      AttachementOptions(
          icon: Icons.perm_contact_cal,
          optionName: 'Contact',
          color: AppColor.tintBlue)
    ];
  }
}

class AttachementOptions {
  IconData icon;
  String optionName;
  Color color;

  AttachementOptions(
      {required this.icon,
      required this.optionName,
      this.color = AppColor.deepBlue});
}

class Members {
  int id;
  int type = 2;
  String name;
  int isOwner = 0;

  Members(
      {required this.id,
      required this.name,
    required this.type,
    required this.isOwner});

  Map<String, dynamic> toMap() {
    return {"id": id, "type": type, "name": name, "isowner": isOwner};
  }
}
