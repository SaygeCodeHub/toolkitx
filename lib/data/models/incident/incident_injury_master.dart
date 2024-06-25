import 'dart:convert';

IncidentInjuryMasterModel incidentInjuryMasterModelFromJson(String str) =>
    IncidentInjuryMasterModel.fromJson(json.decode(str));

String incidentInjuryMasterModelToJson(IncidentInjuryMasterModel data) =>
    json.encode(data.toJson());

class IncidentInjuryMasterModel {
  final int status;
  final String message;
  final List<List<IncidentInjuryMasterDatum>> data;

  IncidentInjuryMasterModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory IncidentInjuryMasterModel.fromJson(Map<String, dynamic> json) =>
      IncidentInjuryMasterModel(
        status: json["Status"],
        message: json["Message"],
        data: List<List<IncidentInjuryMasterDatum>>.from(json["Data"].map((x) =>
            List<IncidentInjuryMasterDatum>.from(
                x.map((x) => IncidentInjuryMasterDatum.fromJson(x))))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(
            data.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
      };
}

class IncidentInjuryMasterDatum {
  final int id;
  final String name;

  IncidentInjuryMasterDatum({
    required this.id,
    required this.name,
  });

  factory IncidentInjuryMasterDatum.fromJson(Map<String, dynamic> json) =>
      IncidentInjuryMasterDatum(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
