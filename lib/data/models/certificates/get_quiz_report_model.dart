import 'dart:convert';

FetchQuizReportModel fetchQuizReportModelFromJson(String str) =>
    FetchQuizReportModel.fromJson(json.decode(str));

String fetchQuizReportModelToJson(FetchQuizReportModel data) =>
    json.encode(data.toJson());

class FetchQuizReportModel {
  final int status;
  final String message;
  final List<Datum> data;

  FetchQuizReportModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchQuizReportModel.fromJson(Map<String, dynamic> json) =>
      FetchQuizReportModel(
        status: json["Status"],
        message: json["Message"],
        data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  final String id;
  final String title;
  final int marks;
  final String workforceanswer;
  final String answerstatus;

  Datum({
    required this.id,
    required this.title,
    required this.marks,
    required this.workforceanswer,
    required this.answerstatus,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        marks: json["marks"],
        workforceanswer: json["workforceanswer"],
        answerstatus: json["answerstatus"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "marks": marks,
        "workforceanswer": workforceanswer,
        "answerstatus": answerstatus,
      };
}
