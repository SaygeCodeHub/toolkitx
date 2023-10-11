import 'dart:convert';

DocumentDetailsModel documentDetailsModelFromJson(String str) =>
    DocumentDetailsModel.fromJson(json.decode(str));

String documentDetailsModelToJson(DocumentDetailsModel data) =>
    json.encode(data.toJson());

class DocumentDetailsModel {
  final int status;
  final String message;
  final DocumentDetailsData data;

  DocumentDetailsModel(
      {required this.status, required this.message, required this.data});

  factory DocumentDetailsModel.fromJson(Map<String, dynamic> json) =>
      DocumentDetailsModel(
          status: json["Status"],
          message: json["Message"],
          data: DocumentDetailsData.fromJson(json["Data"]));

  Map<String, dynamic> toJson() =>
      {"Status": status, "Message": message, "Data": data.toJson()};
}

class DocumentDetailsData {
  final String name;
  final String docno;
  final String doctypeid;
  final String status;
  final String docname;
  final String notes;
  final String revision;
  final String userid;
  final String visiblecontractor;
  final String author;
  final String authorEmail;
  final String grantAccess;
  final String documentOpenType;
  final String distribution;
  final String rejectedcount;
  final String matrix;
  final String matrix2;
  final String matrix3;
  final String docsubtypeid;
  final String subtypename;
  final String areaid;
  final String areaname;
  final String distributionnames;
  final String isauthor;
  final String canopen;
  final String canedit;
  final String canaddmoredocs;
  final String canaddcomments;
  final String canclose;
  final String canapprove;
  final String canreject;
  final String canwithdraw;
  final String id;
  final String statustext;
  final String doctypename;
  final List<FileList> fileList;
  final List<ApproveList> approvelist;
  final List<CustomField> customfields;
  final List<Log> logs;
  final List<LinkedDoc> linkeddocs;

  DocumentDetailsData(
      {required this.name,
      required this.docno,
      required this.doctypeid,
      required this.status,
      required this.docname,
      required this.notes,
      required this.revision,
      required this.userid,
      required this.visiblecontractor,
      required this.author,
      required this.authorEmail,
      required this.grantAccess,
      required this.documentOpenType,
      required this.distribution,
      required this.rejectedcount,
      required this.matrix,
      required this.matrix2,
      required this.matrix3,
      required this.docsubtypeid,
      required this.subtypename,
      required this.areaid,
      required this.areaname,
      required this.distributionnames,
      required this.isauthor,
      required this.canopen,
      required this.canedit,
      required this.canaddmoredocs,
      required this.canaddcomments,
      required this.canclose,
      required this.canapprove,
      required this.canreject,
      required this.canwithdraw,
      required this.id,
      required this.statustext,
      required this.doctypename,
      required this.fileList,
      required this.approvelist,
      required this.customfields,
      required this.logs,
      required this.linkeddocs});

  factory DocumentDetailsData.fromJson(Map<String, dynamic> json) =>
      DocumentDetailsData(
          name: json["name"],
          docno: json["docno"],
          doctypeid: json["doctypeid"],
          status: json["status"],
          docname: json["docname"],
          notes: json["notes"],
          revision: json["revision"],
          userid: json["userid"],
          visiblecontractor: json["visiblecontractor"],
          author: json["author"],
          authorEmail: json["author_email"],
          grantAccess: json["grant_access"],
          documentOpenType: json["document_open_type"],
          distribution: json["distribution"],
          rejectedcount: json["rejectedcount"],
          matrix: json["matrix"],
          matrix2: json["matrix2"],
          matrix3: json["matrix3"],
          docsubtypeid: json["docsubtypeid"],
          subtypename: json["subtypename"],
          areaid: json["areaid"],
          areaname: json["areaname"],
          distributionnames: json["distributionnames"],
          isauthor: json["isauthor"],
          canopen: json["canopen"],
          canedit: json["canedit"],
          canaddmoredocs: json["canaddmoredocs"],
          canaddcomments: json["canaddcomments"],
          canclose: json["canclose"],
          canapprove: json["canapprove"],
          canreject: json["canreject"],
          canwithdraw: json["canwithdraw"],
          id: json["id"],
          statustext: json["statustext"],
          doctypename: json["doctypename"],
          fileList: List<FileList>.from(
              json["filelist"].map((x) => FileList.fromJson(x))),
          approvelist: List<ApproveList>.from(
              json["approvelist"].map((x) => ApproveList.fromJson(x))),
          customfields: List<CustomField>.from(
              json["customfields"].map((x) => CustomField.fromJson(x))),
          logs: List<Log>.from(json["logs"].map((x) => Log.fromJson(x))),
          linkeddocs: List<LinkedDoc>.from(
              json["linkeddocs"].map((x) => LinkedDoc.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "name": name,
        "docno": docno,
        "doctypeid": doctypeid,
        "status": status,
        "docname": docname,
        "notes": notes,
        "revision": revision,
        "userid": userid,
        "visiblecontractor": visiblecontractor,
        "author": author,
        "author_email": authorEmail,
        "grant_access": grantAccess,
        "document_open_type": documentOpenType,
        "distribution": distribution,
        "rejectedcount": rejectedcount,
        "matrix": matrix,
        "matrix2": matrix2,
        "matrix3": matrix3,
        "docsubtypeid": docsubtypeid,
        "subtypename": subtypename,
        "areaid": areaid,
        "areaname": areaname,
        "distributionnames": distributionnames,
        "isauthor": isauthor,
        "canopen": canopen,
        "canedit": canedit,
        "canaddmoredocs": canaddmoredocs,
        "canaddcomments": canaddcomments,
        "canclose": canclose,
        "canapprove": canapprove,
        "canreject": canreject,
        "canwithdraw": canwithdraw,
        "id": id,
        "statustext": statustext,
        "doctypename": doctypename,
        "filelist": List<dynamic>.from(fileList.map((x) => x.toJson())),
        "approvelist": List<dynamic>.from(approvelist.map((x) => x.toJson())),
        "customfields": List<dynamic>.from(customfields.map((x) => x.toJson())),
        "logs": List<dynamic>.from(logs.map((x) => x.toJson())),
        "linkeddocs": List<dynamic>.from(linkeddocs.map((x) => x.toJson()))
      };
}

class ApproveList {
  final int approve;
  final String remark;
  final String group;

  ApproveList(
      {required this.approve, required this.remark, required this.group});

  factory ApproveList.fromJson(Map<String, dynamic> json) => ApproveList(
      approve: json["approve"] ?? '',
      remark: json["remark"] ?? '',
      group: json["group"]);

  Map<String, dynamic> toJson() =>
      {"approve": approve, "remark": remark, "group": group};
}

class CustomField {
  final String title;
  final String fieldvalue;
  final int fieldtype;
  final int fieldid;
  final String optionid;

  CustomField(
      {required this.title,
      required this.fieldvalue,
      required this.fieldtype,
      required this.fieldid,
      required this.optionid});

  factory CustomField.fromJson(Map<String, dynamic> json) => CustomField(
      title: json["title"],
      fieldvalue: json["fieldvalue"] ?? '',
      fieldtype: json["fieldtype"],
      fieldid: json["fieldid"],
      optionid: json["optionid"]);

  Map<String, dynamic> toJson() => {
        "title": title,
        "fieldvalue": fieldvalue,
        "fieldtype": fieldtype,
        "fieldid": fieldid,
        "optionid": optionid
      };
}

class FileList {
  final String fileid;
  final String date;
  final String version;
  final String filename;
  final String notes;
  final String candelete;
  final String canuploadnewversion;
  final String canaddcomments;

  FileList(
      {required this.fileid,
      required this.date,
      required this.version,
      required this.filename,
      required this.notes,
      required this.candelete,
      required this.canuploadnewversion,
      required this.canaddcomments});

  factory FileList.fromJson(Map<String, dynamic> json) => FileList(
      fileid: json["fileid"],
      date: json["date"],
      version: json["version"],
      filename: json["filename"],
      notes: json["notes"],
      candelete: json["candelete"],
      canuploadnewversion: json["canuploadnewversion"],
      canaddcomments: json["canaddcomments"]);

  Map<String, dynamic> toJson() => {
        "fileid": fileid,
        "date": date,
        "version": version,
        "filename": filename,
        "notes": notes,
        "candelete": candelete,
        "canuploadnewversion": canuploadnewversion,
        "canaddcomments": canaddcomments
      };
}

class LinkedDoc {
  final String id;
  final String docno;
  final String name;
  final String doctype;
  final String status;

  LinkedDoc(
      {required this.id,
      required this.docno,
      required this.name,
      required this.doctype,
      required this.status});

  factory LinkedDoc.fromJson(Map<String, dynamic> json) => LinkedDoc(
      id: json["id"],
      docno: json["docno"],
      name: json["name"],
      doctype: json["doctype"],
      status: json["status"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "docno": docno,
        "name": name,
        "doctype": doctype,
        "status": status
      };
}

class Log {
  final String createdAt;
  final String action;
  final String createdBy;

  Log({required this.createdAt, required this.action, required this.createdBy});

  factory Log.fromJson(Map<String, dynamic> json) => Log(
      createdAt: json["created_at"],
      action: json["action"],
      createdBy: json["created_by"]);

  Map<String, dynamic> toJson() =>
      {"created_at": createdAt, "action": action, "created_by": createdBy};
}
