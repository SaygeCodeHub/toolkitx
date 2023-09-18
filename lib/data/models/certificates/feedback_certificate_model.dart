import 'dart:convert';

FeedbackCertificateModel feedbackCertificateModelFromJson(String str) =>
    FeedbackCertificateModel.fromJson(json.decode(str));

String feedbackCertificateModelToJson(FeedbackCertificateModel data) =>
    json.encode(data.toJson());

class FeedbackCertificateModel {
  final int status;
  final String message;
  final Data data;

  FeedbackCertificateModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FeedbackCertificateModel.fromJson(Map<String, dynamic> json) =>
      FeedbackCertificateModel(
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
  final dynamic certificatename;
  final List<Question> questions;

  Data({
    required this.certificatename,
    required this.questions,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        certificatename: json["certificatename"],
        questions: List<Question>.from(
            json["questions"].map((x) => Question.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "certificatename": certificatename,
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
      };
}

class Question {
  final dynamic id;
  final String questiontext;
  final String answer;

  Question({
    required this.id,
    required this.questiontext,
    required this.answer,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["id"],
        questiontext: json["questiontext"],
        answer: json["answer"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "questiontext": questiontext,
        "answer": answer,
      };
}
