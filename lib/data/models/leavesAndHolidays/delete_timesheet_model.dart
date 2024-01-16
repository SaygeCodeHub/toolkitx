import 'dart:convert';

DeleteTimeSheetModel deleteTimeSheetModelFromJson(String str) =>
    DeleteTimeSheetModel.fromJson(json.decode(str));

String deleteTimeSheetModelToJson(DeleteTimeSheetModel data) =>
    json.encode(data.toJson());

class DeleteTimeSheetModel {
  int status;
  String message;
  Data data;

  DeleteTimeSheetModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory DeleteTimeSheetModel.fromJson(Map<String, dynamic> json) =>
      DeleteTimeSheetModel(
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
