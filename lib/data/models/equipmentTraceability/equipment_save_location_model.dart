import 'dart:convert';

EquipmentSaveLocationModel equipmentSaveLocationModelFromJson(String str) =>
    EquipmentSaveLocationModel.fromJson(json.decode(str));

String equipmentSaveLocationModelToJson(EquipmentSaveLocationModel data) =>
    json.encode(data.toJson());

class EquipmentSaveLocationModel {
  final int status;
  final String message;
  final Data data;

  EquipmentSaveLocationModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory EquipmentSaveLocationModel.fromJson(Map<String, dynamic> json) =>
      EquipmentSaveLocationModel(
        status: json["Status"],
        message: json["Message"],
        data: Data.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": data.toJson(),
      };
}

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}
