class ChatData {
  String employeeId;
  String employeeName;
  String message;
  int groupId;
  String groupName;
  String groupPurpose;
  List<Members> members;

  ChatData(
      {this.employeeId = '',
      this.employeeName = '',
      this.message = '',
      this.groupName = '',
      this.groupId = 0,
      this.groupPurpose = '',
      List<Members>? members})
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
}

class Members {
  int id;
  int type = 2;
  String name;
  int isOwner = 0;
  int groupId;

  Members(
      {required this.id,
      required this.name,
      required this.type,
      required this.isOwner,
      this.groupId = 0});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "type": type,
      "name": name,
      "isowner": isOwner,
      "group_id": groupId
    };
  }
}
