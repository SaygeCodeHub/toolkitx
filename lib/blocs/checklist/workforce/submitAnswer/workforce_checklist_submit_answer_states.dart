import 'package:equatable/equatable.dart';

import '../../../../data/models/checklist/workforce/workforce_checklist_submit_answer_model.dart';

abstract class SubmitAnswerStates extends Equatable {}

class SubmitAnswerInitial extends SubmitAnswerStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class SubmittingAnswer extends SubmitAnswerStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class AnswerSubmitted extends SubmitAnswerStates {
  final SubmitQuestionModel submitQuestionModel;

  AnswerSubmitted({required this.submitQuestionModel});

  @override
  List<Object?> get props => [submitQuestionModel];
}

class AnswerNotSubmitted extends SubmitAnswerStates {
  final String message;

  AnswerNotSubmitted({required this.message});

  @override
  List<Object?> get props => throw UnimplementedError();
}
