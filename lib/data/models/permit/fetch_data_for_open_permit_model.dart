import 'dart:convert';

FetchDataForOpenPermitModel fetchDataForOpenPermitModelFromJson(String str) =>
    FetchDataForOpenPermitModel.fromJson(json.decode(str));

String fetchDataForOpenPermitModelToJson(FetchDataForOpenPermitModel data) =>
    json.encode(data.toJson());

class FetchDataForOpenPermitModel {
  final int? status;
  final String? message;
  final FetchDataForOpenPermitData? data;

  FetchDataForOpenPermitModel({
    this.status,
    this.message,
    this.data,
  });

  factory FetchDataForOpenPermitModel.fromJson(Map<String, dynamic> json) =>
      FetchDataForOpenPermitModel(
        status: json["Status"],
        message: json["Message"],
        data: json["Data"] == null
            ? null
            : FetchDataForOpenPermitData.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": data?.toJson(),
      };
}

class FetchDataForOpenPermitData {
  final String? clientid;
  final String? permitName;
  final String? permitStatus;
  final String? typeOfPermit;
  final String? description;
  final String? methodstatement;
  final String? location;
  final String? npiVisible;
  final String? npwVisible;
  final String? openPanel;
  final String? panelSaint;
  final String? preparedPanel;
  final String? panelUpdatesd;
  final String? panel12;
  final String? panel15;
  final String? panel16;
  final String? panelSaint1215;
  final String? lwcAccessto;
  final String? lwcPlant;
  final String? lwcEnvironment;
  final String? lwcPrecautions;
  final String? ptwIsolation;
  final String? ptwCircuit;
  final String? ptwCircuit2;
  final String? ptwPrecautions;
  final String? ptwPrecautions2;
  final String? ptwSafety;
  final String? stIsolation;
  final String? stCircuit;
  final String? stPrecautions;
  final String? stSafety;
  final String? lvJustification;
  final String? lvPointofhazard;
  final String? mechanicalWork;
  final String? ertl;
  final String? flightOperations;
  final String? craneWork;
  final String? npiId;
  final String? npwId;
  final String? npiName;
  final String? npwName;
  final String? npiEmail;
  final String? npwEmail;
  final String? npiPhone;
  final String? npwPhone;

  FetchDataForOpenPermitData({
    this.clientid,
    this.permitName,
    this.permitStatus,
    this.typeOfPermit,
    this.description,
    this.methodstatement,
    this.location,
    this.npiVisible,
    this.npwVisible,
    this.openPanel,
    this.panelSaint,
    this.preparedPanel,
    this.panelUpdatesd,
    this.panel12,
    this.panel15,
    this.panel16,
    this.panelSaint1215,
    this.lwcAccessto,
    this.lwcPlant,
    this.lwcEnvironment,
    this.lwcPrecautions,
    this.ptwIsolation,
    this.ptwCircuit,
    this.ptwCircuit2,
    this.ptwPrecautions,
    this.ptwPrecautions2,
    this.ptwSafety,
    this.stIsolation,
    this.stCircuit,
    this.stPrecautions,
    this.stSafety,
    this.lvJustification,
    this.lvPointofhazard,
    this.mechanicalWork,
    this.ertl,
    this.flightOperations,
    this.craneWork,
    this.npiId,
    this.npwId,
    this.npiName,
    this.npwName,
    this.npiEmail,
    this.npwEmail,
    this.npiPhone,
    this.npwPhone,
  });

  factory FetchDataForOpenPermitData.fromJson(Map<String, dynamic> json) =>
      FetchDataForOpenPermitData(
          clientid: json["clientid"],
          permitName: json["permit_name"],
          permitStatus: json["permit_status"],
          typeOfPermit: json["type_of_permit"],
          description: json["description"],
          methodstatement: json["methodstatement"],
          location: json["location"],
          npiVisible: json["npi_visible"],
          npwVisible: json["npw_visible"],
          openPanel: json["open_panel"],
          panelSaint: json["panel_saint"],
          preparedPanel: json["prepared_panel"],
          panelUpdatesd: json["panel_updatesd"],
          panel12: json["panel_12"],
          panel15: json["panel_15"],
          panel16: json["panel_16"],
          panelSaint1215: json["panel_saint1215"],
          lwcAccessto: json["lwc_accessto"],
          lwcPlant: json["lwc_plant"],
          lwcEnvironment: json["lwc_environment"],
          lwcPrecautions: json["lwc_precautions"],
          ptwIsolation: json["ptw_isolation"],
          ptwCircuit: json["ptw_circuit"],
          ptwCircuit2: json["ptw_circuit2"],
          ptwPrecautions: json["ptw_precautions"],
          ptwPrecautions2: json["ptw_precautions2"],
          ptwSafety: json["ptw_safety"],
          stIsolation: json["st_isolation"],
          stCircuit: json["st_circuit"],
          stPrecautions: json["st_precautions"],
          stSafety: json["st_safety"],
          lvJustification: json["lv_justification"],
          lvPointofhazard: json["lv_pointofhazard"],
          mechanicalWork: json["mechanical_work"],
          ertl: json["ertl"],
          flightOperations: json["flight_operations"],
          craneWork: json["crane_work"],
          npiId: json["npi_id"],
          npwId: json["npw_id"],
          npiName: json["npi_name"],
          npwName: json["npw_name"],
          npiEmail: json["npi_email"],
          npwEmail: json["npw_email"],
          npiPhone: json["npi_phone"],
          npwPhone: json["npw_phone"]);

  Map<String, dynamic> toJson() => {
        "clientid": clientid,
        "permit_name": permitName,
        "permit_status": permitStatus,
        "type_of_permit": typeOfPermit,
        "description": description,
        "methodstatement": methodstatement,
        "location": location,
        "npi_visible": npiVisible,
        "npw_visible": npwVisible,
        "open_panel": openPanel,
        "panel_saint": panelSaint,
        "prepared_panel": preparedPanel,
        "panel_updatesd": panelUpdatesd,
        "panel_12": panel12,
        "panel_15": panel15,
        "panel_16": panel16,
        "panel_saint1215": panelSaint1215,
        "lwc_accessto": lwcAccessto,
        "lwc_plant": lwcPlant,
        "lwc_environment": lwcEnvironment,
        "lwc_precautions": lwcPrecautions,
        "ptw_isolation": ptwIsolation,
        "ptw_circuit": ptwCircuit,
        "ptw_circuit2": ptwCircuit2,
        "ptw_precautions": ptwPrecautions,
        "ptw_precautions2": ptwPrecautions2,
        "ptw_safety": ptwSafety,
        "st_isolation": stIsolation,
        "st_circuit": stCircuit,
        "st_precautions": stPrecautions,
        "st_safety": stSafety,
        "lv_justification": lvJustification,
        "lv_pointofhazard": lvPointofhazard,
        "mechanical_work": mechanicalWork,
        "ertl": ertl,
        "flight_operations": flightOperations,
        "crane_work": craneWork,
        "npi_id": npiId,
        "npw_id": npwId,
        "npi_name": npiName,
        "npw_name": npwName,
        "npi_email": npiEmail,
        "npw_email": npwEmail,
        "npi_phone": npiPhone,
        "npw_phone": npwPhone
      };
}
