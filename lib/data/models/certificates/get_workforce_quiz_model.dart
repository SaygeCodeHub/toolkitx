import 'dart:convert';

GetWorkforceQuizModel getWorkforceQuizModelFromJson(String str) =>
    GetWorkforceQuizModel.fromJson(json.decode(str));

String getWorkforceQuizModelToJson(GetWorkforceQuizModel data) =>
    json.encode(data.toJson());

class GetWorkforceQuizModel {
  final int status;
  final String message;
  final WorkforceQuizData data;

  GetWorkforceQuizModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetWorkforceQuizModel.fromJson(Map<String, dynamic> json) =>
      GetWorkforceQuizModel(
        status: json["Status"],
        message: json["Message"],
        data: WorkforceQuizData.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": data.toJson(),
      };
}

class WorkforceQuizData {
  final String error;
  final String showstartquiz;
  final String showquizreport;
  final String userquizid;
  final String isquizrunning;
  final String questioncount;
  final String quizname;
  final String coursename;
  final String totalmarks;
  final String score;
  final String isretake;
  final String passed;
  final String certificatename;

  WorkforceQuizData({
    required this.error,
    required this.showstartquiz,
    required this.showquizreport,
    required this.userquizid,
    required this.isquizrunning,
    required this.questioncount,
    required this.quizname,
    required this.coursename,
    required this.totalmarks,
    required this.score,
    required this.isretake,
    required this.passed,
    required this.certificatename,
  });

  factory WorkforceQuizData.fromJson(Map<String, dynamic> json) =>
      WorkforceQuizData(
        error: json["error"] ?? "",
        showstartquiz: json["showstartquiz"] ?? "",
        showquizreport: json["showquizreport"] ?? "",
        userquizid: json["userquizid"] ?? "",
        isquizrunning: json["isquizrunning"] ?? "",
        questioncount: json["questioncount"] ?? "",
        quizname: json["quizname"] ?? "",
        coursename: json["coursename"] ?? "",
        totalmarks: json["totalmarks"] ?? "",
        score: json["score"] ?? "",
        isretake: json["isretake"] ?? "",
        passed: json["passed"] ?? "",
        certificatename: json["certificatename"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "showstartquiz": showstartquiz,
        "showquizreport": showquizreport,
        "userquizid": userquizid,
        "isquizrunning": isquizrunning,
        "questioncount": questioncount,
        "quizname": quizname,
        "coursename": coursename,
        "totalmarks": totalmarks,
        "score": score,
        "isretake": isretake,
        "passed": passed,
        "certificatename": certificatename,
      };
}
