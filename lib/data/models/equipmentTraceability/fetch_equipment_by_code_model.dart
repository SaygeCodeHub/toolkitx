
import 'dart:convert';

FetchEquipmentByCodeModel fetchEquipmentByCodeModelFromJson(String str) => FetchEquipmentByCodeModel.fromJson(json.decode(str));

String fetchEquipmentByCodeModelToJson(FetchEquipmentByCodeModel data) => json.encode(data.toJson());

class FetchEquipmentByCodeModel {
  final int status;
  final String message;
  final Data data;

  FetchEquipmentByCodeModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchEquipmentByCodeModel.fromJson(Map<String, dynamic> json) => FetchEquipmentByCodeModel(
    status: json["Status"],
    message: json["Message"],
    data: Data.fromJson(json["Data"]),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "Data": data.toJson(),
  };
}

class Data {
  final String id;
  final String equipmentcode;
  final String equipmentname;
  final String groupid;
  final String totalitemcount;
  final String currentitemcount;

  Data({
    required this.id,
    required this.equipmentcode,
    required this.equipmentname,
    required this.groupid,
    required this.totalitemcount,
    required this.currentitemcount,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    equipmentcode: json["equipmentcode"],
    equipmentname: json["equipmentname"],
    groupid: json["groupid"],
    totalitemcount: json["totalitemcount"],
    currentitemcount: json["currentitemcount"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "equipmentcode": equipmentcode,
    "equipmentname": equipmentname,
    "groupid": groupid,
    "totalitemcount": totalitemcount,
    "currentitemcount": currentitemcount,
  };
}
