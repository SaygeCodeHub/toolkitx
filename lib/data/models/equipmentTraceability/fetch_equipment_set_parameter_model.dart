import 'dart:convert';

FetchEquipmentSetParameterModel fetchEquipmentSetParameterModelFromJson(
        String str) =>
    FetchEquipmentSetParameterModel.fromJson(json.decode(str));

String fetchEquipmentSetParameterModelToJson(
        FetchEquipmentSetParameterModel data) =>
    json.encode(data.toJson());

class FetchEquipmentSetParameterModel {
  final int status;
  final String message;
  final EquipmentSetParameter data;

  FetchEquipmentSetParameterModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchEquipmentSetParameterModel.fromJson(Map<String, dynamic> json) =>
      FetchEquipmentSetParameterModel(
        status: json["Status"],
        message: json["Message"],
        data: EquipmentSetParameter.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": data.toJson(),
      };
}

class EquipmentSetParameter {
  final String equipmentname;
  final String equipmentcode;
  final List<Parameterlist> parameterlist;

  EquipmentSetParameter({
    required this.equipmentname,
    required this.equipmentcode,
    required this.parameterlist,
  });

  factory EquipmentSetParameter.fromJson(Map<String, dynamic> json) =>
      EquipmentSetParameter(
        equipmentname: json["equipmentname"],
        equipmentcode: json["equipmentcode"],
        parameterlist: List<Parameterlist>.from(
            json["parameterlist"].map((x) => Parameterlist.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "equipmentname": equipmentname,
        "equipmentcode": equipmentcode,
        "parameterlist":
            List<dynamic>.from(parameterlist.map((x) => x.toJson())),
      };
}

class Parameterlist {
  final int id;
  final String name;
  final String unitname;

  Parameterlist({
    required this.id,
    required this.name,
    required this.unitname,
  });

  factory Parameterlist.fromJson(Map<String, dynamic> json) => Parameterlist(
        id: json["id"],
        name: json["name"],
        unitname: json["unitname"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "unitname": unitname,
      };
}
