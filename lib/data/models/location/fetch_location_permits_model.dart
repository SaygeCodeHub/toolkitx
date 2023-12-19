import 'dart:convert';

FetchLocationPermitsModel fetchLocationPermitsModelFromJson(String str) =>
    FetchLocationPermitsModel.fromJson(json.decode(str));

String fetchLocationPermitsModelToJson(FetchLocationPermitsModel data) =>
    json.encode(data.toJson());

class FetchLocationPermitsModel {
  final int status;
  final String message;
  final List<LocationPermitsDatum> data;

  FetchLocationPermitsModel(
      {required this.status, required this.message, required this.data});

  factory FetchLocationPermitsModel.fromJson(Map<String, dynamic> json) =>
      FetchLocationPermitsModel(
        status: json["Status"],
        message: json["Message"],
        data: List<LocationPermitsDatum>.from(
            json["Data"].map((x) => LocationPermitsDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class LocationPermitsDatum {
  final String id;
  final int id2;
  final String permit;
  final String schedule;
  final String location;
  final String description;
  final String status;
  final String expired;
  final String pname;
  final String pcompany;
  final int emergency;
  final int npiStatus;
  final int npwStatus;

  LocationPermitsDatum(
      {required this.id,
      required this.id2,
      required this.permit,
      required this.schedule,
      required this.location,
      required this.description,
      required this.status,
      required this.expired,
      required this.pname,
      required this.pcompany,
      required this.emergency,
      required this.npiStatus,
      required this.npwStatus});

  factory LocationPermitsDatum.fromJson(Map<String, dynamic> json) =>
      LocationPermitsDatum(
          id: json["id"] ?? '',
          id2: json["id2"] ?? '',
          permit: json["permit"] ?? '',
          schedule: json["schedule"] ?? '',
          location: json["location"] ?? '',
          description: json["description"] ?? '',
          status: json["status"] ?? '',
          expired: json["expired"] ?? '',
          pname: json["pname"] ?? '',
          pcompany: json["pcompany"] ?? '',
          emergency: json["emergency"] ?? '',
          npiStatus: json["npi_status"] ?? 0,
          npwStatus: json["npw_status"] ?? 0);

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
      };
}
