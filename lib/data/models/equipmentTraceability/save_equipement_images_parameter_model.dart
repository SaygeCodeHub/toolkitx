import 'dart:convert';

SaveEquipmentImagesModel saveEquipmentImagesModelFromJson(String str) =>
    SaveEquipmentImagesModel.fromJson(json.decode(str));

String saveEquipmentImagesModelToJson(SaveEquipmentImagesModel data) =>
    json.encode(data.toJson());

class SaveEquipmentImagesModel {
  final int status;
  final String message;
  final SaveImageParameter data;

  SaveEquipmentImagesModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SaveEquipmentImagesModel.fromJson(Map<String, dynamic> json) =>
      SaveEquipmentImagesModel(
        status: json["Status"],
        message: json["Message"],
        data: SaveImageParameter.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": data.toJson(),
      };
}

class SaveImageParameter {
  SaveImageParameter();

  factory SaveImageParameter.fromJson(Map<String, dynamic> json) =>
      SaveImageParameter();

  Map<String, dynamic> toJson() => {};
}
