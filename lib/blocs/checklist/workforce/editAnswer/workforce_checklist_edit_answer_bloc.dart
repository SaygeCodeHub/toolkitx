import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/workforce/editAnswer/workforce_checklist_edit_answer_events.dart';
import 'package:toolkit/blocs/checklist/workforce/editAnswer/workforce_checklist_edit_answer_states.dart';

class WorkForceCheckListEditAnswerBloc extends Bloc<
    WorkForceCheckListEditAnswerEvent, WorkForceCheckListEditAnswerStates> {
  Map allDataForChecklistMap = {};

  WorkForceCheckListEditAnswerBloc() : super(CheckListEditAnswerInitial()) {
    on<CheckListPopulateAnswerData>(_populateAnswerData);
    on<CheckListEditAnswerEvent>(_editAnswer);
  }

  _populateAnswerData(CheckListPopulateAnswerData event,
      Emitter<WorkForceCheckListEditAnswerStates> emit) {
    add(CheckListEditAnswerEvent(
        dropDownValue: '',
        multiSelectIdList: [],
        multiSelectItem: '',
        multiSelectName: '',
        multiSelectNameList: []));
    emit(SavedCheckListQuestions(
        answerModelList: event.questionList,
        allChecklistDataMap: event.allChecklistDataMap,
        saveDraft: '',
        answersList: event.answerList));
  }

  _editAnswer(CheckListEditAnswerEvent event,
      Emitter<WorkForceCheckListEditAnswerStates> emit) {
    List multiSelectList = List.from(event.multiSelectIdList);
    List multiSelectNames = List.from(event.multiSelectNameList);
    if (event.multiSelectItem.isNotEmpty && event.multiSelectIdList != []) {
      if (event.multiSelectIdList.contains(event.multiSelectItem) != true) {
        multiSelectList.add(event.multiSelectItem);
        multiSelectNames.add(event.multiSelectName);
      } else {
        multiSelectList.remove(event.multiSelectItem);
        multiSelectNames.remove(event.multiSelectName);
      }
    }
    emit(CheckListAnswersEdited(
        dropDownValue: event.dropDownValue,
        multiSelectId: multiSelectList,
        multiSelectNames: multiSelectNames));
  }
}
