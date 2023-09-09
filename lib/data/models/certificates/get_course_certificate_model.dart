import 'dart:convert';

GetCourseCertificateModel getCourseCertificateModelFromJson(String str) =>
    GetCourseCertificateModel.fromJson(json.decode(str));

String getCourseCertificateModelToJson(GetCourseCertificateModel data) =>
    json.encode(data.toJson());

class GetCourseCertificateModel {
  final int status;
  final String message;
  final List<GetCourseDatum> data;

  GetCourseCertificateModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetCourseCertificateModel.fromJson(Map<String, dynamic> json) =>
      GetCourseCertificateModel(
        status: json["Status"],
        message: json["Message"],
        data: List<GetCourseDatum>.from(
            json["Data"].map((x) => GetCourseDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class GetCourseDatum {
  final String id;
  final String name;
  final String description;
  final String certificatename;
  final int topiccount;
  final int quizcount;
  final int notescount;
  final int completedcount;
  final int quizstartcount;
  final int quizendcount;
  final String completedstatus;

  GetCourseDatum({
    required this.id,
    required this.name,
    required this.description,
    required this.certificatename,
    required this.topiccount,
    required this.quizcount,
    required this.notescount,
    required this.completedcount,
    required this.quizstartcount,
    required this.quizendcount,
    required this.completedstatus,
  });

  factory GetCourseDatum.fromJson(Map<String, dynamic> json) => GetCourseDatum(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        certificatename: json["certificatename"],
        topiccount: json["topiccount"],
        quizcount: json["quizcount"],
        notescount: json["notescount"],
        completedcount: json["completedcount"],
        quizstartcount: json["quizstartcount"],
        quizendcount: json["quizendcount"],
        completedstatus: json["completedstatus"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "certificatename": certificatename,
        "topiccount": topiccount,
        "quizcount": quizcount,
        "notescount": notescount,
        "completedcount": completedcount,
        "quizstartcount": quizstartcount,
        "quizendcount": quizendcount,
        "completedstatus": completedstatus,
      };
}
