import 'dart:convert';

FetchLotoDetailsModel fetchLotoDetailsModelFromJson(String str) =>
    FetchLotoDetailsModel.fromJson(json.decode(str));

String fetchLotoDetailsModelToJson(FetchLotoDetailsModel data) =>
    json.encode(data.toJson());

class FetchLotoDetailsModel {
  final int status;
  final String message;
  final LotoData data;

  FetchLotoDetailsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchLotoDetailsModel.fromJson(Map<String, dynamic> json) =>
      FetchLotoDetailsModel(
        status: json["Status"],
        message: json["Message"],
        data: LotoData.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": data.toJson(),
      };
}

class LotoData {
  final String id;
  final String locationid;
  final String lotodate;
  final String purpose;
  final String distribution;
  final String checklistid;
  final String removechecklistid;
  final String checklistresponseid;
  final String removechecklistresponseid;
  final String additionalinfo;
  final String status;
  final String createdby;
  final String created;
  final String locname;
  final String createdbyname;
  final String checklistname;
  final String removechecklistname;
  final String purposenames;
  final String distributionnames;
  final String lotoremovedate;
  final String confirmqrcode;
  final String safelockno;
  final String contractor;
  final String assetid;
  final String assetname;
  final String confirmassetqrcode;
  final String location2;
  final String asset2;
  final String isstart;
  final String isapply;
  final String isstartremove;
  final String isremove;
  final String isapprove;
  final String isreject;
  final String assignwf;
  final String assignwfremove;
  final String files;
  final String loto;
  final String statustext;
  final String checklist;
  final String removechecklist;
  final String distributionlist;
  final List<Maplink> maplinks;
  final List<Locdoc> locdocs;
  final List<AssetDocuments> assetdocs;
  final List<Commentslist> commentslist;
  final List<Log> logs;
  final List<Workforce> workforce;
  final List<Attachment> attachments;

  LotoData({
    required this.id,
    required this.locationid,
    required this.lotodate,
    required this.purpose,
    required this.distribution,
    required this.checklistid,
    required this.removechecklistid,
    required this.checklistresponseid,
    required this.removechecklistresponseid,
    required this.additionalinfo,
    required this.status,
    required this.createdby,
    required this.created,
    required this.locname,
    required this.createdbyname,
    required this.checklistname,
    required this.removechecklistname,
    required this.purposenames,
    required this.distributionnames,
    required this.lotoremovedate,
    required this.confirmqrcode,
    required this.safelockno,
    required this.contractor,
    required this.assetid,
    required this.assetname,
    required this.confirmassetqrcode,
    required this.location2,
    required this.asset2,
    required this.isstart,
    required this.isapply,
    required this.isstartremove,
    required this.isremove,
    required this.isapprove,
    required this.isreject,
    required this.assignwf,
    required this.assignwfremove,
    required this.files,
    required this.loto,
    required this.statustext,
    required this.checklist,
    required this.removechecklist,
    required this.distributionlist,
    required this.maplinks,
    required this.locdocs,
    required this.assetdocs,
    required this.commentslist,
    required this.logs,
    required this.workforce,
    required this.attachments,
  });

  factory LotoData.fromJson(Map<String, dynamic> json) => LotoData(
        id: json["id"],
        locationid: json["locationid"],
        lotodate: json["lotodate"],
        purpose: json["purpose"],
        distribution: json["distribution"],
        checklistid: json["checklistid"],
        removechecklistid: json["removechecklistid"],
        checklistresponseid: json["checklistresponseid"],
        removechecklistresponseid: json["removechecklistresponseid"],
        additionalinfo: json["additionalinfo"],
        status: json["status"],
        createdby: json["createdby"],
        created: json["created"],
        locname: json["locname"],
        createdbyname: json["createdbyname"],
        checklistname: json["checklistname"],
        removechecklistname: json["removechecklistname"],
        purposenames: json["purposenames"],
        distributionnames: json["distributionnames"],
        lotoremovedate: json["lotoremovedate"],
        confirmqrcode: json["confirmqrcode"],
        safelockno: json["safelockno"],
        contractor: json["contractor"],
        assetid: json["assetid"],
        assetname: json["assetname"],
        confirmassetqrcode: json["confirmassetqrcode"],
        location2: json["location2"],
        asset2: json["asset2"],
        isstart: json["isstart"],
        isapply: json["isapply"],
        isstartremove: json["isstartremove"],
        isremove: json["isremove"],
        isapprove: json["isapprove"],
        isreject: json["isreject"],
        assignwf: json["assignwf"],
        assignwfremove: json["assignwfremove"],
        files: json["files"],
        loto: json["loto"],
        statustext: json["statustext"],
        checklist: json["checklist"],
        removechecklist: json["removechecklist"],
        distributionlist: json["distributionlist"],
        maplinks: List<Maplink>.from(
            json["maplinks"].map((x) => Maplink.fromJson(x))),
        locdocs:
            List<Locdoc>.from(json["locdocs"].map((x) => Locdoc.fromJson(x))),
        assetdocs: List<AssetDocuments>.from(json["assetdocs"].map((x) => AssetDocuments.fromJson(x))),
        commentslist: List<Commentslist>.from(
            json["commentslist"].map((x) => Commentslist.fromJson(x))),
        logs: List<Log>.from(json["logs"].map((x) => Log.fromJson(x))),
        workforce: List<Workforce>.from(
            json["workforce"].map((x) => Workforce.fromJson(x))),
        attachments: List<Attachment>.from(
            json["attachments"].map((x) => Attachment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "locationid": locationid,
        "lotodate": lotodate,
        "purpose": purpose,
        "distribution": distribution,
        "checklistid": checklistid,
        "removechecklistid": removechecklistid,
        "checklistresponseid": checklistresponseid,
        "removechecklistresponseid": removechecklistresponseid,
        "additionalinfo": additionalinfo,
        "status": status,
        "createdby": createdby,
        "created": created,
        "locname": locname,
        "createdbyname": createdbyname,
        "checklistname": checklistname,
        "removechecklistname": removechecklistname,
        "purposenames": purposenames,
        "distributionnames": distributionnames,
        "lotoremovedate": lotoremovedate,
        "confirmqrcode": confirmqrcode,
        "safelockno": safelockno,
        "contractor": contractor,
        "assetid": assetid,
        "assetname": assetname,
        "confirmassetqrcode": confirmassetqrcode,
        "location2": location2,
        "asset2": asset2,
        "isstart": isstart,
        "isapply": isapply,
        "isstartremove": isstartremove,
        "isremove": isremove,
        "isapprove": isapprove,
        "isreject": isreject,
        "assignwf": assignwf,
        "assignwfremove": assignwfremove,
        "files": files,
        "loto": loto,
        "statustext": statustext,
        "checklist": checklist,
        "removechecklist": removechecklist,
        "distributionlist": distributionlist,
        "maplinks": List<dynamic>.from(maplinks.map((x) => x.toJson())),
        "locdocs": List<dynamic>.from(locdocs.map((x) => x.toJson())),
        "assetdocs": List<dynamic>.from(assetdocs.map((x) => x.toJson())),
        "commentslist": List<dynamic>.from(commentslist.map((x) => x.toJson())),
        "logs": List<dynamic>.from(logs.map((x) => x.toJson())),
        "workforce": List<dynamic>.from(workforce.map((x) => x.toJson())),
        "attachments": List<dynamic>.from(attachments.map((x) => x.toJson())),
      };
}

class Attachment {
  final String attachmentUrl;
  final String attachmentType;

  Attachment({
    required this.attachmentUrl,
    required this.attachmentType,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        attachmentUrl: json["attachment_url"],
        attachmentType: json["attachment_type"],
      );

  Map<String, dynamic> toJson() => {
        "attachment_url": attachmentUrl,
        "attachment_type": attachmentType,
      };
}

class Commentslist {
  final String ownername;
  final String created;
  final String comments;

  Commentslist({
    required this.ownername,
    required this.created,
    required this.comments,
  });

  factory Commentslist.fromJson(Map<String, dynamic> json) => Commentslist(
        ownername: json["ownername"],
        created: json["created"],
        comments: json["comments"],
      );

  Map<String, dynamic> toJson() => {
        "ownername": ownername,
        "created": created,
        "comments": comments,
      };
}

class Locdoc {
  final String name;
  final String filename;

  Locdoc({
    required this.name,
    required this.filename,
  });

  factory Locdoc.fromJson(Map<String, dynamic> json) => Locdoc(
        name: json["name"],
        filename: json["filename"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "filename": filename,
      };
}

class AssetDocuments {
  final String name;
  final String filename;

  AssetDocuments({
    required this.name,
    required this.filename,
  });

  factory AssetDocuments.fromJson(Map<String, dynamic> json) => AssetDocuments(
    name: json["name"],
    filename: json["filename"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "filename": filename,
  };
}

class Log {
  final String createdAt;
  final String action;
  final String createdBy;

  Log({
    required this.createdAt,
    required this.action,
    required this.createdBy,
  });

  factory Log.fromJson(Map<String, dynamic> json) => Log(
        createdAt: json["created_at"],
        action: json["action"],
        createdBy: json["created_by"],
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt,
        "action": action,
        "created_by": createdBy,
      };
}

class Maplink {
  final String location;
  final String name;
  final String link;

  Maplink({
    required this.location,
    required this.name,
    required this.link,
  });

  factory Maplink.fromJson(Map<String, dynamic> json) => Maplink(
        location: json["location"],
        name: json["name"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "location": location,
        "name": name,
        "link": link,
      };
}

class Workforce {
  final String id;
  final String workforceid;
  final String name;
  final String jobTitle;
  final String type;
  final String applyfor;
  final String candelete;

  Workforce({
    required this.id,
    required this.workforceid,
    required this.name,
    required this.jobTitle,
    required this.type,
    required this.applyfor,
    required this.candelete,
  });

  factory Workforce.fromJson(Map<String, dynamic> json) => Workforce(
        id: json["id"],
        workforceid: json["workforceid"],
        name: json["name"],
        jobTitle: json["job_title"] ?? '',
        type: json["type"],
        applyfor: json["applyfor"],
        candelete: json["candelete"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "workforceid": workforceid,
        "name": name,
        "job_title": jobTitle,
        "type": type,
        "applyfor": applyfor,
        "candelete": candelete,
      };
}
