import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/data/models/loto/add_loto_comment_model.dart';
import 'package:toolkit/data/models/loto/assign_workforce_for_remove_model.dart';
import 'package:toolkit/data/models/loto/accept_loto_model.dart';
import 'package:toolkit/data/models/loto/apply_loto_model.dart';
import 'package:toolkit/data/models/loto/loto_details_model.dart';
import 'package:toolkit/data/models/loto/remove_loto_model.dart';
import 'package:toolkit/data/models/loto/start_loto_model.dart';
import 'package:toolkit/data/models/loto/start_remove_loto_model.dart';
import 'package:toolkit/repositories/loto/loto_repository.dart';
import '../../../data/cache/cache_keys.dart';
import '../../../data/cache/customer_cache.dart';
import '../../../data/models/loto/fetch_loto_assign_team_model.dart';
import '../../../data/models/loto/fetch_loto_assign_workforce_model.dart';
import '../../../data/models/loto/save_assign_workforce_model.dart';
import '../../../di/app_module.dart';
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
  String isRemove = '';
  String isWorkforceRemove = '';
  String isStartRemove = '0';
  int lotoTabIndex = 0;
  bool lotoListReachedMax = false;

  LotoDetailsBloc() : super(LotoDetailsInitial()) {
    on<FetchLotoDetails>(_fetchLotoDetails);
    on<RemoveAssignWorkforce>(_removeAssignWorkforce);
    on<FetchLotoAssignWorkforce>(_fetchLotoAssignWorkforce);
    on<SaveLotoAssignWorkForce>(_saveLotoAssignWorkforce);
    on<FetchLotoAssignTeam>(_fetchLotoAssignTeam);
    on<StartLotoEvent>(_startLotoEvent);
    on<StartRemoveLotoEvent>(_startRemoveLotoEvent);
    on<ApplyLotoEvent>(_applyLotoEvent);
    on<AcceptLotoEvent>(_acceptLotoEvent);
    on<RemoveLotoEvent>(_removeLotoEvent);
    on<AddLotoComment>(_addLotoComment);
  }

  Future<FutureOr<void>> _fetchLotoDetails(
      FetchLotoDetails event, Emitter<LotoDetailsState> emit) async {
    emit(LotoDetailsFetching());
    try {
      lotoTabIndex = event.lotTabIndex;
      List popUpMenuItems = [
        DatabaseUtil.getText('Start'),
        DatabaseUtil.getText('StartRemoveLotoButton'),
        DatabaseUtil.getText('RemoveLoto'),
        DatabaseUtil.getText('Apply'),
        DatabaseUtil.getText('ApproveButton'),
        DatabaseUtil.getText('assign_workforce'),
        DatabaseUtil.getText('assign _workforce_for_remove_loto'),
        DatabaseUtil.getText('AddComment'),
        DatabaseUtil.getText('UploadPhotos'),
        DatabaseUtil.getText('Cancel'),
      ];
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      FetchLotoDetailsModel fetchLotoDetailsModel =
          await _lotoRepository.fetchLotoDetailsRepo(hashCode!, lotoId);
      isWorkforceRemove = fetchLotoDetailsModel.data.assignwfremove;
      isRemove = fetchLotoDetailsModel.data.isremove;
      isStartRemove = fetchLotoDetailsModel.data.isstartremove;
      if (fetchLotoDetailsModel.status == 200) {
        emit(LotoDetailsFetched(
            fetchLotoDetailsModel: fetchLotoDetailsModel,
            lotoPopUpMenu: popUpMenuItems,
            showPopUpMenu: true));
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
      if (!lotoListReachedMax) {
        FetchLotoAssignWorkforceModel fetchLotoAssignWorkforceModel =
            await _lotoRepository.fetchLotoAssignWorkforceModel(
                hashCode!, lotoId, event.pageNo, event.name, event.isRemove);
        assignWorkforceDatum.addAll(fetchLotoAssignWorkforceModel.data);
        lotoListReachedMax = fetchLotoAssignWorkforceModel.data.isEmpty;
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
      }
      {
        emit(LotoAssignWorkforceNotSaved(
            getError: saveLotoAssignWorkforceModel.message));
      }
    } catch (e) {
      emit(LotoAssignWorkforceNotSaved(getError: e.toString()));
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
      if (fetchLotoAssignTeamModel.status == 200) {
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
        "questions": []
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
      }
    } catch (e) {
      emit(LotoCommentNotAdded(getError: e.toString()));
    }
  }
}
