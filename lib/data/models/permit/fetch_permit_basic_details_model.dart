import 'dart:convert';

FetchPermitBasicDetailsModel fetchPermitBasicDetailsModelFromJson(String str) =>
    FetchPermitBasicDetailsModel.fromJson(json.decode(str));

String fetchPermitBasicDetailsModelToJson(FetchPermitBasicDetailsModel data) =>
    json.encode(data.toJson());

class FetchPermitBasicDetailsModel {
  final int? status;
  final String? message;
  final PermitBasicData? data;

  FetchPermitBasicDetailsModel({
    this.status,
    this.message,
    this.data,
  });

  factory FetchPermitBasicDetailsModel.fromJson(Map<String, dynamic> json) =>
      FetchPermitBasicDetailsModel(
        status: json["Status"],
        message: json["Message"],
        data: json["Data"] == null
            ? null
            : PermitBasicData.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": data?.toJson(),
      };
}

class PermitBasicData {
  final String? id;
  final String? permit;
  final int? typeOfPermit;
  final String? schedule;
  final String? location;
  final String? details;
  final String? status;
  final String? expired;
  final String? pnameNpi;
  final String? pname;
  final String? pcompany;
  final int? emergency;
  final String? isrequest;
  final String? isprint;
  final String? isopen;
  final String? ishold;
  final String? isclose;
  final dynamic isnpiaccept;
  final dynamic isnpwaccept;
  final String? isacceptissue;
  final dynamic issurrendercp;
  final dynamic isrequestpermitclosure;
  final String? isclearpermit;
  final String? ischangecp;
  final String? istransfersafetydocument;
  final String? iseditsafetydocument;
  final String? isprepared;
  final dynamic requestChecklistWarning;
  final dynamic closedoutChecklistWarning;
  final String? issubmitrequestchecklist;
  final String? issubmitclosedoutchecklist;
  final List<Maplink>? maplinks;

  PermitBasicData({
    this.id,
    this.permit,
    this.typeOfPermit,
    this.schedule,
    this.location,
    this.details,
    this.status,
    this.expired,
    this.pnameNpi,
    this.pname,
    this.pcompany,
    this.emergency,
    this.isrequest,
    this.isprint,
    this.isopen,
    this.ishold,
    this.isclose,
    this.isnpiaccept,
    this.isnpwaccept,
    this.isacceptissue,
    this.issurrendercp,
    this.isrequestpermitclosure,
    this.isclearpermit,
    this.ischangecp,
    this.istransfersafetydocument,
    this.iseditsafetydocument,
    this.isprepared,
    this.requestChecklistWarning,
    this.closedoutChecklistWarning,
    this.issubmitrequestchecklist,
    this.issubmitclosedoutchecklist,
    this.maplinks,
  });

  factory PermitBasicData.fromJson(Map<String, dynamic> json) =>
      PermitBasicData(
        id: json["id"],
        permit: json["permit"],
        typeOfPermit: json["type_of_permit"],
        schedule: json["schedule"],
        location: json["location"],
        details: json["details"],
        status: json["status"],
        expired: json["expired"],
        pnameNpi: json["pname_npi"],
        pname: json["pname"],
        pcompany: json["pcompany"],
        emergency: json["emergency"],
        isrequest: json["isrequest"],
        isprint: json["isprint"],
        isopen: json["isopen"],
        ishold: json["ishold"],
        isclose: json["isclose"],
        isnpiaccept: json["isnpiaccept"],
        isnpwaccept: json["isnpwaccept"],
        isacceptissue: json["isacceptissue"],
        issurrendercp: json["issurrendercp"],
        isrequestpermitclosure: json["isrequestpermitclosure"],
        isclearpermit: json["isclearpermit"],
        ischangecp: json["ischangecp"],
        istransfersafetydocument: json["istransfersafetydocument"],
        iseditsafetydocument: json["iseditsafetydocument"],
        isprepared: json["isprepared"],
        requestChecklistWarning: json["request_checklist_warning"],
        closedoutChecklistWarning: json["closedout_checklist_warning"],
        issubmitrequestchecklist: json["issubmitrequestchecklist"],
        issubmitclosedoutchecklist: json["issubmitclosedoutchecklist"],
        maplinks: json["maplinks"] == null
            ? []
            : List<Maplink>.from(
                json["maplinks"]!.map((x) => Maplink.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "permit": permit,
        "type_of_permit": typeOfPermit,
        "schedule": schedule,
        "location": location,
        "details": details,
        "status": status,
        "expired": expired,
        "pname_npi": pnameNpi,
        "pname": pname,
        "pcompany": pcompany,
        "emergency": emergency,
        "isrequest": isrequest,
        "isprint": isprint,
        "isopen": isopen,
        "ishold": ishold,
        "isclose": isclose,
        "isnpiaccept": isnpiaccept,
        "isnpwaccept": isnpwaccept,
        "isacceptissue": isacceptissue,
        "issurrendercp": issurrendercp,
        "isrequestpermitclosure": isrequestpermitclosure,
        "isclearpermit": isclearpermit,
        "ischangecp": ischangecp,
        "istransfersafetydocument": istransfersafetydocument,
        "iseditsafetydocument": iseditsafetydocument,
        "isprepared": isprepared,
        "request_checklist_warning": requestChecklistWarning,
        "closedout_checklist_warning": closedoutChecklistWarning,
        "issubmitrequestchecklist": issubmitrequestchecklist,
        "issubmitclosedoutchecklist": issubmitclosedoutchecklist,
        "maplinks": maplinks == null
            ? []
            : List<dynamic>.from(maplinks!.map((x) => x.toJson())),
      };
}

class Maplink {
  final String? location;
  final String? name;
  final String? link;

  Maplink({
    this.location,
    this.name,
    this.link,
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
