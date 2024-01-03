import 'dart:convert';

AllPermitModel allPermitModelFromJson(String str) =>
    AllPermitModel.fromJson(json.decode(str));

String allPermitModelToJson(AllPermitModel data) => json.encode(data.toJson());

class AllPermitModel {
  final int? status;
  final String? message;
  final List<AllPermitDatum> data;

  AllPermitModel({this.status, this.message, required this.data});

  factory AllPermitModel.fromJson(Map<String, dynamic> json) => AllPermitModel(
        status: json["Status"],
        message: json["Message"],
        data: json["Data"] == null
            ? []
            : List<AllPermitDatum>.from(
                json["Data"]!.map((x) => AllPermitDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": data.isEmpty
            ? []
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class AllPermitDatum {
  final String? id;
  final int? id2;
  final String? permit;
  final String? schedule;
  final String? location;
  final String? description;
  final String? status;
  final String? expired;
  final String? pname;
  final String? pcompany;
  final int? emergency;
  final dynamic npiStatus;
  final dynamic npwStatus;
  final String? startdate;
  final String? enddate;

  AllPermitDatum(
      {this.id,
      this.id2,
      this.permit,
      this.schedule,
      this.location,
      this.description,
      this.status,
      this.expired,
      this.pname,
      this.pcompany,
      this.emergency,
      this.npiStatus,
      this.npwStatus,
      this.startdate,
      this.enddate});

  factory AllPermitDatum.fromJson(Map<String, dynamic> json) => AllPermitDatum(
      id: json["id"],
      id2: json["id2"],
      permit: json["permit"],
      schedule: json["schedule"],
      location: json["location"],
      description: json["description"],
      status: json["status"],
      expired: json["expired"],
      pname: json["pname"],
      pcompany: json["pcompany"],
      emergency: json["emergency"],
      npiStatus: json["npi_status"],
      npwStatus: json["npw_status"],
      startdate: json["startdate"],
      enddate: json["enddate"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "id2": id2,
        "permit": permit,
        "schedule": schedule,
        "location": location,
        "description": description,
        "status": status,
        "expired": expired,
        "pname": pname,
        "pcompany": pcompany,
        "emergency": emergency,
        "npi_status": npiStatus,
        "npw_status": npwStatus,
        "startdate": startdate,
        "enddate": enddate
      };
}
