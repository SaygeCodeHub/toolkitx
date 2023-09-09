import 'dart:convert';

GetTopicCertificateModel getTopicCertificateModelFromJson(String str) =>
    GetTopicCertificateModel.fromJson(json.decode(str));

String getTopicCertificateModelToJson(GetTopicCertificateModel data) =>
    json.encode(data.toJson());

class GetTopicCertificateModel {
  final int status;
  final String message;
  final GetTopicData data;

  GetTopicCertificateModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetTopicCertificateModel.fromJson(Map<String, dynamic> json) =>
      GetTopicCertificateModel(
        status: json["Status"],
        message: json["Message"],
        data: GetTopicData.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": data.toJson(),
      };
}

class GetTopicData {
  final String coursename;
  final String coursedescription;
  final String certificatename;
  final List<Topiclist> topiclist;
  final List<Quizlist> quizlist;

  GetTopicData({
    required this.coursename,
    required this.coursedescription,
    required this.certificatename,
    required this.topiclist,
    required this.quizlist,
  });

  factory GetTopicData.fromJson(Map<String, dynamic> json) => GetTopicData(
        coursename: json["coursename"],
        coursedescription: json["coursedescription"],
        certificatename: json["certificatename"],
        topiclist: List<Topiclist>.from(
            json["topiclist"].map((x) => Topiclist.fromJson(x))),
        quizlist: List<Quizlist>.from(
            json["quizlist"].map((x) => Quizlist.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "coursename": coursename,
        "coursedescription": coursedescription,
        "certificatename": certificatename,
        "topiclist": List<dynamic>.from(topiclist.map((x) => x.toJson())),
        "quizlist": List<dynamic>.from(quizlist.map((x) => x.toJson())),
      };
}

class Quizlist {
  final String id;
  final String name;
  final int questionscount;
  final dynamic passed;
  final String startdate;
  final String enddate;

  Quizlist({
    required this.id,
    required this.name,
    required this.questionscount,
    required this.passed,
    required this.startdate,
    required this.enddate,
  });

  factory Quizlist.fromJson(Map<String, dynamic> json) => Quizlist(
        id: json["id"],
        name: json["name"],
        questionscount: json["questionscount"],
        passed: json["passed"],
        startdate: json["startdate"],
        enddate: json["enddate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "questionscount": questionscount,
        "passed": passed,
        "startdate": startdate,
        "enddate": enddate,
      };
}

class Topiclist {
  final String id;
  final String name;
  final String description;
  final int notescount;
  final int completedcount;

  Topiclist({
    required this.id,
    required this.name,
    required this.description,
    required this.notescount,
    required this.completedcount,
  });

  factory Topiclist.fromJson(Map<String, dynamic> json) => Topiclist(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        notescount: json["notescount"],
        completedcount: json["completedcount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "notescount": notescount,
        "completedcount": completedcount,
      };
}
