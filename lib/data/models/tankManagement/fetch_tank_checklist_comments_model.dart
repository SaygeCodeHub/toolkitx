import 'dart:convert';

FetchTankChecklistCommentsModel fetchTankChecklistCommentsModelFromJson(
        String str) =>
    FetchTankChecklistCommentsModel.fromJson(json.decode(str));

String fetchTankChecklistCommentsModelToJson(
        FetchTankChecklistCommentsModel data) =>
    json.encode(data.toJson());

class FetchTankChecklistCommentsModel {
  final int? status;
  final String? message;
  final Data? data;

  FetchTankChecklistCommentsModel({
    this.status,
    this.message,
    this.data,
  });

  factory FetchTankChecklistCommentsModel.fromJson(Map<String, dynamic> json) =>
      FetchTankChecklistCommentsModel(
        status: json["Status"],
        message: json["Message"],
        data: json["Data"] == null ? null : Data.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": data?.toJson(),
      };
}

class Data {
  final String? title;
  final String? optioncomment;
  final String? optionid;
  final String? optiontext;
  final String? additionalcomment;
  final String? files;

  Data({
    this.title,
    this.optioncomment,
    this.optionid,
    this.optiontext,
    this.additionalcomment,
    this.files,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        title: json["title"],
        optioncomment: json["optioncomment"],
        optionid: json["optionid"],
        optiontext: json["optiontext"],
        additionalcomment: json["additionalcomment"],
        files: json["files"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "optioncomment": optioncomment,
        "optionid": optionid,
        "optiontext": optiontext,
        "additionalcomment": additionalcomment,
        "files": files,
      };
}
