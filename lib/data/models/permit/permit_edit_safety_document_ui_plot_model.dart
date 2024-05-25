import 'dart:convert';

PermitEditSafetyDocumentUiPlotModel permitEditSafetyDocumentUiPlotModelFromJson(
        String str) =>
    PermitEditSafetyDocumentUiPlotModel.fromJson(json.decode(str));

String permitEditSafetyDocumentUiPlotModelToJson(
        PermitEditSafetyDocumentUiPlotModel data) =>
    json.encode(data.toJson());

class PermitEditSafetyDocumentUiPlotModel {
  final List<Question> questions;

  PermitEditSafetyDocumentUiPlotModel({required this.questions});

  factory PermitEditSafetyDocumentUiPlotModel.fromJson(
          Map<String, dynamic> json) =>
      PermitEditSafetyDocumentUiPlotModel(
        questions: List<Question>.from(
            json["questions"].map((x) => Question.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
      };
}

class Question {
  final String questionNo;

  Question({required this.questionNo});

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        questionNo: json["question_no"],
      );

  Map<String, dynamic> toJson() => {"question_no": questionNo};
}
