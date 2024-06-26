import 'dart:convert';

FetchSearchEquipmentModel fetchSearchEquipmentModelFromJson(String str) =>
    FetchSearchEquipmentModel.fromJson(json.decode(str));

String fetchSearchEquipmentModelToJson(FetchSearchEquipmentModel data) =>
    json.encode(data.toJson());

class FetchSearchEquipmentModel {
  final int status;
  final String message;
  final List<SearchEquipmentDatum> data;

  FetchSearchEquipmentModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchSearchEquipmentModel.fromJson(Map<String, dynamic> json) =>
      FetchSearchEquipmentModel(
        status: json["Status"],
        message: json["Message"],
        data: List<SearchEquipmentDatum>.from(
            json["Data"].map((x) => SearchEquipmentDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class SearchEquipmentDatum {
  final String id;
  final String equipmentcode;
  final String equipmentname;
  final String machinetype;
  final dynamic currentitemcount;

  SearchEquipmentDatum({
    required this.id,
    required this.equipmentcode,
    required this.equipmentname,
    required this.machinetype,
    required this.currentitemcount,
  });

  factory SearchEquipmentDatum.fromJson(Map<String, dynamic> json) =>
      SearchEquipmentDatum(
        id: json["id"],
        equipmentcode: json["equipmentcode"] ?? '',
        equipmentname: json["equipmentname"] ?? '',
        machinetype: json["machinetype"] ?? '',
        currentitemcount: json["currentitemcount"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "equipmentcode": equipmentcode,
        "equipmentname": equipmentname,
        "machinetype": machinetype,
        "currentitemcount": currentitemcount,
      };
}
