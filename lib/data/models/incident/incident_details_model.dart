import 'dart:convert';

IncidentDetailsModel incidentDetailsModelFromJson(String str) =>
    IncidentDetailsModel.fromJson(json.decode(str));

String incidentDetailsModelToJson(IncidentDetailsModel data) =>
    json.encode(data.toJson());

class IncidentDetailsModel {
  final int? status;
  final String? message;
  final IncidentDetailsDatum? data;

  IncidentDetailsModel({
    this.status,
    this.message,
    this.data,
  });

  factory IncidentDetailsModel.fromJson(Map<String, dynamic> json) =>
      IncidentDetailsModel(
        status: json["Status"],
        message: json["Message"],
        data: IncidentDetailsDatum.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": data!.toJson(),
      };
}

class IncidentDetailsDatum {
  final String id;
  final String eventdatetime;
  final String status;
  final String description;
  final String? site;
  final String? location;
  final String? companyid;
  final String responsiblePerson;
  final String reporteddatetime;
  final String? category;
  final String? classification;
  final String? created;
  final String? createdworkforceby;
  final String? createduserby;
  final String? lastupdated;
  final String createdbyname;
  final String sitename;
  final String locationname;
  final String companyname;
  final String categorynames;
  final String? injuredpeoplecount;
  final String? emailist;
  final String statusText;
  final String? nextStatus;
  final String? canEdit;
  final String? canResolve;
  final String files;
  final String? createdby;
  final List<Maplink>? maplinks;
  final List<Commentslist>? commentslist;
  final List<Injuredpersonlist>? injuredpersonlist;
  final List<Customfield>? customfields;
  final List<Linkedpermit>? linkedpermits;
  final List<Log>? logs;
  final String assetid;
  final String assetname;
  final String isShowAdditionalInfo;

  IncidentDetailsDatum(
      {required this.id,
      required this.eventdatetime,
      required this.status,
      required this.description,
      required this.site,
      this.location,
      this.companyid,
      required this.responsiblePerson,
      required this.reporteddatetime,
      this.category,
      this.classification,
      this.created,
      this.createdworkforceby,
      this.createduserby,
      this.lastupdated,
      required this.createdbyname,
      required this.sitename,
      required this.locationname,
      required this.companyname,
      required this.categorynames,
      this.injuredpeoplecount,
      this.emailist,
      required this.statusText,
      this.nextStatus,
      this.canEdit,
      this.canResolve,
      required this.files,
      this.createdby,
      this.maplinks,
      this.commentslist,
      this.injuredpersonlist,
      this.customfields,
      this.linkedpermits,
      this.logs,
      required this.assetid,
      required this.assetname,
      required this.isShowAdditionalInfo});

  factory IncidentDetailsDatum.fromJson(Map<String, dynamic> json) =>
      IncidentDetailsDatum(
          id: json["id"],
          eventdatetime: json["eventdatetime"],
          status: json["status"],
          description: json["description"],
          site: json["site"],
          location: json["location"],
          companyid: json["companyid"],
          responsiblePerson: json["responsible_person"],
          reporteddatetime: json["reporteddatetime"],
          category: json["category"],
          classification: json["classification"],
          created: json["created"],
          createdworkforceby: json["createdworkforceby"],
          createduserby: json["createduserby"],
          lastupdated: json["lastupdated"],
          createdbyname: json["createdbyname"],
          sitename: json["sitename"],
          locationname: json["locationname"],
          companyname: json["companyname"],
          categorynames: json["categorynames"],
          injuredpeoplecount: json["injuredpeoplecount"],
          emailist: json["emailist"],
          statusText: json["status_text"],
          nextStatus: json["next_status"],
          canEdit: json["can_edit"],
          canResolve: json["can_resolve"],
          files: json["files"],
          createdby: json["createdby"],
          maplinks: List<Maplink>.from(
              json["maplinks"].map((x) => Maplink.fromJson(x))),
          commentslist: List<Commentslist>.from(
              json["commentslist"].map((x) => Commentslist.fromJson(x))),
          injuredpersonlist:
              List<Injuredpersonlist>.from(json["injuredpersonlist"]
                  .map((x) => Injuredpersonlist.fromJson(x))),
          customfields: List<Customfield>.from(
              json["customfields"].map((x) => Customfield.fromJson(x))),
          linkedpermits: List<Linkedpermit>.from(
              json["linkedpermits"].map((x) => Linkedpermit.fromJson(x))),
          logs: List<Log>.from(json["logs"].map((x) => Log.fromJson(x))),
          assetid: json['assetid'] ?? '',
          assetname: json['assetname'] ?? '',
          isShowAdditionalInfo: json['isshowadditionalinfo'] ?? '0');

  Map<String, dynamic> toJson() => {
        "id": id,
        "eventdatetime": eventdatetime,
        "status": status,
        "description": description,
        "site": site,
        "location": location,
        "companyid": companyid,
        "responsible_person": responsiblePerson,
        "reporteddatetime": reporteddatetime,
        "category": category,
        "classification": classification,
        "created": created,
        "createdworkforceby": createdworkforceby,
        "createduserby": createduserby,
        "lastupdated": lastupdated,
        "createdbyname": createdbyname,
        "sitename": sitename,
        "locationname": locationname,
        "companyname": companyname,
        "categorynames": categorynames,
        "injuredpeoplecount": injuredpeoplecount,
        "emailist": emailist,
        "status_text": statusText,
        "next_status": nextStatus,
        "can_edit": canEdit,
        "can_resolve": canResolve,
        "files": files,
        "createdby": createdby,
        "maplinks": List<dynamic>.from(maplinks!.map((x) => x.toJson())),
        "commentslist":
            List<dynamic>.from(commentslist!.map((x) => x.toJson())),
        "injuredpersonlist":
            List<dynamic>.from(injuredpersonlist!.map((x) => x.toJson())),
        "customfields":
            List<dynamic>.from(customfields!.map((x) => x.toJson())),
        "linkedpermits":
            List<dynamic>.from(linkedpermits!.map((x) => x.toJson())),
        "logs": List<dynamic>.from(logs!.map((x) => x.toJson())),
        "assetid": assetid,
        "assetname": assetname,
        "isshowadditionalinfo": isShowAdditionalInfo
      };
}

class Commentslist {
  final String ownername;
  final dynamic rolenames;
  final String created;
  final String? files;
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

class Customfield {
  final String title;
  final String? fieldvalue;
  final int? fieldtype;
  final int fieldid;
  final String optionid;

  Customfield({
    required this.title,
    this.fieldvalue,
    this.fieldtype,
    required this.fieldid,
    required this.optionid,
  });

  factory Customfield.fromJson(Map<String, dynamic> json) => Customfield(
        title: json["title"],
        fieldvalue: json["fieldvalue"],
        fieldtype: json["fieldtype"],
        fieldid: json["fieldid"],
        optionid: json["optionid"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "fieldvalue": fieldvalue,
        "fieldtype": fieldtype,
        "fieldid": fieldid,
        "optionid": optionid,
      };
}

class Linkedpermit {
  final String id;
  final String processedPermitName;

  Linkedpermit({
    required this.id,
    required this.processedPermitName,
  });

  factory Linkedpermit.fromJson(Map<String, dynamic> json) => Linkedpermit(
        id: json["id"],
        processedPermitName: json["processed_permit_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "processed_permit_name": processedPermitName,
      };
}

class Injuredpersonlist {
  final String id;
  final String name;

  Injuredpersonlist({
    required this.id,
    required this.name,
  });

  factory Injuredpersonlist.fromJson(Map<String, dynamic> json) =>
      Injuredpersonlist(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
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
