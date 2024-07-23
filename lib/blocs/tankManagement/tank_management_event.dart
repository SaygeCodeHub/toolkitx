part of 'tank_management_bloc.dart';

abstract class TankManagementEvent {}

class FetchTankManagementList extends TankManagementEvent {
  final int pageNo;
  final bool isFromHome;

  FetchTankManagementList({required this.pageNo, required this.isFromHome});
}

class FetchTankManagementDetails extends TankManagementEvent {
  final String nominationId;

  FetchTankManagementDetails({required this.nominationId});
}

class FetchNominationChecklist extends TankManagementEvent {
  final String nominationId;
  final int tabIndex;

  FetchNominationChecklist(
      {required this.nominationId, required this.tabIndex});
}

class SubmitNominationChecklist extends TankManagementEvent {
  final Map tankChecklistMap;
  final List editQuestionsList;
  final bool isDraft;

  SubmitNominationChecklist(
      {required this.tankChecklistMap,
      required this.editQuestionsList,
      required this.isDraft});
}

class SelectTankChecklistAnswer extends TankManagementEvent {
  final String? dropDownValue;
  final List multiSelectIdList;
  final String multiSelectItem;
  final String? radioValue;
  final String multiSelectName;
  final List multiSelectNameList;

  SelectTankChecklistAnswer(
      {required this.multiSelectNameList,
      required this.multiSelectName,
      this.radioValue = '',
      required this.multiSelectItem,
      required this.multiSelectIdList,
      this.dropDownValue = ''});
}

class TankCheckListFetchQuestions extends TankManagementEvent {
  final Map tankChecklistMap;

  TankCheckListFetchQuestions({required this.tankChecklistMap});
}

class FetchTankChecklistComments extends TankManagementEvent {
  final String questionId;

  FetchTankChecklistComments({required this.questionId});
}
