import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/data/cache/cache_keys.dart';
import 'package:toolkit/data/cache/customer_cache.dart';
import 'package:toolkit/data/models/tankManagement/fetch_nomination_checklist_model.dart';
import 'package:toolkit/data/models/tankManagement/fetch_tank_management_details_model.dart';
import 'package:toolkit/data/models/tankManagement/fetch_tank_management_list_module.dart';
import 'package:toolkit/di/app_module.dart';
import 'package:toolkit/repositories/tankManagement/tank_management_repository.dart';

import '../../data/models/tankManagement/fetch_tank_checklist_question_model.dart';
import '../../data/models/tankManagement/submit_nomination_checklist_model.dart';
import '../../utils/constants/string_constants.dart';

part 'tank_management_event.dart';

part 'tank_management_state.dart';

class TankManagementBloc
    extends Bloc<TankManagementEvent, TankManagementState> {
  final CustomerCache _customerCache = getIt<CustomerCache>();
  final TankManagementRepository _managementRepository =
      getIt<TankManagementRepository>();

  TankManagementState get initialState => TankManagementInitial();

  TankManagementBloc() : super(TankManagementInitial()) {
    on<FetchTankManagementList>(_fetchTankManagementList);
    on<FetchTankManagementDetails>(_fetchTankManagementDetails);
    on<FetchNominationChecklist>(_fetchNominationChecklist);
    on<SubmitNominationChecklist>(_submitNominationChecklist);
    on<SelectTankChecklistAnswer>(_selectTankChecklistAnswer);
    on<TankCheckListFetchQuestions>(_tankCheckListFetchQuestions);
  }

  List answerList = [];
  List<Questionlist>? questionList;
  Map allDataForChecklistMap = {};
  Map filterMap = {};
  int tabIndex = 0;

  Future<FutureOr<void>> _fetchTankManagementList(
      FetchTankManagementList event, Emitter<TankManagementState> emit) async {
    emit(TankManagementListFetching());
    try {
      String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      String? userId = await _customerCache.getUserId(CacheKeys.userId) ?? '';

      FetchTankManagementListModel fetchTankManagementListModel =
          await _managementRepository.fetchTankManagementList(
              event.pageNo, hashCode, '', userId);
      if (fetchTankManagementListModel.status == 200) {
        emit(TankManagementListFetched(
            fetchTankManagementListModel: fetchTankManagementListModel));
      } else {
        emit(TankManagementListNotFetched(
            errorMessage: fetchTankManagementListModel.message));
      }
    } catch (e) {
      emit(TankManagementListNotFetched(errorMessage: e.toString()));
    }
  }

  Future<FutureOr<void>> _fetchTankManagementDetails(
      FetchTankManagementDetails event,
      Emitter<TankManagementState> emit) async {
    emit(TankManagementDetailsFetching());
    try {
      String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';

      FetchTankManagementDetailsModel fetchTankManagementDetailsModel =
          await _managementRepository.fetchTankManagementDetails(
              event.nominationId, hashCode);
      if (fetchTankManagementDetailsModel.status == 200) {
        emit(TankManagementDetailsFetched(
            fetchTankManagementDetailsModel: fetchTankManagementDetailsModel));
      } else {
        emit(TankManagementDetailsNotFetched(
            errorMessage: fetchTankManagementDetailsModel.message));
      }
    } catch (e) {
      emit(TankManagementDetailsNotFetched(errorMessage: e.toString()));
    }
  }

  Future<FutureOr<void>> _fetchNominationChecklist(
      FetchNominationChecklist event, Emitter<TankManagementState> emit) async {
    emit(NominationChecklistFetching());
    tabIndex = event.tabIndex;
    try {
      String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      String? userId = await _customerCache.getUserId(CacheKeys.userId) ?? '';

      FetchNominationChecklistModel fetchNominationChecklistModel =
          await _managementRepository.fetchNominationChecklist(
              event.nominationId, hashCode, userId);
      if (fetchNominationChecklistModel.status == 200) {
        emit(NominationChecklistFetched(
            fetchNominationChecklistModel: fetchNominationChecklistModel));
      } else {
        emit(NominationChecklistNotFetched(
            errorMessage: fetchNominationChecklistModel.message));
      }
    } catch (e) {
      emit(NominationChecklistNotFetched(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _selectTankChecklistAnswer(
      SelectTankChecklistAnswer event, Emitter<TankManagementState> emit) {
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
    emit(TankCheckListAnswersSelected(
        dropDownValue: event.dropDownValue,
        multiSelectId: multiSelectList,
        multiSelectNames: multiSelectNames));
  }

  Future<FutureOr<void>> _submitNominationChecklist(
      SubmitNominationChecklist event,
      Emitter<TankManagementState> emit) async {
    emit(NominationChecklistSubmitting());
    try {
      Map tankChecklistMap = {
        "executionid": "4EXuS6I0AhNAJeJmuB7q0w==",
        "userid": "2ATY8mLx8MjkcnrmiRLvrA==",
        "isdraft": "1",
        "questions": [
          {"questionid": "1taSheEvrxhT90dldIQnJA==", "answer": "1"},
          {"questionid": "x+XZRx2SWL3fBM7x1d5fYw==", "answer": "1"}
        ],
        "hashcode":
            "vbdvrj9aN/gnmG9HRZBOV137+VBlDH1innvdsfSI8lOHTShvQP8iAcfeuRbflSG0|23|1|1|cet_3"
      };
      SubmitNominationChecklistModel submitNominationChecklistModel =
          await _managementRepository.saveNominationChecklist(tankChecklistMap);
      if (submitNominationChecklistModel.message == '1') {
        emit(NominationChecklistSubmitted());
      } else {
        emit(NominationChecklistNotSubmitted(
            errorMessage: submitNominationChecklistModel.message));
      }
    } catch (e) {
      emit(NominationChecklistNotSubmitted(errorMessage: e.toString()));
    }
  }

  Future<FutureOr<void>> _tankCheckListFetchQuestions(
      TankCheckListFetchQuestions event,
      Emitter<TankManagementState> emit) async {
    emit(TankChecklistQuestionsListFetching());
    answerList.clear();
    try {
      allDataForChecklistMap = event.tankChecklistMap;
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      String userId = (await _customerCache.getUserId(CacheKeys.userId))!;
      String answerText = '';
      FetchTankChecklistQuestionModel fetchTankChecklistQuestionModel =
          await _managementRepository.fetchTankQuestionsList(
              event.tankChecklistMap["scheduleId"], userId, hashCode);
      if (fetchTankChecklistQuestionModel.status == 200) {
        questionList = fetchTankChecklistQuestionModel.data!.questionlist;
        if (questionList!.isNotEmpty) {
          for (int i = 0;
              i < fetchTankChecklistQuestionModel.data!.questionlist!.length;
              i++) {
            if (fetchTankChecklistQuestionModel
                        .data!.questionlist![i].optioncomment !=
                    null &&
                fetchTankChecklistQuestionModel
                        .data!.questionlist![i].optioncomment.length >
                    0) {
              answerText = fetchTankChecklistQuestionModel
                  .data!.questionlist![i].optioncomment
                  .toString();
            } else if (fetchTankChecklistQuestionModel
                    .data!.questionlist![i].optionid !=
                null) {
              answerText = fetchTankChecklistQuestionModel
                  .data!.questionlist![i].optiontext
                  .toString();
            } else {
              answerText = '';
            }
            answerList.add({
              "questionid":
                  fetchTankChecklistQuestionModel.data!.questionlist![i].id,
              "answer": answerText,
              "ismandatory": fetchTankChecklistQuestionModel
                  .data!.questionlist![i].ismandatory,
            });
          }
          emit(TankChecklistQuestionsListFetched(
              fetchTankChecklistQuestionModelQuestionListModel:
                  fetchTankChecklistQuestionModel,
              answerList: answerList,
              allChecklistDataMap: allDataForChecklistMap));
        } else {
          emit(TankCheckListQuestionsListNotFetched(
              allChecklistDataMap: {},
              errorMessage: StringConstants.kNoRecordsFound));
        }
      }
    } catch (e) {
      emit(TankCheckListQuestionsListNotFetched(
          allChecklistDataMap: allDataForChecklistMap,
          errorMessage: e.toString()));
    }
  }
}
