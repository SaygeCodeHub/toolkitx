part of 'tank_management_bloc.dart';

abstract class TankManagementState {}

class TankManagementInitial extends TankManagementState {}

class TankManagementListFetching extends TankManagementState {}

class TankManagementListFetched extends TankManagementState {
  final FetchTankManagementListModel fetchTankManagementListModel;
  final List<TankDatum> tankDatum;
  final Map filterMap;

  TankManagementListFetched(
      {required this.fetchTankManagementListModel,
      required this.tankDatum,
      required this.filterMap});
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

class TmsNominationDataFetching extends TankManagementState {}

class TmsNominationDataFetched extends TankManagementState {
  final FetchTmsNominationDataModel fetchTmsNominationDataModel;

  TmsNominationDataFetched({required this.fetchTmsNominationDataModel});
}

class TmsNominationDataNotFetched extends TankManagementState {
  final String errorMessage;

  TmsNominationDataNotFetched({required this.errorMessage});
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
  final String clientId;

  TankCheckListCommentsFetched(
      {required this.fetchTankChecklistCommentsModel, required this.clientId});
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

class TankStatusFilterSelected extends TankManagementState {
  final String selectedIndex;
  final bool selected;

  TankStatusFilterSelected(
      {required this.selected, required this.selectedIndex});
}

class TankTitleFilterSelected extends TankManagementState {
  final String selectedIndex;
  final bool selected;

  TankTitleFilterSelected(
      {required this.selected, required this.selectedIndex});
}
