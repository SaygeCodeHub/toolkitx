import 'dart:convert';

FetchAssetSingleDowntimeModel fetchAssetSingleDowntimeModelFromJson(
        String str) =>
    FetchAssetSingleDowntimeModel.fromJson(json.decode(str));

String fetchAssetSingleDowntimeModelToJson(
        FetchAssetSingleDowntimeModel data) =>
    json.encode(data.toJson());

class FetchAssetSingleDowntimeModel {
  final int status;
  final String message;
  final Data data;

  FetchAssetSingleDowntimeModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchAssetSingleDowntimeModel.fromJson(Map<String, dynamic> json) =>
      FetchAssetSingleDowntimeModel(
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
  final String assetid;
  final String startdatetime;
  final String enddatetime;
  final String totalmin;
  final String woid;
  final String repby;
  final String note;
  final String created;
  final String createdby;
  final String updated;
  final String updateby;
  final String startdate;
  final String starttime;
  final String enddate;
  final String endtime;

  Data({
    required this.id,
    required this.assetid,
    required this.startdatetime,
    required this.enddatetime,
    required this.totalmin,
    required this.woid,
    required this.repby,
    required this.note,
    required this.created,
    required this.createdby,
    required this.updated,
    required this.updateby,
    required this.startdate,
    required this.starttime,
    required this.enddate,
    required this.endtime,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        assetid: json["assetid"],
        startdatetime: json["startdatetime"],
        enddatetime: json["enddatetime"],
        totalmin: json["totalmin"],
        woid: json["woid"],
        repby: json["repby"],
        note: json["note"],
        created: json["created"],
        createdby: json["createdby"],
        updated: json["updated"],
        updateby: json["updateby"],
        startdate: json["startdate"],
        starttime: json["starttime"],
        enddate: json["enddate"],
        endtime: json["endtime"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "assetid": assetid,
        "startdatetime": startdatetime,
        "enddatetime": enddatetime,
        "totalmin": totalmin,
        "woid": woid,
        "repby": repby,
        "note": note,
        "created": created,
        "createdby": createdby,
        "updated": updated,
        "updateby": updateby,
        "startdate": startdate,
        "starttime": starttime,
        "enddate": enddate,
        "endtime": endtime,
      };
}
