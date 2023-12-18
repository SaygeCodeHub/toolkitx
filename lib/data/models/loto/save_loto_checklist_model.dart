import 'dart:convert';

SaveLotoChecklistModel saveLotoChecklistModelFromJson(String str) =>
    SaveLotoChecklistModel.fromJson(json.decode(str));

String saveLotoChecklistModelToJson(SaveLotoChecklistModel data) =>
    json.encode(data.toJson());

class SaveLotoChecklistModel {
  final String? id;
  final String? userid;
  final String? hashcode;
  final String? isremove;
  final List<Question>? questions;
  final String? checklistid;

  SaveLotoChecklistModel({
    this.id,
    this.userid,
    this.hashcode,
    this.isremove,
    this.questions,
    this.checklistid,
  });

  factory SaveLotoChecklistModel.fromJson(Map<String, dynamic> json) =>
      SaveLotoChecklistModel(
        id: json["id"],
        userid: json["userid"],
        hashcode: json["hashcode"],
        isremove: json["isremove"],
        questions: json["questions"] == null
            ? []
            : List<Question>.from(
                json["questions"]!.map((x) => Question.fromJson(x))),
        checklistid: json["checklistid"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userid": userid,
        "hashcode": hashcode,
        "isremove": isremove,
        "questions": questions == null
            ? []
            : List<dynamic>.from(questions!.map((x) => x.toJson())),
        "checklistid": checklistid,
      };
}

class Question {
  final String? questionid;
  final String? answer;

  Question({
    this.questionid,
    this.answer,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        questionid: json["questionid"],
        answer: json["answer"],
      );

  Map<String, dynamic> toJson() => {
        "questionid": questionid,
        "answer": answer,
      };
}
