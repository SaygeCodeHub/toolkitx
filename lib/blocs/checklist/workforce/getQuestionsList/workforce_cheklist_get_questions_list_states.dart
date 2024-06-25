import '../../../../data/models/checklist/workforce/workforce_questions_list_model.dart';

abstract class WorkForceCheckListQuestionsStates {}

class CheckListFetchQuestionsListInitial
    extends WorkForceCheckListQuestionsStates {}

class CheckListFetchingQuestionsList
    extends WorkForceCheckListQuestionsStates {}

class QuestionsListFetched extends WorkForceCheckListQuestionsStates {
  final GetQuestionListModel getQuestionListModel;
  final List answerList;
  final Map allChecklistDataMap;

  QuestionsListFetched(
      {required this.getQuestionListModel,
      required this.allChecklistDataMap,
      required this.answerList});
}

class CheckListQuestionsListNotFetched
    extends WorkForceCheckListQuestionsStates {
  final Map allChecklistDataMap;
  final String errorMessage;

  CheckListQuestionsListNotFetched(
      {required this.errorMessage, required this.allChecklistDataMap});
}
