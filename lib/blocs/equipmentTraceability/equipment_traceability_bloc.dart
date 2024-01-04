import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/data/models/equipmentTraceability/fetch_search_equipment_model.dart';
import 'package:toolkit/repositories/equipmentTraceability/equipment_traceability_repo.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';

import '../../data/cache/cache_keys.dart';
import '../../data/cache/customer_cache.dart';
import '../../data/models/equipmentTraceability/fetch_search_equipment_details_model.dart';
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
    on<FetchSearchEquipmentDetails>(_fetchSearchEquipmentDetails);
    on<ApplySearchEquipmentFilter>(_applySearchEquipmentFilter);
    on<ClearSearchEquipmentFilter>(_clearSearchEquipmentFilter);
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

  FutureOr<void> _fetchSearchEquipmentDetails(FetchSearchEquipmentDetails event,
      Emitter<EquipmentTraceabilityState> emit) async {
    emit(SearchEquipmentDetailsFetching());
    List popUpMenuItems = [
      StringConstants.kTransfer,
      StringConstants.kSetParameter,
      StringConstants.kUploadMedia,
      StringConstants.kSetLocation,
      DatabaseUtil.getText('Cancel'),
    ];
    try {
      String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      String? userId = await _customerCache.getUserId(CacheKeys.userId) ?? '';
      String? clientId =
          await _customerCache.getClientId(CacheKeys.clientId) ?? '';
      FetchSearchEquipmentDetailsModel fetchSearchEquipmentDetailsModel =
          await _equipmentTraceabilityRepo.fetchDetailsEquipment(
              hashCode, event.equipmentId, userId);
      if (fetchSearchEquipmentDetailsModel.status == 200) {
        emit(SearchEquipmentDetailsFetched(
          fetchSearchEquipmentDetailsModel: fetchSearchEquipmentDetailsModel,
          popUpMenuItems: popUpMenuItems,
          showPopMenu: fetchSearchEquipmentDetailsModel.data.cantransfer == "1"
              ? true
              : false,
          clientId: clientId,
        ));
      } else {
        emit(SearchEquipmentDetailsNotFetched(
            errorMessage: fetchSearchEquipmentDetailsModel.message));
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
}
