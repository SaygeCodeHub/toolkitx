import 'dart:convert';

GetQuizQuestionsModel getQuizQuestionsModelFromJson(String str) =>
    GetQuizQuestionsModel.fromJson(json.decode(str));

String getQuizQuestionsModelToJson(GetQuizQuestionsModel data) =>
    json.encode(data.toJson());

class GetQuizQuestionsModel {
  final int status;
  final String message;
  final QuizData data;

  GetQuizQuestionsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetQuizQuestionsModel.fromJson(Map<String, dynamic> json) =>
      GetQuizQuestionsModel(
        status: json["Status"],
        message: json["Message"],
        data: QuizData.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": data.toJson(),
      };
}

class QuizData {
  final String questionid;
  final String title;
  final String description;
  final String marks;
  final String workforceanswer;
  final List<Optionlist> optionlist;

  QuizData({
    required this.questionid,
    required this.title,
    required this.description,
    required this.marks,
    required this.workforceanswer,
    required this.optionlist,
  });

  factory QuizData.fromJson(Map<String, dynamic> json) => QuizData(
        questionid: json["questionid"],
        title: json["title"],
        description: json["description"],
        marks: json["marks"],
        workforceanswer: json["workforceanswer"],
        optionlist: List<Optionlist>.from(
            json["optionlist"].map((x) => Optionlist.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "questionid": questionid,
        "title": title,
        "description": description,
        "marks": marks,
        "workforceanswer": workforceanswer,
        "optionlist": List<dynamic>.from(optionlist.map((x) => x.toJson())),
      };
}

class Optionlist {
  final String id;
  final String description;

  Optionlist({
    required this.id,
    required this.description,
  });

  factory Optionlist.fromJson(Map<String, dynamic> json) => Optionlist(
        id: json["id"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
      };
}
