import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/data/cache/cache_keys.dart';
import 'package:toolkit/data/cache/customer_cache.dart';
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
  }

  Map filterMap = {};

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
        emit(TankManagementNotFetched(
            errorMessage: fetchTankManagementListModel.message));
      }
    } catch (e) {
      emit(TankManagementNotFetched(errorMessage: e.toString()));
    }
  }
}
