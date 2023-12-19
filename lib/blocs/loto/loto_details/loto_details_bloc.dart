import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/data/models/loto/add_loto_comment_model.dart';
import 'package:toolkit/data/models/loto/assign_workforce_for_remove_model.dart';
import 'package:toolkit/data/models/loto/accept_loto_model.dart';
import 'package:toolkit/data/models/loto/apply_loto_model.dart';
import 'package:toolkit/data/models/loto/fetch_loto_checklist_questions_model.dart';
import 'package:toolkit/data/models/loto/fetch_assigned_checklists.dart';
import 'package:toolkit/data/models/loto/loto_details_model.dart';
import 'package:toolkit/data/models/loto/loto_upload_photos_model.dart';
import 'package:toolkit/data/models/loto/remove_loto_model.dart';
import 'package:toolkit/data/models/loto/save_loto_checklist_model.dart';
import 'package:toolkit/data/models/loto/start_loto_model.dart';
import 'package:toolkit/data/models/loto/start_remove_loto_model.dart';
import 'package:toolkit/repositories/loto/loto_repository.dart';
import '../../../data/cache/cache_keys.dart';
import '../../../data/cache/customer_cache.dart';
import '../../../data/models/loto/fetch_loto_assign_team_model.dart';
import '../../../data/models/loto/fetch_loto_assign_workforce_model.dart';
import '../../../data/models/loto/save_assign_workforce_model.dart';
import '../../../data/models/loto/save_loto_assign_team_model.dart';
import '../../../di/app_module.dart';
import '../../../screens/loto/loto_assign_workfoce_screen.dart';
import '../../../screens/loto/loto_assign_team_screen.dart';
import '../../../utils/database_utils.dart';

part 'loto_details_event.dart';
part 'loto_details_state.dart';

class LotoDetailsBloc extends Bloc<LotoDetailsEvent, LotoDetailsState> {
  final LotoRepository _lotoRepository = getIt<LotoRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  LotoDetailsState get initialState => LotoDetailsInitial();
  List<LotoWorkforceDatum> assignWorkforceDatum = [];
  List<LotoData> lotoData = [];
  String lotoId = '';
  String lotoWorkforceName = '';
  int pageNo = 1;
  String isRemove = '0';
  String isWorkforceRemove = '';
  String checklistId = '';
  String isStartRemove = '0';
  int lotoTabIndex = 0;
  bool lotoWorkforceReachedMax = false;
  static List popUpMenuItemsList = [];

  List answerList = [];
  List<QuestionList>? questionList;
  Map allDataForChecklistMap = {};

  LotoDetailsBloc() : super(LotoDetailsInitial()) {
    on<FetchLotoDetails>(_fetchLotoDetails);
    on<RemoveAssignWorkforce>(_removeAssignWorkforce);
    on<FetchLotoAssignWorkforce>(_fetchLotoAssignWorkforce);
    on<SearchLotoAssignWorkForce>(_searchLotoAssignWorkForce);
    on<SaveLotoAssignWorkForce>(_saveLotoAssignWorkforce);
    on<FetchLotoAssignTeam>(_fetchLotoAssignTeam);
    on<SaveLotoAssignTeam>(_saveLotoAssignTeam);
    on<StartLotoEvent>(_startLotoEvent);
    on<StartRemoveLotoEvent>(_startRemoveLotoEvent);
    on<ApplyLotoEvent>(_applyLotoEvent);
    on<AcceptLotoEvent>(_acceptLotoEvent);
    on<RemoveLotoEvent>(_removeLotoEvent);
    on<AddLotoComment>(_addLotoComment);
    on<LotoUploadPhotos>(_lotoUploadPhotos);
    on<FetchLotoChecklistQuestions>(_fetchLotoChecklistQuestions);
    on<SelectAnswer>(_selectAnswer);
    on<SaveLotoChecklist>(_saveLotoChecklist);
    on<FetchLotoAssignedChecklists>(_fetchLotoAssignedChecklists);
  }

  Future<FutureOr<void>> _fetchLotoDetails(
      FetchLotoDetails event, Emitter<LotoDetailsState> emit) async {
    emit(LotoDetailsFetching());
    try {
      lotoTabIndex = event.lotTabIndex;
      List popUpMenuItemsList = [
        DatabaseUtil.getText('AddComment'),
        DatabaseUtil.getText('UploadPhotos'),
        DatabaseUtil.getText('Cancel'),
      ];
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? clientId = await _customerCache.getClientId(CacheKeys.clientId);
      FetchLotoDetailsModel fetchLotoDetailsModel =
          await _lotoRepository.fetchLotoDetailsRepo(hashCode!, lotoId);
      if (fetchLotoDetailsModel.data.isstart == '1') {
        popUpMenuItemsList.insert(0, DatabaseUtil.getText('Start'));
      }
      if (fetchLotoDetailsModel.data.isapply == '1') {
        popUpMenuItemsList.insert(1, DatabaseUtil.getText('Apply'));
      }
      if (fetchLotoDetailsModel.data.assignwf == '1') {
        popUpMenuItemsList.insert(1, DatabaseUtil.getText('assign_workforce'));
      }
      if (fetchLotoDetailsModel.data.isstartremove == '1') {
        popUpMenuItemsList.insert(1, DatabaseUtil.getText('RemoveButton'));
      }
      if (fetchLotoDetailsModel.data.assignwf == '1') {
        popUpMenuItemsList.insert(2, DatabaseUtil.getText('assign_team'));
      }
      if (fetchLotoDetailsModel.data.isapprove == '1') {
        popUpMenuItemsList.insert(1, DatabaseUtil.getText('ApproveButton'));
      }
      if (fetchLotoDetailsModel.data.isreject == '1') {
        popUpMenuItemsList.insert(1, DatabaseUtil.getText('RejectButton'));
      }
      if (fetchLotoDetailsModel.data.assignwfremove == '1') {
        popUpMenuItemsList.insert(
            1, DatabaseUtil.getText('assign _workforce_for_remove_loto'));
      }
      if (fetchLotoDetailsModel.data.assignwfremove == '1') {
        popUpMenuItemsList.insert(
            2, DatabaseUtil.getText('assign_team_for_remove_loto'));
      }

      isWorkforceRemove = fetchLotoDetailsModel.data.assignwfremove;
      isRemove = fetchLotoDetailsModel.data.isremove;
      isStartRemove = fetchLotoDetailsModel.data.isstartremove;
      if (fetchLotoDetailsModel.status == 200) {
        emit(LotoDetailsFetched(
          fetchLotoDetailsModel: fetchLotoDetailsModel,
          showPopUpMenu: true,
          lotoPopUpMenuList: popUpMenuItemsList,
          clientId: clientId ?? '',
        ));
      }
    } catch (e) {
      emit(LotoDetailsNotFetched(getError: e.toString()));
    }
  }

  Future<FutureOr<void>> _fetchLotoAssignWorkforce(
      FetchLotoAssignWorkforce event, Emitter<LotoDetailsState> emit) async {
    emit(LotoAssignWorkforceFetching());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      if (!lotoWorkforceReachedMax) {
        FetchLotoAssignWorkforceModel fetchLotoAssignWorkforceModel =
            await _lotoRepository.fetchLotoAssignWorkforceModel(hashCode!,
                lotoId, event.pageNo, event.workforceName, event.isRemove);
        pageNo = event.pageNo;
        lotoWorkforceName = event.workforceName;
        assignWorkforceDatum.addAll(fetchLotoAssignWorkforceModel.data);
        lotoWorkforceReachedMax = fetchLotoAssignWorkforceModel.data.isEmpty;
        emit(LotoAssignWorkforceFetched(
            fetchLotoAssignWorkforceModel: fetchLotoAssignWorkforceModel));
      }
    } catch (e) {
      emit(LotoAssignWorkforceError(getError: e.toString()));
    }
  }

  Future<FutureOr<void>> _saveLotoAssignWorkforce(
      SaveLotoAssignWorkForce event, Emitter<LotoDetailsState> emit) async {
    emit(LotoAssignWorkforceSaving());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      Map lotoAssignWorkforceMap = {
        "hashcode": hashCode,
        "lotoid": lotoId,
        "peopleid": event.peopleId,
        "userid": userId
      };
      SaveLotoAssignWorkforceModel saveLotoAssignWorkforceModel =
          await _lotoRepository
              .saveLotoAssignWorkforceModel(lotoAssignWorkforceMap);
      if (saveLotoAssignWorkforceModel.status == 200) {
        emit(LotoAssignWorkforceSaved(
            saveLotoAssignWorkforceModel: saveLotoAssignWorkforceModel));
      } else {
        emit(LotoAssignWorkforceNotSaved(
            getError: saveLotoAssignWorkforceModel.message));
      }
    } catch (e) {
      emit(LotoAssignWorkforceNotSaved(getError: e.toString()));
    }
  }

  Future<FutureOr<void>> _saveLotoAssignTeam(
      SaveLotoAssignTeam event, Emitter<LotoDetailsState> emit) async {
    emit(LotoAssignTeamSaving());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      Map lotoAssignTeamMap = {
        "hashcode": hashCode,
        "lotoid": lotoId,
        "teamid": event.teamId,
        "userid": userId
      };

      SaveLotoAssignTeamModel saveLotoAssignTeamModel =
          await _lotoRepository.saveLotoAssignTeam(lotoAssignTeamMap);
      if (saveLotoAssignTeamModel.status == 200) {
        emit(LotoAssignTeamSaved(
            saveLotoAssignTeamModel: saveLotoAssignTeamModel));
      }
    } catch (e) {
      emit(LotoAssignTeamNotSaved(getError: e.toString()));
    }
  }

  Future<FutureOr<void>> _fetchLotoAssignTeam(
      FetchLotoAssignTeam event, Emitter<LotoDetailsState> emit) async {
    emit(LotoAssignTeamFetching());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      FetchLotoAssignTeamModel fetchLotoAssignTeamModel =
          await _lotoRepository.fetchLotoAssignTeam(
              hashCode!, lotoId, event.pageNo, event.name, event.isRemove);
      if (fetchLotoAssignTeamModel.status == 200 ||
          fetchLotoAssignTeamModel.status == 204) {
        LotoAssignTeamScreen.hasReachedMax =
            fetchLotoAssignTeamModel.data.isEmpty;
        LotoAssignTeamScreen.data.addAll(fetchLotoAssignTeamModel.data);
        emit(LotoAssignTeamFetched(
            fetchLotoAssignTeamModel: fetchLotoAssignTeamModel));
      }
    } catch (e) {
      emit(LotoAssignTeamError(getError: e.toString()));
    }
  }

  Future<FutureOr<void>> _startLotoEvent(
      StartLotoEvent event, Emitter<LotoDetailsState> emit) async {
    emit(LotoStarting());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);

      Map startLotoMap = {
        "id": lotoId,
        "userid": userId,
        "hashcode": hashCode,
        "isRemove": isStartRemove,
        "questions": [],
        "checklistid": event.checklistId
      };
      StartLotoModel startLotoModel =
          await _lotoRepository.startLotoRepo(startLotoMap);
      if (startLotoModel.status == 200) {
        emit(LotoStarted(startLotoModel: startLotoModel));
      } else {
        emit(LotoNotStarted(getError: startLotoModel.message));
      }
    } catch (e) {
      emit(LotoNotStarted(getError: e.toString()));
    }
  }

  Future<FutureOr<void>> _startRemoveLotoEvent(
      StartRemoveLotoEvent event, Emitter<LotoDetailsState> emit) async {
    emit(LotoRemoveStarting());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);

      Map startRemoveLotoMap = {
        "id": lotoId,
        "userid": userId,
        "hashcode": hashCode,
        "isRemove": isStartRemove,
        "questions": []
      };
      StartRemoveLotoModel startRemoveLotoModel =
          await _lotoRepository.startRemoveLotoRepo(startRemoveLotoMap);
      if (startRemoveLotoModel.status == 200) {
        emit(LotoRemoveStarted(startRemoveLotoModel: startRemoveLotoModel));
      } else {
        emit(LotoRemoveNotStarted(getError: startRemoveLotoModel.message));
      }
    } catch (e) {
      emit(LotoRemoveNotStarted(getError: e.toString()));
    }
  }

  Future<FutureOr<void>> _applyLotoEvent(
      ApplyLotoEvent event, Emitter<LotoDetailsState> emit) async {
    emit(LotoApplying());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);

      Map applyLotoMap = {
        "id": lotoId,
        "userid": userId,
        "hashcode": hashCode,
      };
      ApplyLotoModel applyLotoModel =
          await _lotoRepository.applyLotoRepo(applyLotoMap);
      if (applyLotoModel.status == 200) {
        emit(LotoApplied(applyLotoModel: applyLotoModel));
      } else {
        emit(LotoNotApplied(getError: applyLotoModel.message));
      }
    } catch (e) {
      emit(LotoNotApplied(getError: e.toString()));
    }
  }

  Future<FutureOr<void>> _acceptLotoEvent(
      AcceptLotoEvent event, Emitter<LotoDetailsState> emit) async {
    emit(LotoAccepting());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);

      Map acceptLotoMap = {
        "id": lotoId,
        "userid": userId,
        "hashcode": hashCode,
      };
      AcceptLotoModel acceptLotoModel =
          await _lotoRepository.acceptLotoRepo(acceptLotoMap);
      if (acceptLotoModel.status == 200) {
        emit(LotoAccepted(acceptLotoModel: acceptLotoModel));
      } else {
        emit(LotoNotAccepted(getError: acceptLotoModel.message));
      }
    } catch (e) {
      emit(LotoNotAccepted(getError: e.toString()));
    }
  }

  Future<FutureOr<void>> _removeAssignWorkforce(
      RemoveAssignWorkforce event, Emitter<LotoDetailsState> emit) async {
    emit(AssignWorkforceRemoving());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      Map workforceRemoveMap = {
        "hashcode": hashCode,
        "lotoid": lotoId,
        "peopleid": event.peopleId,
        "userid": userId
      };
      AssignWorkForceForRemoveModel assignWorkForceForRemoveModel =
          await _lotoRepository.assignWorkforceRemove(workforceRemoveMap);
      if (assignWorkForceForRemoveModel.status == 200) {
        emit(AssignWorkforceRemoved(
            assignWorkForceForRemoveModel: assignWorkForceForRemoveModel));
      } else {
        emit(AssignWorkforceRemoveError(
            getError: assignWorkForceForRemoveModel.message));
      }
    } catch (e) {
      emit(AssignWorkforceRemoveError(getError: e.toString()));
    }
  }

  Future<FutureOr<void>> _removeLotoEvent(
      RemoveLotoEvent event, Emitter<LotoDetailsState> emit) async {
    emit(LotoRemoving());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);

      Map removeLotoMap = {
        "id": lotoId,
        "userid": userId,
        "hashcode": hashCode,
      };
      RemoveLotoModel removeLotoModel =
          await _lotoRepository.removeLotoRepo(removeLotoMap);
      if (removeLotoModel.status == 200) {
        emit(LotoRemoved(removeLotoModel: removeLotoModel));
      } else {
        emit(LotoNotRemoved(getError: removeLotoModel.message));
      }
    } catch (e) {
      emit(LotoNotRemoved(getError: e.toString()));
    }
  }

  Future<FutureOr<void>> _addLotoComment(
      AddLotoComment event, Emitter<LotoDetailsState> emit) async {
    emit(LotoCommentAdding());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      Map addLotoCommentMap = {
        "comments": event.comment,
        "lotoid": lotoId,
        "userid": userId,
        "hashcode": hashCode,
      };
      AddLotoCommentModel addLotoCommentModel =
          await _lotoRepository.addLotoCommentRepo(addLotoCommentMap);
      if (addLotoCommentModel.status == 200) {
        emit(LotoCommentAdded(addLotoCommentModel: addLotoCommentModel));
      } else {
        emit(LotoCommentNotAdded(getError: addLotoCommentModel.message));
      }
    } catch (e) {
      emit(LotoCommentNotAdded(getError: e.toString()));
    }
  }

  Future<FutureOr<void>> _lotoUploadPhotos(
      LotoUploadPhotos event, Emitter<LotoDetailsState> emit) async {
    emit(LotoPhotosUploading());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      Map lotoUploadPhotosMap = {
        "lotoid": lotoId,
        "filenames": event.filename,
        "userid": userId,
        "hashcode": hashCode
      };
      LotoUploadPhotosModel lotoUploadPhotosModel =
          await _lotoRepository.lotoUploadPhotosRepo(lotoUploadPhotosMap);
      if (lotoUploadPhotosModel.status == 200) {
        emit(LotoPhotosUploaded(lotoUploadPhotosModel: lotoUploadPhotosModel));
      } else {
        emit(LotoPhotosNotUploaded(getError: lotoUploadPhotosModel.message));
      }
    } catch (e) {
      emit(LotoPhotosNotUploaded(getError: e.toString()));
    }
  }

  FutureOr<void> _searchLotoAssignWorkForce(
      SearchLotoAssignWorkForce event, Emitter<LotoDetailsState> emit) {
    if (event.isWorkforceSearched == true) {
      emit(LotoAssignWorkforceSearched(
          isWorkforceSearched: event.isWorkforceSearched));
      add(FetchLotoAssignWorkforce(
          pageNo: 1, isRemove: isRemove, workforceName: lotoWorkforceName));
    } else {
      emit(LotoAssignWorkforceSearched(
          isWorkforceSearched: event.isWorkforceSearched));
      LotoAssignWorkforceScreen.workforceNameController.clear();
      add(FetchLotoAssignWorkforce(
          pageNo: 1, isRemove: isRemove, workforceName: ''));
    }
  }

  Future<FutureOr<void>> _fetchLotoChecklistQuestions(
      FetchLotoChecklistQuestions event, Emitter<LotoDetailsState> emit) async {
    emit(LotoChecklistQuestionsFetching());
    try {
      String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      FetchLotoChecklistQuestionsModel fetchLotoChecklistQuestionsModel =
          await _lotoRepository.fetchLotoChecklistQuestions(
              hashCode, lotoId, '', isRemove);
      if (fetchLotoChecklistQuestionsModel.status == 200) {
        emit(LotoChecklistQuestionsFetched(
            fetchLotoChecklistQuestionsModel: fetchLotoChecklistQuestionsModel,
            answerList: answerList));
      } else {
        emit(LotoChecklistQuestionsNotFetched(
            errorMessage: fetchLotoChecklistQuestionsModel.message!));
      }
    } catch (e) {
      emit(LotoChecklistQuestionsNotFetched(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _selectAnswer(
      SelectAnswer event, Emitter<LotoDetailsState> emit) {
    emit(AnswerSelected(id: event.id, text: event.text));
  }

  Future<FutureOr<void>> _saveLotoChecklist(
      SaveLotoChecklist event, Emitter<LotoDetailsState> emit) async {
    emit(LotoChecklistSaving());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      Map saveLotoChecklistMap = {
        "id": lotoId,
        "userid": userId,
        "hashcode": hashCode,
        "isremove": isRemove,
        "questions": answerList,
        "checklistid": event.saveLotoChecklistMap['checklistid']
      };
      SaveLotoChecklistModel saveLotoChecklistModel =
          await _lotoRepository.saveLotoChecklist(saveLotoChecklistMap);
      emit(LotoChecklistSaved(saveLotoChecklistModel: saveLotoChecklistModel));
    } catch (e) {
      emit(LotoChecklistNotSaved(errorMessage: e.toString()));
    }
  }

  Future<FutureOr<void>> _fetchLotoAssignedChecklists(
      FetchLotoAssignedChecklists event, Emitter<LotoDetailsState> emit) async {
    String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
    emit(LotoAssignedChecklistFetching());
    try{
      FetchLotoAssignedChecklistModel fetchLotoAssignedChecklistModel = await _lotoRepository.fetchLotoAssignedChecklist(hashCode, lotoId, event.isRemove);
      if(fetchLotoAssignedChecklistModel.status == 200){
        emit(LotoAssignedChecklistFetched(fetchLotoAssignedChecklistModel: fetchLotoAssignedChecklistModel));
      }else{
        emit(LotoAssignedChecklistNotFetched(errorMessage: fetchLotoAssignedChecklistModel.message!));
      }
    }catch(e){
      emit(LotoAssignedChecklistNotFetched(errorMessage: e.toString()));
    }
  }
}
