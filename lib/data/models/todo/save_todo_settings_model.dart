import 'dart:convert';

SaveToDoSettingsModel saveToDoSettingsModelFromJson(String str) =>
    SaveToDoSettingsModel.fromJson(json.decode(str));

String saveToDoSettingsModelToJson(SaveToDoSettingsModel data) =>
    json.encode(data.toJson());

class SaveToDoSettingsModel {
  final int status;
  final String message;
  final Data data;

  SaveToDoSettingsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SaveToDoSettingsModel.fromJson(Map<String, dynamic> json) =>
      SaveToDoSettingsModel(
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
