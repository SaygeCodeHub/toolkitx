import 'dart:convert';

EditWorkOrderWorkForceModel editWorkOrderWorkForceModelFromJson(String str) =>
    EditWorkOrderWorkForceModel.fromJson(json.decode(str));

String editWorkOrderWorkForceModelToJson(EditWorkOrderWorkForceModel data) =>
    json.encode(data.toJson());

class EditWorkOrderWorkForceModel {
  final int status;
  final String message;
  final Data data;

  EditWorkOrderWorkForceModel(
      {required this.status, required this.message, required this.data});

  factory EditWorkOrderWorkForceModel.fromJson(Map<String, dynamic> json) =>
      EditWorkOrderWorkForceModel(
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
