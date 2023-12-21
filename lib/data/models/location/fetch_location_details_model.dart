import 'dart:convert';

FetchLocationDetailsModel fetchLocationDetailsModelFromJson(String str) =>
    FetchLocationDetailsModel.fromJson(json.decode(str));

String fetchLocationDetailsModelToJson(FetchLocationDetailsModel data) =>
    json.encode(data.toJson());

class FetchLocationDetailsModel {
  final int status;
  final String message;
  final LocationDetailsData data;

  FetchLocationDetailsModel(
      {required this.status, required this.message, required this.data});

  factory FetchLocationDetailsModel.fromJson(Map<String, dynamic> json) =>
      FetchLocationDetailsModel(
        status: json["Status"],
        message: json["Message"],
        data: LocationDetailsData.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() =>
      {"Status": status, "Message": message, "Data": data.toJson()};
}

class LocationDetailsData {
  final String name;
  final String type;
  final String maptype;
  final String parent;
  final String maplink;
  final String photoid;
  final String photo;
  final String matrix;
  final String level;
  final String operationid;
  final String powerid;
  final String vissimId;
  final String restrictionId;
  final String signAcess;
  final String categoryid;
  final String nesspointId;
  final String layoutImage;
  final String rdspp;
  final String operationstatus;
  final String powerstatus;
  final String restrictionstatus;
  final String categoryname;
  final List<Locdoc> locdocs;
  final List<Customfield> customfields;

  LocationDetailsData(
      {required this.name,
      required this.type,
      required this.maptype,
      required this.parent,
      required this.maplink,
      required this.photoid,
      required this.photo,
      required this.matrix,
      required this.level,
      required this.operationid,
      required this.powerid,
      required this.vissimId,
      required this.restrictionId,
      required this.signAcess,
      required this.categoryid,
      required this.nesspointId,
      required this.layoutImage,
      required this.rdspp,
      required this.operationstatus,
      required this.powerstatus,
      required this.restrictionstatus,
      required this.categoryname,
      required this.locdocs,
      required this.customfields});

  factory LocationDetailsData.fromJson(Map<String, dynamic> json) =>
      LocationDetailsData(
        name: json["name"] ?? '',
        type: json["type"] ?? '',
        maptype: json["maptype"] ?? '',
        parent: json["parent"] ?? '',
        maplink: json["maplink"] ?? '',
        photoid: json["photoid"] ?? '',
        photo: json["photo"] ?? '',
        matrix: json["matrix"] ?? '',
        level: json["level"] ?? '',
        operationid: json["operationid"] ?? '',
        powerid: json["powerid"] ?? '',
        vissimId: json["vissim_id"] ?? '',
        restrictionId: json["restriction_id"] ?? '',
        signAcess: json["sign_acess"] ?? '',
        categoryid: json["categoryid"] ?? '',
        nesspointId: json["nesspoint_id"] ?? '',
        layoutImage: json["layout_image"] ?? '',
        rdspp: json["rdspp"] ?? '',
        operationstatus: json["operationstatus"] ?? '',
        powerstatus: json["powerstatus"] ?? '',
        restrictionstatus: json["restrictionstatus"] ?? '',
        categoryname: json["categoryname"] ?? '',
        locdocs: json["locdocs"] == null
            ? []
            : List<Locdoc>.from(json["locdocs"].map((x) => Locdoc.fromJson(x))),
        customfields: json["customfields"] == null
            ? []
            : List<Customfield>.from(
                json["customfields"].map((x) => Customfield.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
        "maptype": maptype,
        "parent": parent,
        "maplink": maplink,
        "photoid": photoid,
        "photo": photo,
        "matrix": matrix,
        "level": level,
        "operationid": operationid,
        "powerid": powerid,
        "vissim_id": vissimId,
        "restriction_id": restrictionId,
        "sign_acess": signAcess,
        "categoryid": categoryid,
        "nesspoint_id": nesspointId,
        "layout_image": layoutImage,
        "rdspp": rdspp,
        "operationstatus": operationstatus,
        "powerstatus": powerstatus,
        "restrictionstatus": restrictionstatus,
        "categoryname": categoryname,
        "locdocs": List<dynamic>.from(locdocs.map((x) => x.toJson())),
        "customfields": List<dynamic>.from(customfields.map((x) => x.toJson()))
      };
}

class Customfield {
  final String title;
  final String fieldvalue;
  final int fieldtype;
  final int fieldid;
  final String optionid;

  Customfield(
      {required this.title,
      required this.fieldvalue,
      required this.fieldtype,
      required this.fieldid,
      required this.optionid});

  factory Customfield.fromJson(Map<String, dynamic> json) => Customfield(
      title: json["title"] ?? '',
      fieldvalue: json["fieldvalue"] ?? '',
      fieldtype: json["fieldtype"] ?? '',
      fieldid: json["fieldid"] ?? '',
      optionid: json["optionid"] ?? '');

  Map<String, dynamic> toJson() => {
        "title": title,
        "fieldvalue": fieldvalue,
        "fieldtype": fieldtype,
        "fieldid": fieldid,
        "optionid": optionid
      };
}

class Locdoc {
  final String name;
  final String filename;

  Locdoc({required this.name, required this.filename});

  factory Locdoc.fromJson(Map<String, dynamic> json) =>
      Locdoc(name: json["name"] ?? '', filename: json["filename"] ?? '');

  Map<String, dynamic> toJson() => {"name": name, "filename": filename};
}
