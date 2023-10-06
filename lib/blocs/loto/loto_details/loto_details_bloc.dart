import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/data/models/loto/loto_details_model.dart';
import 'package:toolkit/data/models/loto/start_loto_model.dart';
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
  String isStartRemove = '';
  int lotoTabIndex = 0;
  bool lotoListReachedMax = false;

  LotoDetailsBloc() : super(LotoDetailsInitial()) {
    on<FetchLotoDetails>(_fetchLotoDetails);
    on<FetchLotoAssignWorkforce>(_fetchLotoAssignWorkforce);
    on<SaveLotoAssignWorkForce>(_saveLotoAssignWorkforce);
    on<FetchLotoAssignTeam>(_fetchLotoAssignTeam);
    on<StartLotoEvent>(_startLotoEvent);
  }

  Future<FutureOr<void>> _fetchLotoDetails(
      FetchLotoDetails event, Emitter<LotoDetailsState> emit) async {
    emit(LotoDetailsFetching());
    try {
      lotoTabIndex = event.lotTabIndex;
      List popUpMenuItems = [
        DatabaseUtil.getText('Start'),
        DatabaseUtil.getText('assign_workforce'),
        DatabaseUtil.getText('assign_team'),
        DatabaseUtil.getText('AddComment'),
        DatabaseUtil.getText('UploadPhotos'),
        DatabaseUtil.getText('Cancel'),
      ];
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      FetchLotoDetailsModel fetchLotoDetailsModel =
          await _lotoRepository.fetchLotoDetailsRepo(hashCode!, lotoId);
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
      }
    } catch (e) {
      emit(LotoNotStarted(getError: e.toString()));
    }
  }
}
