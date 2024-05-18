import 'dart:convert';

FetchClearPermitDetailsModel fetchClearPermitDetailsModelFromJson(String str) =>
    FetchClearPermitDetailsModel.fromJson(json.decode(str));

String fetchClearPermitDetailsModelToJson(FetchClearPermitDetailsModel data) =>
    json.encode(data.toJson());

class FetchClearPermitDetailsModel {
  final int status;
  final String message;
  final ClearPermitData data;

  FetchClearPermitDetailsModel(
      {required this.status, required this.message, required this.data});

  factory FetchClearPermitDetailsModel.fromJson(Map<String, dynamic> json) =>
      FetchClearPermitDetailsModel(
        status: json["Status"],
        message: json["Message"],
        data: ClearPermitData.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": data.toJson(),
      };
}

class ClearPermitData {
  final String clientid;
  final String permitName;
  final String permitStatus;
  final String typeOfPermit;
  final String panelSaint;
  final String panelSaint1215;
  final String isstopclear;
  final String keysafeno;
  final String earthscheduleno;
  final String selectedpersonreport;
  final String safetykeys;
  final String circuitflags;
  final String circuitwristlets;
  final String singleline;
  final String pid;
  final String accessKeys;
  final String other;
  final int statusid;

  ClearPermitData(
      {required this.clientid,
      required this.permitName,
      required this.permitStatus,
      required this.typeOfPermit,
      required this.panelSaint,
      required this.panelSaint1215,
      required this.isstopclear,
      required this.keysafeno,
      required this.earthscheduleno,
      required this.selectedpersonreport,
      required this.safetykeys,
      required this.circuitflags,
      required this.circuitwristlets,
      required this.singleline,
      required this.pid,
      required this.accessKeys,
      required this.other,
      required this.statusid});

  factory ClearPermitData.fromJson(Map<String, dynamic> json) =>
      ClearPermitData(
        clientid: json["clientid"] ?? '',
        permitName: json["permit_name"] ?? '',
        permitStatus: json["permit_status"] ?? '',
        typeOfPermit: json["type_of_permit"] ?? '',
        panelSaint: json["panel_saint"] ?? '',
        panelSaint1215: json["panel_saint1215"] ?? '',
        isstopclear: json["isstopclear"] ?? '',
        keysafeno: json["keysafeno"] ?? '',
        earthscheduleno: json["earthscheduleno"] ?? '',
        selectedpersonreport: json["selectedpersonreport"] ?? '',
        safetykeys: json["safetykeys"] ?? '',
        circuitflags: json["circuitflags"] ?? '',
        circuitwristlets: json["circuitwristlets"] ?? '',
        singleline: json["singleline"] ?? '',
        pid: json["pid"] ?? '',
        accessKeys: json["accesskey"] ?? '',
        other: json["other"] ?? '',
        statusid: json["statusid"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "clientid": clientid,
        "permit_name": permitName,
        "permit_status": permitStatus,
        "type_of_permit": typeOfPermit,
        "panel_saint": panelSaint,
        "panel_saint1215": panelSaint1215,
        "isstopclear": isstopclear,
        "keysafeno": keysafeno,
        "earthscheduleno": earthscheduleno,
        "selectedpersonreport": selectedpersonreport,
        "safetykeys": safetykeys,
        "circuitflags": circuitflags,
        "circuitwristlets": circuitwristlets,
        "singleline": singleline,
        "pid": pid,
        "accesskey": accessKeys,
        "other": other,
        "statusid": statusid
      };
}
