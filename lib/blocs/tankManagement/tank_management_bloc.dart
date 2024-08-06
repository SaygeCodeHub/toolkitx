import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/data/cache/cache_keys.dart';
import 'package:toolkit/data/cache/customer_cache.dart';
import 'package:toolkit/data/models/tankManagement/fetch_nomination_checklist_model.dart';
import 'package:toolkit/data/models/tankManagement/fetch_tank_checklist_comments_model.dart';
import 'package:toolkit/data/models/tankManagement/fetch_tank_management_details_model.dart';
import 'package:toolkit/data/models/tankManagement/fetch_tank_management_list_module.dart';
import 'package:toolkit/data/models/tankManagement/fetch_tms_nomination_data_model.dart';
import 'package:toolkit/data/models/tankManagement/save_tank_questions_comments_model.dart';
import 'package:toolkit/di/app_module.dart';
import 'package:toolkit/repositories/tankManagement/tank_management_repository.dart';

import '../../data/models/tankManagement/fetch_tank_checklist_question_model.dart';
import '../../data/models/tankManagement/submit_nomination_checklist_model.dart';
import '../../utils/constants/string_constants.dart';
import '../../utils/database_utils.dart';

part 'tank_management_event.dart';

part 'tank_management_state.dart';

class TankManagementBloc
    extends Bloc<TankManagementEvent, TankManagementState> {
  final CustomerCache _customerCache = getIt<CustomerCache>();
  final TankManagementRepository _tankManagementRepository =
      getIt<TankManagementRepository>();

  TankManagementState get initialState => TankManagementInitial();

  TankManagementBloc() : super(TankManagementInitial()) {
    on<FetchTankManagementList>(_fetchTankManagementList);
    on<FetchTankManagementDetails>(_fetchTankManagementDetails);
    on<FetchTmsNominationData>(_fetchTmsNominationData);
    on<FetchNominationChecklist>(_fetchNominationChecklist);
    on<SubmitNominationChecklist>(_submitNominationChecklist);
    on<SelectTankChecklistAnswer>(_selectTankChecklistAnswer);
    on<TankCheckListFetchQuestions>(_tankCheckListFetchQuestions);
    on<FetchTankChecklistComments>(_fetchTankChecklistComments);
    on<SaveTankQuestionsComments>(_saveTankQuestionsComments);
    on<SelectTankStatusFilter>(_selectTankStatusFilter);
    on<SelectTankTitleFilter>(_selectTankTitleFilter);
    on<ApplyTankFilter>(_applyTankFilter);
    on<ClearTankFilter>(_clearTankFilter);
  }

  List answerList = [];
  List<TankQuestionList>? questionList;
  Map allDataForChecklistMap = {};
  Map filterMap = {};
  int tabIndex = 0;
  bool hasReachedMax = false;
  List<TankDatum> tankDatum = [];

  Future<FutureOr<void>> _fetchTankManagementList(
      FetchTankManagementList event, Emitter<TankManagementState> emit) async {
    emit(TankManagementListFetching());
    try {
      String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      String? userId = await _customerCache.getUserId(CacheKeys.userId) ?? '';
      if (event.isFromHome) {
        FetchTankManagementListModel fetchTankManagementListModel =
            await _tankManagementRepository.fetchTankManagementList(
                event.pageNo, hashCode, '', userId);
        tankDatum.addAll(fetchTankManagementListModel.data);
        hasReachedMax = fetchTankManagementListModel.data.isEmpty;
        emit(TankManagementListFetched(
            fetchTankManagementListModel: fetchTankManagementListModel,
            tankDatum: tankDatum,
            filterMap: {}));
      } else {
        FetchTankManagementListModel fetchTankManagementListModel =
            await _tankManagementRepository.fetchTankManagementList(
                event.pageNo, hashCode, jsonEncode(filterMap), userId);
        tankDatum.addAll(fetchTankManagementListModel.data);
        hasReachedMax = fetchTankManagementListModel.data.isEmpty;
        emit(TankManagementListFetched(
            fetchTankManagementListModel: fetchTankManagementListModel,
            tankDatum: tankDatum,
            filterMap: filterMap));
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
          await _tankManagementRepository.fetchTankManagementDetails(
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

  Future<FutureOr<void>> _fetchTmsNominationData(
      FetchTmsNominationData event, Emitter<TankManagementState> emit) async {
    emit(TmsNominationDataFetching());
    try {
      String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';

      FetchTmsNominationDataModel fetchTmsNominationDataModel =
          await _tankManagementRepository.fetchTmsNominationData(
              event.nominationId, hashCode);
      if (fetchTmsNominationDataModel.status == 200) {
        emit(TmsNominationDataFetched(
            fetchTmsNominationDataModel: fetchTmsNominationDataModel));
      } else {
        emit(TmsNominationDataNotFetched(
            errorMessage: fetchTmsNominationDataModel.message));
      }
    } catch (e) {
      emit(TmsNominationDataNotFetched(errorMessage: e.toString()));
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
          await _tankManagementRepository.fetchNominationChecklist(
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
      List submitList = [];
      List validateSubmitList = [];
      String id = '';
      String answer = '';
      String isMandatory = '';
      for (int j = 0; j < event.editQuestionsList.length; j++) {
        id = event.editQuestionsList[j]["questionid"];
        answer = event.editQuestionsList[j]["answer"];
        isMandatory = event.editQuestionsList[j]["ismandatory"].toString();
        submitList.add({"questionid": id, "answer": answer});
        validateSubmitList.add({"ismandatory": isMandatory, "answer": answer});
      }
      if (event.isDraft == true) {
        Map tankChecklistMap = {
          "executionid": event.tankChecklistMap['executionId'],
          "userid": await _customerCache.getUserId(CacheKeys.userId),
          "isdraft": (event.isDraft == true) ? "1" : "0",
          "questions": answerList,
          "hashcode": await _customerCache.getHashCode(CacheKeys.hashcode)
        };
        SubmitNominationChecklistModel submitNominationChecklistModel =
            await _tankManagementRepository
                .saveNominationChecklist(tankChecklistMap);
        if (submitNominationChecklistModel.message == '0') {
          emit(NominationChecklistNotSubmitted(
              errorMessage: submitNominationChecklistModel.message));
        } else {
          emit(NominationChecklistSubmitted());
        }
      } else {
        if (validateSubmitList
            .map((e) => e["answer"] == "" && e["ismandatory"] == "1")
            .contains(true)) {
          emit(NominationChecklistNotSubmitted(
              errorMessage:
                  DatabaseUtil.getText('Pleaseanswerthemandatoryquestion')));
        } else {
          Map tankChecklistMap = {
            "executionid": event.tankChecklistMap['executionId'],
            "userid": await _customerCache.getUserId(CacheKeys.userId),
            "isdraft": (event.isDraft == true) ? "1" : "0",
            "questions": answerList,
            "hashcode": await _customerCache.getHashCode(CacheKeys.hashcode)
          };
          SubmitNominationChecklistModel submitNominationChecklistModel =
              await _tankManagementRepository
                  .saveNominationChecklist(tankChecklistMap);
          if (submitNominationChecklistModel.message == '0') {
            emit(NominationChecklistNotSubmitted(
                errorMessage: submitNominationChecklistModel.message));
          } else {
            emit(NominationChecklistSubmitted());
          }
        }
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
          await _tankManagementRepository.fetchTankQuestionsList(
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
          add(SelectTankChecklistAnswer(
              multiSelectIdList: [],
              multiSelectItem: '',
              multiSelectName: '',
              multiSelectNameList: []));
          emit(TankChecklistQuestionsListFetched(
              fetchTankChecklistQuestionModel: fetchTankChecklistQuestionModel,
              answerList: answerList,
              allChecklistDataMap: allDataForChecklistMap,
              questionList: questionList!));
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

  Future<FutureOr<void>> _fetchTankChecklistComments(
      FetchTankChecklistComments event,
      Emitter<TankManagementState> emit) async {
    emit(TankCheckListCommentsFetching());
    try {
      allDataForChecklistMap["questionResponseId"] = event.questionId;
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      String clientId = (await _customerCache.getClientId(CacheKeys.clientId))!;
      FetchTankChecklistCommentsModel fetchTankChecklistCommentsModel =
          await _tankManagementRepository.fetchTankChecklistComments(
              event.questionId, hashCode);
      if (fetchTankChecklistCommentsModel.status == 200) {
        emit(TankCheckListCommentsFetched(
            fetchTankChecklistCommentsModel: fetchTankChecklistCommentsModel,
            clientId: clientId));
      } else {
        emit(TankCheckListCommentsNotFetched(
            errorMessage: fetchTankChecklistCommentsModel.message!));
      }
    } catch (e) {
      emit(TankCheckListCommentsNotFetched(errorMessage: e.toString()));
    }
  }

  Future<FutureOr<void>> _saveTankQuestionsComments(
      SaveTankQuestionsComments event,
      Emitter<TankManagementState> emit) async {
    emit(TankQuestionCommentsSaving());
    try {
      Map tankCommentsMap = {
        "id": "",
        "queresponseid": allDataForChecklistMap["questionResponseId"],
        "comments": event.tankCommentsMap["comments"],
        "filenames": event.tankCommentsMap["filenames"],
        "hashcode": await _customerCache.getHashCode(CacheKeys.hashcode)
      };
      SaveTankQuestionCommentsModel saveTankQuestionCommentsModel =
          await _tankManagementRepository
              .saveTankQuestionComments(tankCommentsMap);
      if (saveTankQuestionCommentsModel.message == '1') {
        emit(TankQuestionCommentsSaved());
      } else {
        emit(TankQuestionCommentsNotSaved(
            errorMessage: saveTankQuestionCommentsModel.message));
      }
    } catch (e) {
      emit(TankQuestionCommentsNotSaved(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _selectTankStatusFilter(
      SelectTankStatusFilter event, Emitter<TankManagementState> emit) {
    emit(TankStatusFilterSelected(
        selected: event.selected, selectedIndex: event.selectedIndex));
  }

  FutureOr<void> _selectTankTitleFilter(
      SelectTankTitleFilter event, Emitter<TankManagementState> emit) {
    emit(TankTitleFilterSelected(
        selected: event.selected, selectedIndex: event.selectedIndex));
  }

  FutureOr<void> _applyTankFilter(
      ApplyTankFilter event, Emitter<TankManagementState> emit) {
    filterMap = event.tankFilterMap;
  }

  FutureOr<void> _clearTankFilter(
      ClearTankFilter event, Emitter<TankManagementState> emit) {
    filterMap = {};
  }
}
