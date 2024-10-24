import 'dart:convert';

FetchQualityManagementDetailsModel fetchQualityManagementDetailsModelFromJson(
        String str) =>
    FetchQualityManagementDetailsModel.fromJson(json.decode(str));

String fetchQualityManagementDetailsModelToJson(
        FetchQualityManagementDetailsModel data) =>
    json.encode(data.toJson());

class FetchQualityManagementDetailsModel {
  final int status;
  final String message;
  final QMDetailsData data;

  FetchQualityManagementDetailsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchQualityManagementDetailsModel.fromJson(
          Map<String, dynamic> json) =>
      FetchQualityManagementDetailsModel(
        status: json["Status"],
        message: json["Message"],
        data: QMDetailsData.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": data.toJson(),
      };
}

class QMDetailsData {
  final String id;
  final String eventdatetime;
  final String status;
  final String description;
  final String site;
  final String location;
  final String companyid;
  final String severity;
  final String impact;
  final String classification;
  final String created;
  final String createdworkforceby;
  final String createduserby;
  final String lastupdated;
  final String createdbyname;
  final String sitename;
  final String locationname;
  final String severityname;
  final String impactname;
  final String companyname;
  final String sessionid;
  final String categoryid;
  final String categoryname;
  final String statusText;
  final String nextStatus;
  final String canEdit;
  final String canResolve;
  final String? files;
  final String createdby;
  final List<Maplink> maplinks;
  final List<Commentslist> commentslist;
  final List<Customfield> customfields;
  final List<Log> logs;
  final String isNeedReInspection;
  final String isShowAdditionalInfo;
  final String refNo;

  QMDetailsData(
      {required this.logs,
      required this.id,
      required this.eventdatetime,
      required this.status,
      required this.description,
      required this.site,
      required this.location,
      required this.companyid,
      required this.severity,
      required this.impact,
      required this.classification,
      required this.created,
      required this.createdworkforceby,
      required this.createduserby,
      required this.lastupdated,
      required this.createdbyname,
      required this.sitename,
      required this.locationname,
      required this.severityname,
      required this.impactname,
      required this.companyname,
      required this.sessionid,
      required this.categoryid,
      required this.categoryname,
      required this.statusText,
      required this.nextStatus,
      required this.canEdit,
      required this.canResolve,
      required this.files,
      required this.createdby,
      required this.maplinks,
      required this.commentslist,
      required this.customfields,
      required this.isNeedReInspection,
      required this.isShowAdditionalInfo,
      required this.refNo});

  factory QMDetailsData.fromJson(Map<String, dynamic> json) => QMDetailsData(
      id: json["id"] ?? '',
      eventdatetime: json["eventdatetime"] ?? '',
      status: json["status"] ?? '',
      description: json["description"] ?? '',
      site: json["site"] ?? '',
      location: json["location"] ?? '',
      companyid: json["companyid"] ?? '',
      severity: json["severity"] ?? '',
      impact: json["impact"] ?? '',
      classification: json["classification"] ?? '',
      created: json["created"] ?? '',
      createdworkforceby: json["createdworkforceby"] ?? '',
      createduserby: json["createduserby"] ?? '',
      lastupdated: json["lastupdated"] ?? '',
      createdbyname: json["createdbyname"] ?? '',
      sitename: json["sitename"] ?? '',
      locationname: json["locationname"] ?? '',
      severityname: json["severityname"] ?? '',
      impactname: json["impactname"] ?? '',
      companyname: json["companyname"] ?? '',
      sessionid: json["sessionid"] ?? '',
      categoryid: json["categoryid"] ?? '',
      categoryname: json["categoryname"] ?? '',
      statusText: json["status_text"] ?? '',
      nextStatus: json["next_status"] ?? '',
      canEdit: json["can_edit"] ?? '',
      canResolve: json["can_resolve"] ?? '',
      files: json["files"] ?? '',
      createdby: json["createdby"] ?? '',
      maplinks: json["maplinks"] == null
          ? []
          : List<Maplink>.from(
              json["maplinks"].map((x) => Maplink.fromJson(x))),
      commentslist: json["maplinks"] == null
          ? []
          : List<Commentslist>.from(
              json["commentslist"].map((x) => Commentslist.fromJson(x))),
      customfields: json["maplinks"] == null
          ? []
          : List<Customfield>.from(
              json["customfields"].map((x) => Customfield.fromJson(x))),
      logs: json["logs"] == null
          ? []
          : List<Log>.from(json["logs"].map((x) => Log.fromJson(x))),
      isNeedReInspection: json['isneedreinspection'] ?? '0',
      isShowAdditionalInfo: json['isshowadditionalinfo'] ?? '0',
      refNo: json['refno'] ?? '');

  Map<String, dynamic> toJson() => {
        "id": id,
        "eventdatetime": eventdatetime,
        "status": status,
        "description": description,
        "site": site,
        "location": location,
        "companyid": companyid,
        "severity": severity,
        "impact": impact,
        "classification": classification,
        "created": created,
        "createdworkforceby": createdworkforceby,
        "createduserby": createduserby,
        "lastupdated": lastupdated,
        "createdbyname": createdbyname,
        "sitename": sitename,
        "locationname": locationname,
        "severityname": severityname,
        "impactname": impactname,
        "companyname": companyname,
        "sessionid": sessionid,
        "categoryid": categoryid,
        "categoryname": categoryname,
        "status_text": statusText,
        "next_status": nextStatus,
        "can_edit": canEdit,
        "can_resolve": canResolve,
        "files": files,
        "createdby": createdby,
        "maplinks": List<dynamic>.from(maplinks.map((x) => x.toJson())),
        "commentslist": List<dynamic>.from(commentslist.map((x) => x.toJson())),
        "customfields": List<dynamic>.from(customfields.map((x) => x.toJson())),
        "logs": List<dynamic>.from(logs.map((x) => x.toJson())),
        "isneedreinspection": isNeedReInspection,
        "isshowadditionalinfo": isShowAdditionalInfo,
        "refno": refNo
      };
}

class Commentslist {
  final String ownername;
  final dynamic rolenames;
  final String created;
  final dynamic files;
  final String comments;

  Commentslist({
    required this.ownername,
    this.rolenames,
    required this.created,
    this.files,
    required this.comments,
  });

  factory Commentslist.fromJson(Map<String, dynamic> json) => Commentslist(
        ownername: json["ownername"],
        rolenames: json["rolenames"],
        created: json["created"],
        files: json["files"],
        comments: json["comments"],
      );

  Map<String, dynamic> toJson() => {
        "ownername": ownername,
        "rolenames": rolenames,
        "created": created,
        "files": files,
        "comments": comments,
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

class Customfield {
  final String title;
  final String fieldvalue;
  final int fieldtype;
  final int fieldid;
  final String optionid;

  Customfield({
    required this.title,
    required this.fieldvalue,
    required this.fieldtype,
    required this.fieldid,
    required this.optionid,
  });

  factory Customfield.fromJson(Map<String, dynamic> json) => Customfield(
        title: json["title"] ?? '',
        fieldvalue: json["fieldvalue"] ?? '',
        fieldtype: json["fieldtype"] ?? '',
        fieldid: json["fieldid"] ?? '',
        optionid: json["optionid"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "fieldvalue": fieldvalue,
        "fieldtype": fieldtype,
        "fieldid": fieldid,
        "optionid": optionid,
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
