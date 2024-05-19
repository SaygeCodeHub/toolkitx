import 'dart:convert';

OpenPermitDetailsModel openPermitDetailsModelFromJson(String str) =>
    OpenPermitDetailsModel.fromJson(json.decode(str));

String openPermitDetailsModelToJson(OpenPermitDetailsModel data) =>
    json.encode(data.toJson());

class OpenPermitDetailsModel {
  final int status;
  final String message;
  final GetOpenPermitData data;

  OpenPermitDetailsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory OpenPermitDetailsModel.fromJson(Map<String, dynamic> json) =>
      OpenPermitDetailsModel(
        status: json["Status"],
        message: json["Message"],
        data: GetOpenPermitData.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": data.toJson(),
      };
}

class GetOpenPermitData {
  final String? permitName;
  final String? permitStatus;
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
  final String? npiId;
  final String? npwId;
  final String? npiName;
  final String? npwName;
  final String? npiEmail;
  final String? npwEmail;
  final String? npiPhone;
  final String? npwPhone;

  GetOpenPermitData(
      {this.permitName,
      this.permitStatus,
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
      this.npiId,
      this.npwId,
      this.npiName,
      this.npwName,
      this.npiEmail,
      this.npwEmail,
      this.npiPhone,
      this.npwPhone});

  factory GetOpenPermitData.fromJson(Map<String, dynamic> json) =>
      GetOpenPermitData(
          permitName: json["permit_name"],
          permitStatus: json["permit_status"],
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
          npiId: json["npi_id"],
          npwId: json["npw_id"],
          npiName: json["npi_name"],
          npwName: json["npw_name"],
          npiEmail: json["npi_email"],
          npwEmail: json["npw_email"],
          npiPhone: json["npi_phone"],
          npwPhone: json["npw_phone"]);

  Map<String, dynamic> toJson() => {
        "permit_name": permitName,
        "permit_status": permitStatus,
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
