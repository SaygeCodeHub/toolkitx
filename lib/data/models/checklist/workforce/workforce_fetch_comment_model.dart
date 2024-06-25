import 'dart:convert';

GetQuestionCommentsModel getQuestionCommentsModelFromJson(String str) =>
    GetQuestionCommentsModel.fromJson(json.decode(str));

String getQuestionCommentsModelToJson(GetQuestionCommentsModel data) =>
    json.encode(data.toJson());

class GetQuestionCommentsModel {
  final int status;
  final String? message;
  final Data? data;

  GetQuestionCommentsModel({
    required this.status,
    this.message,
    this.data,
  });

  factory GetQuestionCommentsModel.fromJson(Map<String, dynamic> json) =>
      GetQuestionCommentsModel(
        status: json["Status"],
        message: json["Message"],
        data: Data.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": data!.toJson(),
      };
}

class Data {
  final String title;
  final String? optioncomment;
  final String? optionid;
  final String? optiontext;
  final String? additionalcomment;
  final String? files;

  Data({
    required this.title,
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
