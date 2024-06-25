import 'dart:convert';

PermitGetMasterModel permitGetMasterModelFromJson(String str) =>
    PermitGetMasterModel.fromJson(json.decode(str));

String permitGetMasterModelToJson(PermitGetMasterModel data) =>
    json.encode(data.toJson());

class PermitGetMasterModel {
  final int status;
  final String message;
  final List<List<PermitMasterDatum>> data;

  PermitGetMasterModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory PermitGetMasterModel.fromJson(Map<String, dynamic> json) =>
      PermitGetMasterModel(
        status: json["Status"],
        message: json["Message"],
        data: List<List<PermitMasterDatum>>.from(json["Data"].map((x) =>
            List<PermitMasterDatum>.from(
                x.map((x) => PermitMasterDatum.fromJson(x))))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(
            data.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
      };
}

class PermitMasterDatum {
  final dynamic permittype;
  final String? permittypename;
  final int? id;
  final String? location;
  final int? parentid;
  final String? name;
  final dynamic parentlocationname;
  final int? powerid;
  final int? type;

  PermitMasterDatum({
    this.permittype,
    required this.permittypename,
    required this.id,
    required this.location,
    required this.parentid,
    required this.name,
    this.parentlocationname,
    required this.powerid,
    required this.type,
  });

  factory PermitMasterDatum.fromJson(Map<String, dynamic> json) =>
      PermitMasterDatum(
        permittype: json["permittype"],
        permittypename: json["permittypename"],
        id: json["id"],
        location: json["location"],
        parentid: json["parentid"],
        name: json["name"],
        parentlocationname: json["parentlocationname"],
        powerid: json["powerid"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "permittype": permittype,
        "permittypename": permittypename,
        "id": id,
        "location": location,
        "parentid": parentid,
        "name": name,
        "parentlocationname": parentlocationname,
        "powerid": powerid,
        "type": type,
      };
}
