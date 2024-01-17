import 'dart:convert';

SaveTimeSheetModel saveTimeSheetModelFromJson(String str) =>
    SaveTimeSheetModel.fromJson(json.decode(str));

String saveTimeSheetModelToJson(SaveTimeSheetModel data) =>
    json.encode(data.toJson());

class SaveTimeSheetModel {
  final int status;
  final String message;
  final Data data;

  SaveTimeSheetModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SaveTimeSheetModel.fromJson(Map<String, dynamic> json) =>
      SaveTimeSheetModel(
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
