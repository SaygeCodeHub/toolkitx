import 'dart:convert';

FetchWorkOrderTabDetailsModel fetchWorkOrderTabDetailsModelFromJson(
        String str) =>
    FetchWorkOrderTabDetailsModel.fromJson(json.decode(str));

String fetchWorkOrderTabDetailsModelToJson(
        FetchWorkOrderTabDetailsModel data) =>
    json.encode(data.toJson());

class FetchWorkOrderTabDetailsModel {
  final int status;
  final String message;
  final WorkOrderDetailsData data;

  FetchWorkOrderTabDetailsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchWorkOrderTabDetailsModel.fromJson(Map<String, dynamic> json) =>
      FetchWorkOrderTabDetailsModel(
        status: json["Status"],
        message: json["Message"],
        data: WorkOrderDetailsData.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": data.toJson(),
      };
}

class WorkOrderDetailsData {
  final String id;
  final String pmid;
  final String locationid;
  final String otherlocation;
  final String subject;
  final String priorityid;
  final String categoryid;
  final String statusid;
  final String specialtyid;
  final String parentwoid;
  final String originationid;
  final String contractid;
  final String businesslineid;
  final String costcenterid;
  final String changeid;
  final String accountid;
  final String companyid;
  final String projectid;
  final String plannedstartdatetime;
  final String plannedfinishdatetime;
  final String description;
  final String type;
  final String otherlocationLatitude;
  final String otherlocationLongitude;
  final String cwoid;
  final String created;
  final String createdby;
  final String updated;
  final String updateby;
  final String pmplan;
  final String category;
  final String workordertype;
  final String projectname;
  final String account;
  final String contractorname;
  final String costcenter;
  final String contractname;
  final String businessline;
  final String origination;
  final String worksteps;
  final String safetymeasure;
  final String specialwork;
  final String istender;
  final String locationnames;
  final String safetymeasurenames;
  final String specialworknames;
  final String isassignedwf;
  final String isstart;
  final String ishold;
  final String iscomplete;
  final String isacceptreject;
  final String isstarttender;
  final String isstoptender;
  final String istenderacceptreject;
  final String workorder;
  final String status;
  final String plannedstartdate;
  final String plannedstarttime;
  final String plannedfinishdate;
  final String plannedfinishtime;
  final List<Maplink> maplinks;
  final List<Customfield> customfields;
  final List<Log> logs;
  final List<Comment> comments;
  final List<Workforce> workforce;
  final List<Item> items;
  final List<Downtime> downtime;
  final List<Document> documents;
  final String service;
  final String vendorname;
  final int? quan;
  final String amount;
  final List<Misccost> misccost;

  WorkOrderDetailsData({
    required this.id,
    required this.pmid,
    required this.locationid,
    required this.otherlocation,
    required this.subject,
    required this.priorityid,
    required this.categoryid,
    required this.statusid,
    required this.specialtyid,
    required this.parentwoid,
    required this.originationid,
    required this.contractid,
    required this.businesslineid,
    required this.costcenterid,
    required this.changeid,
    required this.accountid,
    required this.companyid,
    required this.projectid,
    required this.plannedstartdatetime,
    required this.plannedfinishdatetime,
    required this.description,
    required this.type,
    required this.otherlocationLatitude,
    required this.otherlocationLongitude,
    required this.cwoid,
    required this.created,
    required this.createdby,
    required this.updated,
    required this.updateby,
    required this.pmplan,
    required this.category,
    required this.workordertype,
    required this.projectname,
    required this.account,
    required this.contractorname,
    required this.costcenter,
    required this.contractname,
    required this.businessline,
    required this.origination,
    required this.worksteps,
    required this.safetymeasure,
    required this.specialwork,
    required this.istender,
    required this.locationnames,
    required this.safetymeasurenames,
    required this.specialworknames,
    required this.isassignedwf,
    required this.isstart,
    required this.ishold,
    required this.iscomplete,
    required this.isacceptreject,
    required this.isstarttender,
    required this.isstoptender,
    required this.istenderacceptreject,
    required this.workorder,
    required this.status,
    required this.plannedstartdate,
    required this.plannedstarttime,
    required this.plannedfinishdate,
    required this.plannedfinishtime,
    required this.maplinks,
    required this.customfields,
    required this.logs,
    required this.comments,
    required this.workforce,
    required this.items,
    required this.downtime,
    required this.documents,
    required this.service,
    required this.vendorname,
    this.quan,
    required this.amount,
    required this.misccost,
  });

  factory WorkOrderDetailsData.fromJson(Map<String, dynamic> json) =>
      WorkOrderDetailsData(
        id: json["id"],
        pmid: json["pmid"],
        locationid: json["locationid"],
        otherlocation: json["otherlocation"],
        subject: json["subject"],
        priorityid: json["priorityid"],
        categoryid: json["categoryid"],
        statusid: json["statusid"],
        specialtyid: json["specialtyid"],
        parentwoid: json["parentwoid"],
        originationid: json["originationid"],
        contractid: json["contractid"],
        businesslineid: json["businesslineid"],
        costcenterid: json["costcenterid"],
        changeid: json["changeid"],
        accountid: json["accountid"],
        companyid: json["companyid"],
        projectid: json["projectid"],
        plannedstartdatetime: json["plannedstartdatetime"],
        plannedfinishdatetime: json["plannedfinishdatetime"],
        description: json["description"],
        type: json["type"],
        otherlocationLatitude: json["otherlocation_latitude"],
        otherlocationLongitude: json["otherlocation_longitude"],
        cwoid: json["cwoid"],
        created: json["created"],
        createdby: json["createdby"],
        updated: json["updated"],
        updateby: json["updateby"],
        pmplan: json["pmplan"],
        category: json["category"],
        workordertype: json["workordertype"],
        projectname: json["projectname"],
        account: json["account"],
        contractorname: json["contractorname"],
        costcenter: json["costcenter"],
        contractname: json["contractname"],
        businessline: json["businessline"],
        origination: json["origination"],
        worksteps: json["worksteps"],
        safetymeasure: json["safetymeasure"],
        specialwork: json["specialwork"],
        istender: json["istender"],
        locationnames: json["locationnames"],
        safetymeasurenames: json["safetymeasurenames"] ?? '',
        specialworknames: json["specialworknames"] ?? '',
        isassignedwf: json["isassignedwf"],
        isstart: json["isstart"],
        ishold: json["ishold"],
        iscomplete: json["iscomplete"],
        isacceptreject: json["isacceptreject"],
        isstarttender: json["isstarttender"] ?? '',
        isstoptender: json["isstoptender"] ?? '',
        istenderacceptreject: json["istenderacceptreject"],
        workorder: json["workorder"],
        status: json["status"],
        plannedstartdate: json["plannedstartdate"],
        plannedstarttime: json["plannedstarttime"],
        plannedfinishdate: json["plannedfinishdate"],
        plannedfinishtime: json["plannedfinishtime"],
        maplinks: List<Maplink>.from(
            json["maplinks"].map((x) => Maplink.fromJson(x))),
        customfields: List<Customfield>.from(
            json["customfields"].map((x) => Customfield.fromJson(x))),
        logs: List<Log>.from(json["logs"].map((x) => Log.fromJson(x))),
        comments: List<Comment>.from(
            json["comments"].map((x) => Comment.fromJson(x))),
        workforce: List<Workforce>.from(
            json["workforce"].map((x) => Workforce.fromJson(x))),
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        downtime: List<Downtime>.from(
            json["downtime"].map((x) => Downtime.fromJson(x))),
        documents: List<Document>.from(
            json["documents"].map((x) => Document.fromJson(x))),
        service: json["service"] ?? '',
        vendorname: json["vendorname"] ?? '',
        quan: json["quan"],
        amount: json["amount"] ?? '',
        misccost: List<Misccost>.from(
            json["misccost"].map((x) => Misccost.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "pmid": pmid,
        "locationid": locationid,
        "otherlocation": otherlocation,
        "subject": subject,
        "priorityid": priorityid,
        "categoryid": categoryid,
        "statusid": statusid,
        "specialtyid": specialtyid,
        "parentwoid": parentwoid,
        "originationid": originationid,
        "contractid": contractid,
        "businesslineid": businesslineid,
        "costcenterid": costcenterid,
        "changeid": changeid,
        "accountid": accountid,
        "companyid": companyid,
        "projectid": projectid,
        "plannedstartdatetime": plannedstartdatetime,
        "plannedfinishdatetime": plannedfinishdatetime,
        "description": description,
        "type": type,
        "otherlocation_latitude": otherlocationLatitude,
        "otherlocation_longitude": otherlocationLongitude,
        "cwoid": cwoid,
        "created": created,
        "createdby": createdby,
        "updated": updated,
        "updateby": updateby,
        "pmplan": pmplan,
        "category": category,
        "workordertype": workordertype,
        "projectname": projectname,
        "account": account,
        "contractorname": contractorname,
        "costcenter": costcenter,
        "contractname": contractname,
        "businessline": businessline,
        "origination": origination,
        "worksteps": worksteps,
        "safetymeasure": safetymeasure,
        "specialwork": specialwork,
        "istender": istender,
        "locationnames": locationnames,
        "safetymeasurenames": safetymeasurenames,
        "specialworknames": specialworknames,
        "isassignedwf": isassignedwf,
        "isstart": isstart,
        "ishold": ishold,
        "iscomplete": iscomplete,
        "isacceptreject": isacceptreject,
        "isstarttender": isstarttender,
        "isstoptender": isstoptender,
        "istenderacceptreject": istenderacceptreject,
        "workorder": workorder,
        "status": status,
        "plannedstartdate": plannedstartdate,
        "plannedstarttime": plannedstarttime,
        "plannedfinishdate": plannedfinishdate,
        "plannedfinishtime": plannedfinishtime,
        "maplinks": List<dynamic>.from(maplinks.map((x) => x.toJson())),
        "customfields": List<dynamic>.from(customfields.map((x) => x.toJson())),
        "logs": List<dynamic>.from(logs.map((x) => x.toJson())),
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
        "workforce": List<dynamic>.from(workforce.map((x) => x.toJson())),
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "downtime": List<dynamic>.from(downtime.map((x) => x.toJson())),
        "documents": List<dynamic>.from(documents.map((x) => x.toJson())),
        "service": service,
        "vendorname": vendorname,
        "quan": quan,
        "amount": amount,
        "misccost": List<dynamic>.from(misccost.map((x) => x.toJson())),
      };
}

class Comment {
  final String ownername;
  final String created;
  final String files;
  final String comments;

  Comment({
    required this.ownername,
    required this.created,
    required this.files,
    required this.comments,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        ownername: json["ownername"],
        created: json["created"],
        files: json["files"] ?? '',
        comments: json["comments"],
      );

  Map<String, dynamic> toJson() => {
        "ownername": ownername,
        "created": created,
        "files": files,
        "comments": comments,
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
        title: json["title"],
        fieldvalue: json["fieldvalue"] ?? '',
        fieldtype: json["fieldtype"],
        fieldid: json["fieldid"],
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

class Document {
  final String id;
  final String name;
  final String type;
  final String files;

  Document({
    required this.id,
    required this.name,
    required this.type,
    required this.files,
  });

  factory Document.fromJson(Map<String, dynamic> json) => Document(
        id: json["id"] ?? '',
        name: json["name"] ?? '',
        type: json["type"] ?? '',
        files: json["files"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "files": files,
      };
}

class Downtime {
  final String id;
  final String start;
  final String end;

  Downtime({
    required this.id,
    required this.start,
    required this.end,
  });

  factory Downtime.fromJson(Map<String, dynamic> json) => Downtime(
        id: json["id"] ?? '',
        start: json["start"] ?? '',
        end: json["end"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "start": start,
        "end": end,
      };
}

class Item {
  final String id;
  final String item;
  final String type;
  final String code;
  final int plannedquan;
  final int? actualquan;

  Item({
    required this.id,
    required this.item,
    required this.type,
    required this.code,
    required this.plannedquan,
    this.actualquan,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"] ?? '',
        item: json["item"] ?? '',
        type: json["type"] ?? '',
        code: json["code"] ?? '',
        plannedquan: json["plannedquan"],
        actualquan: json["actualquan"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "item": item,
        "type": type,
        "code": code,
        "plannedquan": plannedquan,
        "actualquan": actualquan,
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
        createdAt: json["created_at"] ?? '',
        action: json["action"] ?? '',
        createdBy: json["created_by"] ?? '',
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
        location: json["location"] ?? '',
        name: json["name"] ?? '',
        link: json["link"] ?? '',
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
  final String certificatecode;
  final int plannedhrs;
  final dynamic actualhrs;

  Workforce({
    required this.id,
    required this.workforceid,
    required this.name,
    required this.jobTitle,
    required this.certificatecode,
    required this.plannedhrs,
    this.actualhrs,
  });

  factory Workforce.fromJson(Map<String, dynamic> json) => Workforce(
        id: json["id"] ?? '',
        workforceid: json["workforceid"] ?? '',
        name: json["name"] ?? '',
        jobTitle: json["job_title"] ?? '',
        certificatecode: json["certificatecode"] ?? '',
        plannedhrs: json["plannedhrs"],
        actualhrs: json["actualhrs"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "workforceid": workforceid,
        "name": name,
        "job_title": jobTitle,
        "certificatecode": certificatecode,
        "plannedhrs": plannedhrs,
        "actualhrs": actualhrs,
      };
}

class Misccost {
  final String id;
  final String service;
  final String vendorname;
  final int quan;
  final String amount;

  Misccost({
    required this.id,
    required this.service,
    required this.vendorname,
    required this.quan,
    required this.amount,
  });

  factory Misccost.fromJson(Map<String, dynamic> json) => Misccost(
        id: json["id"] ?? '',
        service: json["service"] ?? '',
        vendorname: json["vendorname"] ?? '',
        quan: json["quan"],
        amount: json["amount"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "service": service,
        "vendorname": vendorname,
        "quan": quan,
        "amount": amount,
      };
}
