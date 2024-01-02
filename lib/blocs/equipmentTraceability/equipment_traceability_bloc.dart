import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/data/models/equipmentTraceability/fetch_equipment_set_parameter_model.dart';
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
    on<ApplySearchEquipmentFilter>(_applySearchEquipmentFilter);
    on<ClearSearchEquipmentFilter>(_clearSearchEquipmentFilter);
    on<FetchEquipmentSetParameter>(_fetchEquipmentSetParameter);
  }

  Map filters = {};
  bool hasReachedMax = false;
  List<SearchEquipmentDatum> searchEquipmentDatum = [];

  FutureOr<void> _fetchSearchEquipmentList(FetchSearchEquipmentList event,
      Emitter<EquipmentTraceabilityState> emit) async {
    emit(SearchEquipmentListFetching());
    try {
      String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      String? userId = await _customerCache.getUserId(CacheKeys.userId) ?? '';
      if (event.isFromHome) {
        FetchSearchEquipmentModel fetchSearchEquipmentModel =
            await _equipmentTraceabilityRepo.fetchSearchEquipment(
                event.pageNo, hashCode, userId, '{}');
        searchEquipmentDatum.addAll(fetchSearchEquipmentModel.data);
        hasReachedMax = fetchSearchEquipmentModel.data.isEmpty;
        emit(SearchEquipmentListFetched(
            data: searchEquipmentDatum, filtersMap: {}));
      } else {
        FetchSearchEquipmentModel fetchSearchEquipmentModel =
            await _equipmentTraceabilityRepo.fetchSearchEquipment(
                event.pageNo, hashCode, userId, jsonEncode(filters));
        searchEquipmentDatum.addAll(fetchSearchEquipmentModel.data);
        hasReachedMax = fetchSearchEquipmentModel.data.isEmpty;
        emit(SearchEquipmentListFetched(
            data: searchEquipmentDatum, filtersMap: filters));
      }
    } catch (e) {
      emit(SearchEquipmentListNotFetched(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _applySearchEquipmentFilter(ApplySearchEquipmentFilter event,
      Emitter<EquipmentTraceabilityState> emit) {
    filters = event.searchEquipmentFilterMap;
  }

  FutureOr<void> _clearSearchEquipmentFilter(ClearSearchEquipmentFilter event,
      Emitter<EquipmentTraceabilityState> emit) {
    filters = {};
  }


  Future<FutureOr<void>> _fetchEquipmentSetParameter(FetchEquipmentSetParameter event,
      Emitter<EquipmentTraceabilityState> emit)
  async {
    emit(EquipmentSetParameterFetching());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      FetchEquipmentSetParameterModel fetchEquipmentSetParameterModel =
      await _equipmentTraceabilityRepo.fetchEquipmentSetParameter(
          hashCode, event.equipmentId);
      if(fetchEquipmentSetParameterModel.status == 200) {
        emit(EquipmentSetParameterFetched(fetchEquipmentSetParameterModel: fetchEquipmentSetParameterModel));
      } else {
        emit(EquipmentSetParameterNotFetched(errorMessage: fetchEquipmentSetParameterModel.message));
      }
    }
    catch (e) {
      emit(EquipmentSetParameterNotFetched(errorMessage: e.toString()));
    }
  }
}
