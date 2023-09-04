import 'dart:convert';

FetchWorkOrderTabDetailsModel fetchWorkOrderDetailsModelFromJson(String str) =>
    FetchWorkOrderTabDetailsModel.fromJson(json.decode(str));

String fetchWorkOrderTabsDetailsModelToJson(
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
        isassignedwf: json["isassignedwf"],
        isstart: json["isstart"],
        ishold: json["ishold"],
        iscomplete: json["iscomplete"],
        isacceptreject: json["isacceptreject"],
        isstarttender: json["isstarttender"],
        isstoptender: json["isstoptender"],
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
      };
}

class Customfield {
  final String title;
  final dynamic fieldvalue;
  final int fieldtype;
  final int fieldid;
  final String optionid;

  Customfield({
    required this.title,
    this.fieldvalue,
    required this.fieldtype,
    required this.fieldid,
    required this.optionid,
  });

  factory Customfield.fromJson(Map<String, dynamic> json) => Customfield(
        title: json["title"],
        fieldvalue: json["fieldvalue"] ?? '',
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
