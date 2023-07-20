import 'dart:convert';

EditIncidentDetailsModel editIncidentDetailsModelFromJson(String str) =>
    EditIncidentDetailsModel.fromJson(json.decode(str));

String editIncidentDetailsModelToJson(EditIncidentDetailsModel data) =>
    json.encode(data.toJson());

class EditIncidentDetailsModel {
  final int status;
  final String message;
  final Data data;

  EditIncidentDetailsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory EditIncidentDetailsModel.fromJson(Map<String, dynamic> json) =>
      EditIncidentDetailsModel(
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
