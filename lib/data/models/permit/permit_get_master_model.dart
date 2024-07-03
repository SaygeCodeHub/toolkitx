import 'dart:convert';

PermitGetMasterModel permitGetMasterModelFromJson(String str) =>
    PermitGetMasterModel.fromJson(json.decode(str));

String permitGetMasterModelToJson(PermitGetMasterModel data) =>
    json.encode(data.toJson());

class PermitGetMasterModel {
  final int status;
  final String message;
  final List<List<PermitMasterDatum>> data;

  PermitGetMasterModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory PermitGetMasterModel.fromJson(Map<String, dynamic> json) =>
      PermitGetMasterModel(
        status: json["Status"],
        message: json["Message"],
        data: List<List<PermitMasterDatum>>.from(json["Data"].map((x) =>
            List<PermitMasterDatum>.from(
                x.map((x) => PermitMasterDatum.fromJson(x))))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(
            data.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
      };
}

class PermitMasterDatum {
  final int permittype;
  final String? permittypename;
  final int id;
  final String? location;
  final int parentid;
  final String name;
  final String parentlocationname;
  final int powerid;
  final int type;
  final int userId;
  final String userFullName;
  final String userEmail;
  final String userPhone;
  final int appId;

  PermitMasterDatum({
    required this.permittype,
    required this.permittypename,
    required this.id,
    required this.location,
    required this.parentid,
    required this.name,
    required this.parentlocationname,
    required this.powerid,
    required this.type,
    required this.userId,
    required this.userFullName,
    required this.userEmail,
    required this.userPhone,
    required this.appId,
  });

  factory PermitMasterDatum.fromJson(Map<String, dynamic> json) =>
      PermitMasterDatum(
        permittype: json["permittype"] ?? 0,
        permittypename: json["permittypename"] ?? '',
        id: json["id"] ?? 0,
        location: json["location"] ?? '',
        parentid: json["parentid"] ?? 0,
        name: json["name"] ?? '',
        parentlocationname: json["parentlocationname"] ?? '',
        powerid: json["powerid"] ?? 0,
        type: json["type"] ?? 0,
        userId: json["user_id"] ?? 0,
        userFullName: json["user_full_name"] ?? '',
        userEmail: json["user_email"] ?? '',
        userPhone: json["user_phone"] ?? '',
        appId: json["app_id"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "permittype": permittype,
        "permittypename": permittypename,
        "id": id,
        "location": location,
        "parentid": parentid,
        "name": name,
        "parentlocationname": parentlocationname,
        "powerid": powerid,
        "type": type,
        "user_id": userId,
        "user_full_name": userFullName,
        "user_email": userEmail,
        "user_phone": userPhone,
        "app_id": appId,
      };
}
