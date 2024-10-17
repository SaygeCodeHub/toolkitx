class FetchOfflineWorkOrderDataModel {
  final int status;
  final String message;
  final List<WorkOrderOfflineDatum> data;

  FetchOfflineWorkOrderDataModel(
      {required this.status, required this.message, required this.data});

  factory FetchOfflineWorkOrderDataModel.fromJson(Map<String, dynamic> json) =>
      FetchOfflineWorkOrderDataModel(
        status: json["Status"],
        message: json["Message"],
        data: List<WorkOrderOfflineDatum>.from(
            json["Data"].map((x) => WorkOrderOfflineDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson()))
      };
}

class WorkOrderOfflineDatum {
  final String id;
  final int id2;
  final Listpage listpage;
  final Wodetails wodetails;

  WorkOrderOfflineDatum(
      {required this.id,
      required this.id2,
      required this.listpage,
      required this.wodetails});

  factory WorkOrderOfflineDatum.fromJson(Map<String, dynamic> json) =>
      WorkOrderOfflineDatum(
          id: json["id"],
          id2: json["id2"],
          listpage: (json["listpage"] == null)
              ? Listpage.fromJson({})
              : Listpage.fromJson(json["listpage"]),
          wodetails: Wodetails.fromJson(json["wodetails"]));

  Map<String, dynamic> toJson() => {
        "id": id,
        "id2": id2,
        "listpage": listpage.toJson(),
        "wodetails": wodetails.toJson()
      };
}

class Listpage {
  final String id;
  final String woname;
  final String contractorname;
  final String type;
  final String status;
  final String schedule;
  final String subject;
  final int istender;
  final int statusid;

  Listpage(
      {required this.id,
      required this.woname,
      required this.contractorname,
      required this.type,
      required this.status,
      required this.schedule,
      required this.subject,
      required this.istender,
      required this.statusid});

  factory Listpage.fromJson(Map<String, dynamic> json) => Listpage(
      id: json["id"],
      woname: json["woname"] ?? '',
      contractorname: json["contractorname"] ?? '',
      type: json["type"] ?? '',
      status: json["status"] ?? '',
      schedule: json["schedule"] ?? '',
      subject: json["subject"] ?? '',
      istender: json["istender"] ?? 0,
      statusid: json['statusid'] ?? 0);

  Map<String, dynamic> toJson() => {
        "id": id,
        "woname": woname,
        "contractorname": contractorname,
        "type": type,
        "status": status,
        "schedule": schedule,
        "subject": subject,
        "istender": istender,
        "statusid": statusid
      };
}

class Wodetails {
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
  final String priorityname;
  final String matrix;
  final String matrix2;
  final String matrix3;
  final String closematrix;
  final String closematrix2;
  final String closematrix3;
  final String campaignid;
  final String progresspercentage;
  final String locationnames;
  final String safetymeasurenames;
  final String isstarttender;
  final String isstoptender;
  final String istenderacceptreject;
  final String isacceptreject;
  final String isassignedwf;
  final String isedit;
  final String isstart;
  final String iscomplete;
  final String isclose;
  final String workorder;
  final String status;
  final String plannedstartdate;
  final String plannedstarttime;
  final String plannedfinishdate;
  final String plannedfinishtime;
  final List<dynamic> maplinks;
  final List<Customfield> customfields;
  final List<dynamic> logs;
  final List<Comment> comments;
  final List<Workforce> workforce;
  final List<Item> items;
  final List<Downtime> downtime;
  final List<Document> documents;
  final List<Misccost> misccost;
  final String specialworknames;

  Wodetails({
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
    required this.priorityname,
    required this.matrix,
    required this.matrix2,
    required this.matrix3,
    required this.closematrix,
    required this.closematrix2,
    required this.closematrix3,
    required this.campaignid,
    required this.progresspercentage,
    required this.locationnames,
    required this.safetymeasurenames,
    required this.isstarttender,
    required this.isstoptender,
    required this.istenderacceptreject,
    required this.isacceptreject,
    required this.isassignedwf,
    required this.isedit,
    required this.isstart,
    required this.iscomplete,
    required this.isclose,
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
    required this.misccost,
    required this.specialworknames,
  });

  factory Wodetails.fromJson(Map<String, dynamic> json) => Wodetails(
      id: json["id"],
      pmid: json["pmid"] ?? '',
      locationid: json["locationid"] ?? '',
      otherlocation: json["otherlocation"] ?? '',
      subject: json["subject"] ?? '',
      priorityid: json["priorityid"] ?? '',
      categoryid: json["categoryid"] ?? '',
      statusid: json["statusid"] ?? '',
      specialtyid: json["specialtyid"] ?? '',
      parentwoid: json["parentwoid"] ?? '',
      originationid: json["originationid"] ?? '',
      contractid: json["contractid"] ?? '',
      businesslineid: json["businesslineid"] ?? '',
      costcenterid: json["costcenterid"] ?? '',
      changeid: json["changeid"] ?? '',
      accountid: json["accountid"] ?? '',
      companyid: json["companyid"] ?? '',
      projectid: json["projectid"] ?? '',
      plannedstartdatetime: json["plannedstartdatetime"] ?? '',
      plannedfinishdatetime: json["plannedfinishdatetime"] ?? '',
      description: json["description"] ?? '',
      type: json["type"] ?? '',
      otherlocationLatitude: json["otherlocation_latitude"] ?? '',
      otherlocationLongitude: json["otherlocation_longitude"] ?? '',
      cwoid: json["cwoid"] ?? '',
      created: json["created"] ?? '',
      createdby: json["createdby"] ?? '',
      updated: json["updated"] ?? '',
      updateby: json["updateby"] ?? '',
      pmplan: json["pmplan"] ?? '',
      category: json["category"] ?? '',
      workordertype: json["workordertype"] ?? '',
      projectname: json["projectname"] ?? '',
      account: json["account"] ?? '',
      contractorname: json["contractorname"] ?? '',
      costcenter: json["costcenter"] ?? '',
      contractname: json["contractname"] ?? '',
      businessline: json["businessline"] ?? '',
      origination: json["origination"] ?? '',
      worksteps: json["worksteps"] ?? '',
      safetymeasure: json["safetymeasure"] ?? '',
      specialwork: json["specialwork"] ?? '',
      istender: json["istender"] ?? '',
      priorityname: json["priorityname"] ?? '',
      matrix: json["matrix"] ?? '',
      matrix2: json["matrix2"] ?? '',
      matrix3: json["matrix3"] ?? '',
      closematrix: json["closematrix"] ?? '',
      closematrix2: json["closematrix2"] ?? '',
      closematrix3: json["closematrix3"] ?? '',
      campaignid: json["campaignid"] ?? '',
      progresspercentage: json["progresspercentage"] ?? '',
      locationnames: json["locationnames"] ?? '',
      safetymeasurenames: json["safetymeasurenames"] ?? '',
      isstarttender: json["isstarttender"] ?? '',
      isstoptender: json["isstoptender"] ?? '',
      istenderacceptreject: json["istenderacceptreject"] ?? '',
      isacceptreject: json["isacceptreject"] ?? '',
      isassignedwf: json["isassignedwf"] ?? '',
      isedit: json["isedit"] ?? '',
      isstart: json["isstart"] ?? '',
      iscomplete: json["iscomplete"] ?? '',
      isclose: json["isclose"] ?? '',
      workorder: json["workorder"] ?? '',
      status: json["status"] ?? '',
      plannedstartdate: json["plannedstartdate"] ?? '',
      plannedstarttime: json["plannedstarttime"] ?? '',
      plannedfinishdate: json["plannedfinishdate"] ?? '',
      plannedfinishtime: json["plannedfinishtime"] ?? '',
      maplinks: (json["maplinks"] == null)
          ? []
          : List<dynamic>.from(json["maplinks"].map((x) => x)),
      customfields: (json["customfields"] == null)
          ? []
          : List<Customfield>.from(
              json["customfields"].map((x) => Customfield.fromJson(x))),
      logs: (json["logs"] == null)
          ? []
          : List<dynamic>.from(json["logs"].map((x) => x)),
      comments: (json["comments"] == null)
          ? []
          : List<Comment>.from(
              json["comments"].map((x) => Comment.fromJson(x))),
      workforce: (json["workforce"] == null)
          ? []
          : List<Workforce>.from(
              json["workforce"].map((x) => Workforce.fromJson(x))),
      items: (json["items"] == null)
          ? []
          : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      downtime: (json["downtime"] == null)
          ? []
          : List<Downtime>.from(
              json["downtime"].map((x) => Downtime.fromJson(x))),
      documents: (json["documents"] == null)
          ? []
          : List<Document>.from(
              json["documents"].map((x) => Document.fromJson(x))),
      misccost: (json["misccost"] == null)
          ? []
          : List<Misccost>.from(json["misccost"].map((x) => Misccost.fromJson(x))),
      specialworknames: json["specialworknames"] ?? '');

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
        "priorityname": priorityname,
        "matrix": matrix,
        "matrix2": matrix2,
        "matrix3": matrix3,
        "closematrix": closematrix,
        "closematrix2": closematrix2,
        "closematrix3": closematrix3,
        "campaignid": campaignid,
        "progresspercentage": progresspercentage,
        "locationnames": locationnames,
        "safetymeasurenames": safetymeasurenames,
        "isstarttender": isstarttender,
        "isstoptender": isstoptender,
        "istenderacceptreject": istenderacceptreject,
        "isacceptreject": isacceptreject,
        "isassignedwf": isassignedwf,
        "isedit": isedit,
        "isstart": isstart,
        "iscomplete": iscomplete,
        "isclose": isclose,
        "workorder": workorder,
        "status": status,
        "plannedstartdate": plannedstartdate,
        "plannedstarttime": plannedstarttime,
        "plannedfinishdate": plannedfinishdate,
        "plannedfinishtime": plannedfinishtime,
        "maplinks": List<dynamic>.from(maplinks.map((x) => x)),
        "customfields": List<dynamic>.from(customfields.map((x) => x.toJson())),
        "logs": List<dynamic>.from(logs.map((x) => x)),
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
        "workforce": List<dynamic>.from(workforce.map((x) => x.toJson())),
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "downtime": List<dynamic>.from(downtime.map((x) => x.toJson())),
        "documents": List<dynamic>.from(documents.map((x) => x.toJson())),
        "misccost": List<dynamic>.from(misccost.map((x) => x.toJson())),
        "specialworknames": specialworknames,
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
      ownername: json["ownername"] ?? '',
      created: json["created"] ?? '',
      files: json["files"] ?? '',
      comments: json["comments"] ?? '');

  Map<String, dynamic> toJson() => {
        "ownername": ownername,
        "created": created,
        "files": files,
        "comments": comments,
      };
}

class Workforce {
  final String id;
  final String workforceid;
  final String workforceid2;
  final String name;
  final String jobTitle;
  final String certificatecode;
  final int plannedhrs;
  final int actualhrs;

  Workforce(
      {required this.id,
      required this.workforceid,
      required this.workforceid2,
      required this.name,
      required this.jobTitle,
      required this.certificatecode,
      required this.plannedhrs,
      required this.actualhrs});

  factory Workforce.fromJson(Map<String, dynamic> json) => Workforce(
      id: json["id"],
      workforceid: json["workforceid"] ?? '',
      workforceid2: json["workforceid2"] ?? '',
      name: json["name"] ?? '',
      jobTitle: json["job_title"] ?? '',
      certificatecode: json["certificatecode"] ?? '',
      plannedhrs: json["plannedhrs"] ?? 0,
      actualhrs: json["actualhrs"] ?? 0);

  Map<String, dynamic> toJson() => {
        "id": id,
        "workforceid": workforceid,
        "workforceid2": workforceid2,
        "name": name,
        "job_title": jobTitle,
        "certificatecode": certificatecode,
        "plannedhrs": plannedhrs,
        "actualhrs": actualhrs,
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
      fieldtype: json["fieldtype"] ?? 0,
      fieldid: json["fieldid"] ?? 0,
      optionid: json["optionid"] ?? '');

  Map<String, dynamic> toJson() => {
        "title": title,
        "fieldvalue": fieldvalue,
        "fieldtype": fieldtype,
        "fieldid": fieldid,
        "optionid": optionid
      };
}

class Document {
  final String id;
  final String name;
  final String type;
  final String files;

  Document(
      {required this.id,
      required this.name,
      required this.type,
      required this.files});

  factory Document.fromJson(Map<String, dynamic> json) => Document(
      id: json["id"] ?? '',
      name: json["name"] ?? '',
      type: json["type"] ?? '',
      files: json["files"] ?? '');

  Map<String, dynamic> toJson() =>
      {"id": id, "name": name, "type": type, "files": files};
}

class Downtime {
  final String id;
  final String start;
  final String end;

  Downtime({required this.id, required this.start, required this.end});

  factory Downtime.fromJson(Map<String, dynamic> json) => Downtime(
      id: json["id"] ?? '', start: json["start"] ?? '', end: json["end"] ?? '');

  Map<String, dynamic> toJson() => {"id": id, "start": start, "end": end};
}

class Item {
  final String id;
  final String itemid;
  final String item;
  final String type;
  final String code;
  final int plannedquan;
  final int actualquan;

  Item(
      {required this.id,
      required this.itemid,
      required this.item,
      required this.type,
      required this.code,
      required this.plannedquan,
      required this.actualquan});

  factory Item.fromJson(Map<String, dynamic> json) => Item(
      id: json["id"] ?? '',
      itemid: json["itemid"] ?? '',
      item: json["item"] ?? '',
      type: json["type"] ?? '',
      code: json["code"] ?? '',
      plannedquan: json["plannedquan"] ?? 0,
      actualquan: json["actualquan"] ?? 0);

  Map<String, dynamic> toJson() => {
        "id": id,
        "itemid": itemid,
        "item": item,
        "type": type,
        "code": code,
        "plannedquan": plannedquan,
        "actualquan": actualquan
      };
}

class Misccost {
  final String id;
  final String service;
  final String vendorname;
  final int quan;
  final String amount;

  Misccost(
      {required this.id,
      required this.service,
      required this.vendorname,
      required this.quan,
      required this.amount});

  factory Misccost.fromJson(Map<String, dynamic> json) => Misccost(
      id: json["id"] ?? '',
      service: json["service"] ?? '',
      vendorname: json["vendorname"] ?? '',
      quan: json["quan"] ?? 0,
      amount: json["amount"] ?? '');

  Map<String, dynamic> toJson() => {
        "id": id,
        "service": service,
        "vendorname": vendorname,
        "quan": quan,
        "amount": amount
      };
}
