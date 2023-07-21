import 'dart:convert';

SaveIncidentCommentsModel saveIncidentCommentsModelFromJson(String str) =>
    SaveIncidentCommentsModel.fromJson(json.decode(str));

String saveIncidentCommentsModelToJson(SaveIncidentCommentsModel data) =>
    json.encode(data.toJson());

class SaveIncidentCommentsModel {
  final int status;
  final String message;
  final Data data;

  SaveIncidentCommentsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SaveIncidentCommentsModel.fromJson(Map<String, dynamic> json) =>
      SaveIncidentCommentsModel(
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
