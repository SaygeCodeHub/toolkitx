import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_color.dart';

class ChatData {
  String rId;
  String sId;
  String sType;
  String rType;
  int isReceiver;
  String userName;
  String message;
  String groupId;
  String groupName;
  String groupPurpose;
  List<Members> members;
  bool isGroup;
  MediaOptions? options;
  MediaType? mediaType;
  String fileName;
  String date;
  String time;
  String localImagePath;
  String messageType;
  String pickedMedia;
  int unreadMsgCount;
  String dateTime;

  ChatData(
      {this.rId = '',
      this.sId = '',
      this.sType = '',
      this.rType = '',
      this.isReceiver = 0,
      this.userName = '',
      this.message = '',
      this.groupName = '',
      this.groupId = '',
      this.groupPurpose = '',
      List<Members>? members,
      MediaOptions? options,
      this.isGroup = false,
      this.fileName = '',
      MediaType? mediaType,
      this.date = '',
      this.time = '',
      this.localImagePath = '',
      this.messageType = '',
      this.pickedMedia = '',
      this.unreadMsgCount = 0,
      this.dateTime = ''})
      : members = members ?? [];

  List<Map<String, dynamic>> membersToMap() {
    return members.map((member) => member.toMap()).toList();
  }

  Map<String, dynamic> toMap() {
    return {
      'rid': rId,
      'sid': sId,
      'stype': sType,
      'rtype': rType,
      'isReceiver': isReceiver,
      'employee_name': userName,
      'msg': message,
      'group_name': groupName,
      'group_id': groupId,
      'purpose': groupPurpose,
      'date': date,
      'time': time,
      'localImagePath': localImagePath,
      'messageType': messageType,
      'pickedMedia': pickedMedia,
      'unreadMsgCount': unreadMsgCount,
      'dateTime': dateTime
    };
  }

  List<MediaOptions> mediaOptions() {
    return [
      MediaOptions(
          icon: Icons.camera_alt, optionName: 'Camera', color: AppColor.pink),
      MediaOptions(
          icon: Icons.folder, optionName: 'Gallery', color: AppColor.blue),
      MediaOptions(
          icon: Icons.file_copy,
          optionName: 'Document',
          color: AppColor.darkViolet),
      MediaOptions(
          icon: Icons.image, optionName: 'Image', color: AppColor.tintBlue),
      MediaOptions(
          icon: Icons.video_call_outlined,
          optionName: 'Video',
          color: AppColor.tintBlue)
    ];
  }

  List<MediaType> mediaTypes() {
    return [
      MediaType(
          icon: Icons.image, optionName: 'Image', color: AppColor.darkYellow),
      MediaType(
          icon: Icons.video_call_outlined,
          optionName: 'Video',
          color: AppColor.darkGreen)
    ];
  }
}

class MediaType {
  IconData icon;
  String optionName;
  Color color;

  MediaType(
      {required this.icon, required this.optionName, required this.color});
}

class MediaOptions {
  IconData icon;
  String optionName;
  Color color;

  MediaOptions(
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
