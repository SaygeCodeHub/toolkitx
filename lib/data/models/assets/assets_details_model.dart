import 'dart:convert';

FetchAssetsDetailsModel fetchAssetsDetailsModelFromJson(String str) =>
    FetchAssetsDetailsModel.fromJson(json.decode(str));

String fetchAssetsDetailsModelToJson(FetchAssetsDetailsModel data) =>
    json.encode(data.toJson());

class FetchAssetsDetailsModel {
  final int status;
  final String message;
  final Data data;

  FetchAssetsDetailsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchAssetsDetailsModel.fromJson(Map<String, dynamic> json) =>
      FetchAssetsDetailsModel(
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
  final String name;
  final String location;
  final String servicesite;
  final String priority;
  final String assetsubgroup;
  final String status;
  final String subcategory;
  final String owner;
  final String criticalitylevel;
  final String criticality;
  final String barcode;
  final String serial;
  final String parentasset;
  final String position;
  final String model;
  final String po;
  final String startdate;
  final String purchasedate;
  final String warrantystart;
  final String warrantyend;
  final String vendorsite;
  final String manufacturesite;
  final String ittype;
  final String itflag;
  final String subtype;
  final String oaother;
  final String ip;
  final String osname;
  final String otherip;
  final String systemid;
  final String macaddress;
  final String linkedto;
  final String extid;
  final String costcenter;
  final String department;
  final String account;
  final String latitude;
  final String longitude;
  final String orignalvalue;
  final String currency;
  final String endvalue;
  final String deptype;
  final String depstart;
  final String depinterval;
  final String depend;
  final String deptimes;
  final String deprate;
  final String nodepprocess;
  final String scasset;
  final String childpattern;
  final String description;
  final String depyears;
  final String deppurchaseprice;
  final String depresidue;
  final String depunitprice;
  final String depfreight;
  final String deptax;
  final String created;
  final String createdby;
  final String updated;
  final String updateby;
  final String subgroupname;
  final String assetgroupname;
  final String owners;
  final String depfactor;
  final String assetcost;
  final String salvagevalue;

  Data({
    required this.id,
    required this.name,
    required this.location,
    required this.servicesite,
    required this.priority,
    required this.assetsubgroup,
    required this.status,
    required this.subcategory,
    required this.owner,
    required this.criticalitylevel,
    required this.criticality,
    required this.barcode,
    required this.serial,
    required this.parentasset,
    required this.position,
    required this.model,
    required this.po,
    required this.startdate,
    required this.purchasedate,
    required this.warrantystart,
    required this.warrantyend,
    required this.vendorsite,
    required this.manufacturesite,
    required this.ittype,
    required this.itflag,
    required this.subtype,
    required this.oaother,
    required this.ip,
    required this.osname,
    required this.otherip,
    required this.systemid,
    required this.macaddress,
    required this.linkedto,
    required this.extid,
    required this.costcenter,
    required this.department,
    required this.account,
    required this.latitude,
    required this.longitude,
    required this.orignalvalue,
    required this.currency,
    required this.endvalue,
    required this.deptype,
    required this.depstart,
    required this.depinterval,
    required this.depend,
    required this.deptimes,
    required this.deprate,
    required this.nodepprocess,
    required this.scasset,
    required this.childpattern,
    required this.description,
    required this.depyears,
    required this.deppurchaseprice,
    required this.depresidue,
    required this.depunitprice,
    required this.depfreight,
    required this.deptax,
    required this.created,
    required this.createdby,
    required this.updated,
    required this.updateby,
    required this.subgroupname,
    required this.assetgroupname,
    required this.owners,
    required this.depfactor,
    required this.assetcost,
    required this.salvagevalue,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        location: json["location"],
        servicesite: json["servicesite"],
        priority: json["priority"],
        assetsubgroup: json["assetsubgroup"],
        status: json["status"],
        subcategory: json["subcategory"],
        owner: json["owner"],
        criticalitylevel: json["criticalitylevel"],
        criticality: json["criticality"],
        barcode: json["barcode"],
        serial: json["serial"],
        parentasset: json["parentasset"],
        position: json["position"],
        model: json["model"],
        po: json["po"],
        startdate: json["startdate"],
        purchasedate: json["purchasedate"],
        warrantystart: json["warrantystart"],
        warrantyend: json["warrantyend"],
        vendorsite: json["vendorsite"],
        manufacturesite: json["manufacturesite"],
        ittype: json["ittype"],
        itflag: json["itflag"],
        subtype: json["subtype"],
        oaother: json["oaother"],
        ip: json["ip"],
        osname: json["osname"],
        otherip: json["otherip"],
        systemid: json["systemid"],
        macaddress: json["macaddress"],
        linkedto: json["linkedto"],
        extid: json["extid"],
        costcenter: json["costcenter"],
        department: json["department"],
        account: json["account"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        orignalvalue: json["orignalvalue"],
        currency: json["currency"],
        endvalue: json["endvalue"],
        deptype: json["deptype"],
        depstart: json["depstart"],
        depinterval: json["depinterval"],
        depend: json["depend"],
        deptimes: json["deptimes"],
        deprate: json["deprate"],
        nodepprocess: json["nodepprocess"],
        scasset: json["scasset"],
        childpattern: json["childpattern"],
        description: json["description"],
        depyears: json["depyears"],
        deppurchaseprice: json["deppurchaseprice"],
        depresidue: json["depresidue"],
        depunitprice: json["depunitprice"],
        depfreight: json["depfreight"],
        deptax: json["deptax"],
        created: json["created"],
        createdby: json["createdby"],
        updated: json["updated"],
        updateby: json["updateby"],
        subgroupname: json["subgroupname"],
        assetgroupname: json["assetgroupname"],
        owners: json["owners"],
        depfactor: json["depfactor"],
        assetcost: json["assetcost"],
        salvagevalue: json["salvagevalue"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "location": location,
        "servicesite": servicesite,
        "priority": priority,
        "assetsubgroup": assetsubgroup,
        "status": status,
        "subcategory": subcategory,
        "owner": owner,
        "criticalitylevel": criticalitylevel,
        "criticality": criticality,
        "barcode": barcode,
        "serial": serial,
        "parentasset": parentasset,
        "position": position,
        "model": model,
        "po": po,
        "startdate": startdate,
        "purchasedate": purchasedate,
        "warrantystart": warrantystart,
        "warrantyend": warrantyend,
        "vendorsite": vendorsite,
        "manufacturesite": manufacturesite,
        "ittype": ittype,
        "itflag": itflag,
        "subtype": subtype,
        "oaother": oaother,
        "ip": ip,
        "osname": osname,
        "otherip": otherip,
        "systemid": systemid,
        "macaddress": macaddress,
        "linkedto": linkedto,
        "extid": extid,
        "costcenter": costcenter,
        "department": department,
        "account": account,
        "latitude": latitude,
        "longitude": longitude,
        "orignalvalue": orignalvalue,
        "currency": currency,
        "endvalue": endvalue,
        "deptype": deptype,
        "depstart": depstart,
        "depinterval": depinterval,
        "depend": depend,
        "deptimes": deptimes,
        "deprate": deprate,
        "nodepprocess": nodepprocess,
        "scasset": scasset,
        "childpattern": childpattern,
        "description": description,
        "depyears": depyears,
        "deppurchaseprice": deppurchaseprice,
        "depresidue": depresidue,
        "depunitprice": depunitprice,
        "depfreight": depfreight,
        "deptax": deptax,
        "created": created,
        "createdby": createdby,
        "updated": updated,
        "updateby": updateby,
        "subgroupname": subgroupname,
        "assetgroupname": assetgroupname,
        "owners": owners,
        "depfactor": depfactor,
        "assetcost": assetcost,
        "salvagevalue": salvagevalue,
      };
}
