
import 'dart:convert';

FetchMyRequestModel fetchMyRequestModelFromJson(String str) => FetchMyRequestModel.fromJson(json.decode(str));

String fetchMyRequestModelToJson(FetchMyRequestModel data) => json.encode(data.toJson());

class FetchMyRequestModel {
  final int status;
  final String message;
  final Data data;

  FetchMyRequestModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchMyRequestModel.fromJson(Map<String, dynamic> json) => FetchMyRequestModel(
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
  final List<MyRequestTransfer> transfers;
  final List<Workorder> workorders;

  Data({
    required this.transfers,
    required this.workorders,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    transfers: List<MyRequestTransfer>.from(json["transfers"].map((x) => MyRequestTransfer.fromJson(x))),
    workorders: List<Workorder>.from(json["workorders"].map((x) => Workorder.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "transfers": List<dynamic>.from(transfers.map((x) => x.toJson())),
    "workorders": List<dynamic>.from(workorders.map((x) => x.toJson())),
  };
}

class MyRequestTransfer {
  final String id;
  final String equipmentcode;
  final String equipmentname;
  final int groupid;
  final int destinationOwnertype;

  MyRequestTransfer({
    required this.id,
    required this.equipmentcode,
    required this.equipmentname,
    required this.groupid,
    required this.destinationOwnertype,
  });

  factory MyRequestTransfer.fromJson(Map<String, dynamic> json) => MyRequestTransfer(
    id: json["id"],
    equipmentcode: json["equipmentcode"],
    equipmentname: json["equipmentname"],
    groupid: json["groupid"],
    destinationOwnertype: json["destination_ownertype"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "equipmentcode": equipmentcode,
    "equipmentname": equipmentname,
    "groupid": groupid,
    "destination_ownertype": destinationOwnertype,
  };
}

class Workorder {
  final int id;
  final String woname;

  Workorder({
    required this.id,
    required this.woname,
  });

  factory Workorder.fromJson(Map<String, dynamic> json) => Workorder(
    id: json["id"],
    woname: json["woname"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "woname": woname,
  };
}
