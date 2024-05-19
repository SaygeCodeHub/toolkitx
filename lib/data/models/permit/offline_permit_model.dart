import 'dart:convert';

class OfflinePermitModel {
  final int status;
  final String message;
  final List<OfflinePermitDatum> data;

  OfflinePermitModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory OfflinePermitModel.fromRawJson(String str) =>
      OfflinePermitModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OfflinePermitModel.fromJson(Map<String, dynamic> json) =>
      OfflinePermitModel(
        status: json["Status"] ?? 0,
        message: json["Message"] ?? '',
        data: (json["Data"] != null)
            ? List<OfflinePermitDatum>.from(
                json["Data"].map((x) => OfflinePermitDatum.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class OfflinePermitDatum {
  final String id;
  final int id2;
  final Listpage listpage;
  final Tab1 tab1;
  final Tab2 tab2;
  final List<Tab3> tab3;
  final List<dynamic> tab4;
  final List<Tab5> tab5;
  final List<dynamic> tab6;
  final Map<String, String> html;

  OfflinePermitDatum({
    required this.id,
    required this.id2,
    required this.listpage,
    required this.tab1,
    required this.tab2,
    required this.tab3,
    required this.tab4,
    required this.tab5,
    required this.tab6,
    required this.html,
  });

  factory OfflinePermitDatum.fromRawJson(String str) =>
      OfflinePermitDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OfflinePermitDatum.fromJson(Map<String, dynamic> json) =>
      OfflinePermitDatum(
        id: json["id"] ?? '',
        id2: json["id2"] != null ? int.parse(json["id2"].toString()) : 0,
        // Parse as int
        listpage: json["listpage"] != null
            ? Listpage.fromJson(json["listpage"])
            : Listpage(),
        tab1: json["tab1"] != null ? Tab1.fromJson(json["tab1"]) : Tab1(),
        tab2: json["tab2"] != null ? Tab2.fromJson(json["tab2"]) : Tab2(),
        tab3: (json["tab3"] != null)
            ? List<Tab3>.from(json["tab3"].map((x) => Tab3.fromJson(x)))
            : [],
        tab4: (json["tab4"] != null) ? List<dynamic>.from(json["tab4"]) : [],
        tab5: (json["tab5"] != null)
            ? List<Tab5>.from(json["tab5"].map((x) => Tab5.fromJson(x)))
            : [],
        tab6: (json["tab6"] != null) ? List<dynamic>.from(json["tab6"]) : [],
        html: (json["html"] != null)
            ? Map.from(json["html"])
                .map((k, v) => MapEntry<String, String>(k, v.toString()))
            : {},
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id2": id2,
        "listpage": listpage.toJson(),
        "tab1": tab1.toJson(),
        "tab2": tab2.toJson(),
        "tab3": List<dynamic>.from(tab3.map((x) => x.toJson())),
        "tab4": List<dynamic>.from(tab4.map((x) => x)),
        "tab5": List<dynamic>.from(tab5.map((x) => x.toJson())),
        "tab6": List<dynamic>.from(tab6.map((x) => x)),
        "html": Map.from(html).map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}

class Listpage {
  final String id;
  final int id2;
  final String permit;
  final int typeOfPermit;
  final String schedule;
  final String location;
  final String description;
  final int statusid;
  final String status;
  final String expired;
  final String pname;
  final String pcompany;
  final int emergency;
  final dynamic npiStatus;
  final dynamic npwStatus;
  final String startdate;
  final String enddate;

  Listpage({
    this.id = '',
    this.id2 = 0,
    this.permit = '',
    this.typeOfPermit = 0,
    this.schedule = '',
    this.location = '',
    this.description = '',
    this.statusid = 0,
    this.status = '',
    this.expired = '',
    this.pname = '',
    this.pcompany = '',
    this.emergency = 0,
    this.npiStatus,
    this.npwStatus,
    this.startdate = '',
    this.enddate = '',
  });

  factory Listpage.fromRawJson(String str) =>
      Listpage.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Listpage.fromJson(Map<String, dynamic> json) => Listpage(
        id: json["id"] ?? '',
        id2: json["id2"] ?? 0,
        permit: json["permit"] ?? '',
        typeOfPermit: json["type_of_permit"] ?? 0,
        schedule: json["schedule"] ?? '',
        location: json["location"] ?? '',
        description: json["description"] ?? '',
        statusid: json["statusid"] ?? 0,
        status: json["status"] ?? '',
        expired: json["expired"] ?? '',
        pname: json["pname"] ?? '',
        pcompany: json["pcompany"] ?? '',
        emergency: json["emergency"] ?? 0,
        npiStatus: json["npi_status"],
        npwStatus: json["npw_status"],
        startdate: json["startdate"] ?? '',
        enddate: json["enddate"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id2": id2,
        "permit": permit,
        "type_of_permit": typeOfPermit,
        "schedule": schedule,
        "location": location,
        "description": description,
        "statusid": statusid,
        "status": status,
        "expired": expired,
        "pname": pname,
        "pcompany": pcompany,
        "emergency": emergency,
        "npi_status": npiStatus,
        "npw_status": npwStatus,
        "startdate": startdate,
        "enddate": enddate,
      };
}

class Tab1 {
  final String id;
  final int typeOfPermit;
  final String permit;
  final String schedule;
  final String location;
  final String details;
  final String status;
  final String expired;
  final String pnameNpi;
  final String pname;
  final String pcompany;
  final int emergency;
  final String isopen;
  final String ishold;
  final String isclose;
  final String isnpiaccept;
  final String isnpwaccept;
  final String clientid;

  Tab1({
    this.id = '',
    this.typeOfPermit = 0,
    this.permit = '',
    this.schedule = '',
    this.location = '',
    this.details = '',
    this.status = '',
    this.expired = '',
    this.pnameNpi = '',
    this.pname = '',
    this.pcompany = '',
    this.emergency = 0,
    this.isopen = '',
    this.ishold = '',
    this.isclose = '',
    this.isnpiaccept = '',
    this.isnpwaccept = '',
    this.clientid = '',
  });

  factory Tab1.fromRawJson(String str) => Tab1.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Tab1.fromJson(Map<String, dynamic> json) => Tab1(
        id: json["id"] ?? '',
        typeOfPermit: json["type_of_permit"] ?? 0,
        permit: json["permit"] ?? '',
        schedule: json["schedule"] ?? '',
        location: json["location"] ?? '',
        details: json["details"] ?? '',
        status: json["status"] ?? '',
        expired: json["expired"] ?? '',
        pnameNpi: json["pname_npi"] ?? '',
        pname: json["pname"] ?? '',
        pcompany: json["pcompany"] ?? '',
        emergency: json["emergency"] ?? 0,
        isopen: json["isopen"] ?? '',
        ishold: json["ishold"] ?? '',
        isclose: json["isclose"] ?? '',
        isnpiaccept: json["isnpiaccept"] ?? '',
        isnpwaccept: json["isnpwaccept"] ?? '',
        clientid: json["clientid"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type_of_permit": typeOfPermit,
        "permit": permit,
        "schedule": schedule,
        "location": location,
        "details": details,
        "status": status,
        "expired": expired,
        "pname_npi": pnameNpi,
        "pname": pname,
        "pcompany": pcompany,
        "emergency": emergency,
        "isopen": isopen,
        "ishold": ishold,
        "isclose": isclose,
        "isnpiaccept": isnpiaccept,
        "isnpwaccept": isnpwaccept,
        "clientid": clientid,
      };
}

class Tab2 {
  final int id;
  final int typeOfPermit;
  final int permitNo;
  final dynamic safetyisolation;
  final dynamic safetyisolationinfo;
  final String protectivemeasures;
  final String generalMessage;
  final String methodStatement;
  final String specialWork;
  final String specialppe;
  final String layout;
  final String layoutFile;
  final dynamic layoutLink;
  final List<Customfield> customfields;

  Tab2({
    this.id = 0,
    this.typeOfPermit = 0,
    this.permitNo = 0,
    this.safetyisolation,
    this.safetyisolationinfo,
    this.protectivemeasures = '',
    this.generalMessage = '',
    this.methodStatement = '',
    this.specialWork = '',
    this.specialppe = '',
    this.layout = '',
    this.layoutFile = '',
    this.layoutLink,
    this.customfields = const [],
  });

  factory Tab2.fromRawJson(String str) => Tab2.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Tab2.fromJson(Map<String, dynamic> json) => Tab2(
        id: json["id"] ?? 0,
        typeOfPermit: json["type_of_permit"] ?? 0,
        permitNo: json["permit_no"] ?? 0,
        safetyisolation: json["safetyisolation"],
        safetyisolationinfo: json["safetyisolationinfo"],
        protectivemeasures: json["protectivemeasures"] ?? '',
        generalMessage: json["general_message"] ?? '',
        methodStatement: json["method_statement"] ?? '',
        specialWork: json["special_work"] ?? '',
        specialppe: json["specialppe"] ?? '',
        layout: json["layout"] ?? '',
        layoutFile: json["layout_file"] ?? '',
        layoutLink: json["layout_link"],
        customfields: (json["customfields"] != null)
            ? List<Customfield>.from(
                json["customfields"].map((x) => Customfield.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type_of_permit": typeOfPermit,
        "permit_no": permitNo,
        "safetyisolation": safetyisolation,
        "safetyisolationinfo": safetyisolationinfo,
        "protectivemeasures": protectivemeasures,
        "general_message": generalMessage,
        "method_statement": methodStatement,
        "special_work": specialWork,
        "specialppe": specialppe,
        "layout": layout,
        "layout_file": layoutFile,
        "layout_link": layoutLink,
        "customfields": List<dynamic>.from(customfields.map((x) => x.toJson())),
      };
}

class Customfield {
  final String title;
  final String fieldvalue;

  Customfield({
    this.title = '',
    this.fieldvalue = '',
  });

  factory Customfield.fromRawJson(String str) =>
      Customfield.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Customfield.fromJson(Map<String, dynamic> json) => Customfield(
        title: json["title"] ?? '',
        fieldvalue: json["fieldvalue"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "fieldvalue": fieldvalue,
      };
}

class Tab3 {
  final String id;
  final String name;
  final String jobTitle;
  final String company;
  final String certificatecode;
  final String npiId;
  final String npwId;

  Tab3({
    this.id = '',
    this.name = '',
    this.jobTitle = '',
    this.company = '',
    this.certificatecode = '',
    this.npiId = '',
    this.npwId = '',
  });

  factory Tab3.fromRawJson(String str) => Tab3.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Tab3.fromJson(Map<String, dynamic> json) => Tab3(
        id: json["id"] ?? '',
        name: json["name"] ?? '',
        jobTitle: json["job_title"] ?? '',
        company: json["company"] ?? '',
        certificatecode: json["certificatecode"] ?? '',
        npiId: json["npi_id"] ?? '',
        npwId: json["npw_id"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "job_title": jobTitle,
        "company": company,
        "certificatecode": certificatecode,
        "npi_id": npiId,
        "npw_id": npwId,
      };
}

class Tab5 {
  final int id;
  final String name;
  final String type;
  final String files;

  Tab5({
    this.id = 0,
    this.name = '',
    this.type = '',
    this.files = '',
  });

  factory Tab5.fromRawJson(String str) => Tab5.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Tab5.fromJson(Map<String, dynamic> json) => Tab5(
        id: json["id"] ?? 0,
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
