import 'dart:convert';

SaveLotoAssignTeamModel saveLotoAssignTeamModelFromJson(String str) =>
    SaveLotoAssignTeamModel.fromJson(json.decode(str));

String saveLotoAssignTeamModelToJson(SaveLotoAssignTeamModel data) =>
    json.encode(data.toJson());

class SaveLotoAssignTeamModel {
  final int status;
  final String message;
  final Data data;

  SaveLotoAssignTeamModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SaveLotoAssignTeamModel.fromJson(Map<String, dynamic> json) =>
      SaveLotoAssignTeamModel(
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
