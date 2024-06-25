import '../../../../data/models/checklist/workforce/workforce_questions_list_model.dart';

abstract class WorkForceCheckListEditAnswerEvent {}

class CheckListPopulateAnswerData extends WorkForceCheckListEditAnswerEvent {
  final List<Questionlist> questionList;
  final String? multiSelect;
  final String? dropDownValue;
  final List answerList;
  final Map allChecklistDataMap;

  CheckListPopulateAnswerData(
      {required this.allChecklistDataMap,
      required this.answerList,
      required this.dropDownValue,
      required this.multiSelect,
      required this.questionList});
}

class CheckListEditAnswerEvent extends WorkForceCheckListEditAnswerEvent {
  final String? dropDownValue;
  final List multiSelectIdList;
  final String multiSelectItem;
  final String? radioValue;
  final String multiSelectName;
  final List multiSelectNameList;

  CheckListEditAnswerEvent(
      {required this.multiSelectNameList,
      required this.multiSelectName,
      this.radioValue = '',
      required this.multiSelectItem,
      required this.multiSelectIdList,
      this.dropDownValue = ''});
}
