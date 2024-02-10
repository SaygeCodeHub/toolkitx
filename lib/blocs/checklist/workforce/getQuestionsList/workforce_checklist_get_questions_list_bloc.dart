import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import '../../../../data/cache/cache_keys.dart';
import '../../../../data/cache/customer_cache.dart';
import '../../../../data/models/checklist/workforce/workforce_questions_list_model.dart';
import '../../../../di/app_module.dart';
import '../../../../repositories/checklist/workforce/workforce_repository.dart';
import 'workforce_checklist_get_questions_list_events.dart';
import 'workforce_cheklist_get_questions_list_states.dart';

class WorkForceQuestionsListBloc extends Bloc<WorkForceCheckListFetchQuestions,
    WorkForceCheckListQuestionsStates> {
  final WorkForceRepository _workForceRepository = getIt<WorkForceRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  List answerList = [];
  List<Questionlist>? questionList;
  Map allDataForChecklistMap = {};

  WorkForceQuestionsListBloc() : super(CheckListFetchQuestionsListInitial()) {
    on<WorkForceCheckListFetchQuestions>(_fetchQuestions);
  }

  FutureOr<void> _fetchQuestions(WorkForceCheckListFetchQuestions event,
      Emitter<WorkForceCheckListQuestionsStates> emit) async {
    emit(CheckListFetchingQuestionsList());
    answerList.clear();
    try {
      allDataForChecklistMap = event.checklistData;
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      String userId = (await _customerCache.getUserId(CacheKeys.userId))!;
      String answerText = '';
      GetQuestionListModel getQuestionListModel =
          await _workForceRepository.fetchQuestionsList(
              event.checklistData["scheduleId"], userId, hashCode);
      if (getQuestionListModel.status == 200) {
        questionList = getQuestionListModel.data!.questionlist;
        if (questionList!.isNotEmpty) {
          for (int i = 0;
              i < getQuestionListModel.data!.questionlist!.length;
              i++) {
            if (getQuestionListModel.data!.questionlist![i].optioncomment !=
                    null &&
                getQuestionListModel
                        .data!.questionlist![i].optioncomment.length >
                    0) {
              answerText = getQuestionListModel
                  .data!.questionlist![i].optioncomment
                  .toString();
            } else if (getQuestionListModel.data!.questionlist![i].optionid !=
                null) {
              answerText = getQuestionListModel
                  .data!.questionlist![i].optiontext
                  .toString();
            } else {
              answerText = '';
            }
            answerList.add({
              "questionid": getQuestionListModel.data!.questionlist![i].id,
              "answer": answerText,
              "ismandatory":
                  getQuestionListModel.data!.questionlist![i].ismandatory,
            });
          }
          emit(QuestionsListFetched(
              getQuestionListModel: getQuestionListModel,
              answerList: answerList,
              allChecklistDataMap: allDataForChecklistMap));
        } else {
          emit(CheckListQuestionsListNotFetched(
              allChecklistDataMap: {},
              errorMessage: StringConstants.kNoRecordsFound));
        }
      }
    } catch (e) {
      emit(CheckListQuestionsListNotFetched(
          allChecklistDataMap: allDataForChecklistMap,
          errorMessage: e.toString()));
    }
  }
}
