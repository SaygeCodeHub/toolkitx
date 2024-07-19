import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/data/cache/cache_keys.dart';
import 'package:toolkit/data/cache/customer_cache.dart';
import 'package:toolkit/data/models/tankManagement/fetch_nomination_checklist_model.dart';
import 'package:toolkit/data/models/tankManagement/fetch_tank_management_details_model.dart';
import 'package:toolkit/data/models/tankManagement/fetch_tank_management_list_module.dart';
import 'package:toolkit/di/app_module.dart';
import 'package:toolkit/repositories/tankManagement/tank_management_repository.dart';

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
  }

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
}
