part of 'tank_management_bloc.dart';

abstract class TankManagementState {}

class TankManagementInitial extends TankManagementState {}

class TankManagementListFetching extends TankManagementState {}

class TankManagementListFetched extends TankManagementState {
  final FetchTankManagementListModel fetchTankManagementListModel;

  TankManagementListFetched({required this.fetchTankManagementListModel});
}

class TankManagementListNotFetched extends TankManagementState {
  final String errorMessage;

  TankManagementListNotFetched({required this.errorMessage});
}

class TankManagementDetailsFetching extends TankManagementState {}

class TankManagementDetailsFetched extends TankManagementState {
  final FetchTankManagementDetailsModel fetchTankManagementDetailsModel;

  TankManagementDetailsFetched({required this.fetchTankManagementDetailsModel});
}

class TankManagementDetailsNotFetched extends TankManagementState {
  final String errorMessage;

  TankManagementDetailsNotFetched({required this.errorMessage});
}

class NominationChecklistFetching extends TankManagementState {}

class NominationChecklistFetched extends TankManagementState {
  final FetchNominationChecklistModel fetchNominationChecklistModel;

  NominationChecklistFetched({required this.fetchNominationChecklistModel});
}

class NominationChecklistNotFetched extends TankManagementState {
  final String errorMessage;

  NominationChecklistNotFetched({required this.errorMessage});
}

class NominationChecklistSubmitting extends TankManagementState {}

class NominationChecklistSubmitted extends TankManagementState {}

class NominationChecklistNotSubmitted extends TankManagementState {
  final String errorMessage;

  NominationChecklistNotSubmitted({required this.errorMessage});
}

class TankCheckListAnswersSelected extends TankManagementState {
  final String? dropDownValue;
  final List multiSelectId;

  final List multiSelectNames;

  TankCheckListAnswersSelected(
      {required this.multiSelectNames,
      required this.multiSelectId,
      this.dropDownValue});
}

class TankChecklistQuestionsListFetching extends TankManagementState {}

class TankChecklistQuestionsListFetched extends TankManagementState {
  final FetchTankChecklistQuestionModel fetchTankChecklistQuestionModel;
  final List answerList;
  final Map allChecklistDataMap;
  final List<TankQuestionList> questionList;

  TankChecklistQuestionsListFetched(
      {required this.fetchTankChecklistQuestionModel,
      required this.allChecklistDataMap,
      required this.answerList,
      required this.questionList});
}

class TankCheckListQuestionsListNotFetched extends TankManagementState {
  final Map allChecklistDataMap;
  final String errorMessage;

  TankCheckListQuestionsListNotFetched(
      {required this.errorMessage, required this.allChecklistDataMap});
}

class TankCheckListCommentsFetching extends TankManagementState {}

class TankCheckListCommentsFetched extends TankManagementState {
  final FetchTankChecklistCommentsModel fetchTankChecklistCommentsModel;

  TankCheckListCommentsFetched({required this.fetchTankChecklistCommentsModel});
}

class TankCheckListCommentsNotFetched extends TankManagementState {
  final String errorMessage;

  TankCheckListCommentsNotFetched({required this.errorMessage});
}

class TankQuestionCommentsSaving extends TankManagementState {}

class TankQuestionCommentsSaved extends TankManagementState {}

class TankQuestionCommentsNotSaved extends TankManagementState {
  final String errorMessage;

  TankQuestionCommentsNotSaved({required this.errorMessage});
}
