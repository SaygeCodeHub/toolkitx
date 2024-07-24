import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/data/cache/cache_keys.dart';
import 'package:toolkit/data/cache/customer_cache.dart';
import 'package:toolkit/data/models/tankManagement/fetch_tank_management_details_model.dart';
import 'package:toolkit/data/models/tankManagement/fetch_tank_management_list_module.dart';
import 'package:toolkit/data/models/tankManagement/fetch_tms_nomination_data_model.dart';
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
    on<FetchTmsNominationData>(_fetchTmsNominationData);
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

  Future<FutureOr<void>> _fetchTmsNominationData(
      FetchTmsNominationData event, Emitter<TankManagementState> emit) async {
    emit(TmsNominationDataFetching());
    try {
      String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';

      FetchTmsNominationDataModel fetchTmsNominationDataModel =
          await _managementRepository.fetchTmsNominationData(
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
}
