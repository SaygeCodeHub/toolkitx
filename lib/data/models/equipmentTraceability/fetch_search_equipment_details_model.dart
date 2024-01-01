import 'dart:convert';

FetchSearchEquipmentDetailsModel fetchSearchEquipmentDetailsModelFromJson(
        String str) =>
    FetchSearchEquipmentDetailsModel.fromJson(json.decode(str));

String fetchSearchEquipmentDetailsModelToJson(
        FetchSearchEquipmentDetailsModel data) =>
    json.encode(data.toJson());

class FetchSearchEquipmentDetailsModel {
  final int status;
  final String message;
  final SearchEquipmentDetailsData data;

  FetchSearchEquipmentDetailsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchSearchEquipmentDetailsModel.fromJson(
          Map<String, dynamic> json) =>
      FetchSearchEquipmentDetailsModel(
        status: json["Status"],
        message: json["Message"],
        data: SearchEquipmentDetailsData.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": data.toJson(),
      };
}

class SearchEquipmentDetailsData {
  final String id;
  final String equipmentno;
  final String equipmentname;
  final String articleno;
  final String techPositionno;
  final String techPositionname;
  final String machineid;
  final String equipmentsubtypeid;
  final String roleid;
  final String costcenterid;
  final String description;
  final String machinetype;
  final String costcenter;
  final String rolename;
  final String emailAddress;
  final String barcode;
  final String positionid;
  final String warehouseid;
  final String subtypetext;
  final String positionname;
  final String warehousename;
  final String isitemsbox;
  final String totalitemcount;
  final String currentitemcount;
  final String tooltip;
  final String cantransfer;

  SearchEquipmentDetailsData({
    required this.id,
    required this.equipmentno,
    required this.equipmentname,
    required this.articleno,
    required this.techPositionno,
    required this.techPositionname,
    required this.machineid,
    required this.equipmentsubtypeid,
    required this.roleid,
    required this.costcenterid,
    required this.description,
    required this.machinetype,
    required this.costcenter,
    required this.rolename,
    required this.emailAddress,
    required this.barcode,
    required this.positionid,
    required this.warehouseid,
    required this.subtypetext,
    required this.positionname,
    required this.warehousename,
    required this.isitemsbox,
    required this.totalitemcount,
    required this.currentitemcount,
    required this.tooltip,
    required this.cantransfer,
  });

  factory SearchEquipmentDetailsData.fromJson(Map<String, dynamic> json) =>
      SearchEquipmentDetailsData(
        id: json["id"],
        equipmentno: json["equipmentno"],
        equipmentname: json["equipmentname"],
        articleno: json["articleno"],
        techPositionno: json["tech_positionno"],
        techPositionname: json["tech_positionname"],
        machineid: json["machineid"],
        equipmentsubtypeid: json["equipmentsubtypeid"],
        roleid: json["roleid"],
        costcenterid: json["costcenterid"],
        description: json["description"],
        machinetype: json["machinetype"],
        costcenter: json["costcenter"],
        rolename: json["rolename"],
        emailAddress: json["email_address"],
        barcode: json["barcode"],
        positionid: json["positionid"],
        warehouseid: json["warehouseid"],
        subtypetext: json["subtypetext"],
        positionname: json["positionname"],
        warehousename: json["warehousename"],
        isitemsbox: json["isitemsbox"],
        totalitemcount: json["totalitemcount"],
        currentitemcount: json["currentitemcount"],
        tooltip: json["tooltip"],
        cantransfer: json["cantransfer"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "equipmentno": equipmentno,
        "equipmentname": equipmentname,
        "articleno": articleno,
        "tech_positionno": techPositionno,
        "tech_positionname": techPositionname,
        "machineid": machineid,
        "equipmentsubtypeid": equipmentsubtypeid,
        "roleid": roleid,
        "costcenterid": costcenterid,
        "description": description,
        "machinetype": machinetype,
        "costcenter": costcenter,
        "rolename": rolename,
        "email_address": emailAddress,
        "barcode": barcode,
        "positionid": positionid,
        "warehouseid": warehouseid,
        "subtypetext": subtypetext,
        "positionname": positionname,
        "warehousename": warehousename,
        "isitemsbox": isitemsbox,
        "totalitemcount": totalitemcount,
        "currentitemcount": currentitemcount,
        "tooltip": tooltip,
        "cantransfer": cantransfer,
      };
}
