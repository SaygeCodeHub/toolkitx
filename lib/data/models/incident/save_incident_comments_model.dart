import 'dart:convert';

SaveIncidentAndQMCommentsModel saveIncidentCommentsModelFromJson(String str) =>
    SaveIncidentAndQMCommentsModel.fromJson(json.decode(str));

String saveIncidentCommentsModelToJson(SaveIncidentAndQMCommentsModel data) =>
    json.encode(data.toJson());

class SaveIncidentAndQMCommentsModel {
  final int status;
  final String message;
  final Data data;

  SaveIncidentAndQMCommentsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SaveIncidentAndQMCommentsModel.fromJson(Map<String, dynamic> json) =>
      SaveIncidentAndQMCommentsModel(
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
