import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/data/models/equipmentTraceability/fetch_search_equipment_model.dart';
import 'package:toolkit/repositories/equipmentTraceability/equipment_traceability_repo.dart';

import '../../data/cache/cache_keys.dart';
import '../../data/cache/customer_cache.dart';
import '../../di/app_module.dart';

part 'equipment_traceability_event.dart';

part 'equipment_traceability_state.dart';

class EquipmentTraceabilityBloc
    extends Bloc<EquipmentTraceabilityEvent, EquipmentTraceabilityState> {
  final EquipmentTraceabilityRepo _equipmentTraceabilityRepo =
      getIt<EquipmentTraceabilityRepo>();
  final CustomerCache _customerCache = getIt<CustomerCache>();

  EquipmentTraceabilityBloc() : super(EquipmentTraceabilityInitial()) {
    on<FetchSearchEquipmentList>(_fetchSearchEquipmentList);
  }

  Future<FutureOr<void>> _fetchSearchEquipmentList(
      FetchSearchEquipmentList event,
      Emitter<EquipmentTraceabilityState> emit) async {
    emit(SearchEquipmentListFetching());
    try {
      String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      String? userId = await _customerCache.getUserId(CacheKeys.userId) ?? '';
      FetchSearchEquipmentModel fetchSearchEquipmentModel =
          await _equipmentTraceabilityRepo.fetchSearchEquipment(
              event.pageNo, hashCode, userId, '');
      if (fetchSearchEquipmentModel.status == 200) {
        emit(SearchEquipmentListFetched(
            fetchSearchEquipmentModel: fetchSearchEquipmentModel));
      } else {
        emit(SearchEquipmentListNotFetched(
            errorMessage: fetchSearchEquipmentModel.message));
      }
    } catch (e) {
      emit(SearchEquipmentListNotFetched(errorMessage: e.toString()));
    }
  }
}
