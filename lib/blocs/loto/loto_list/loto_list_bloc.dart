import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/cache/cache_keys.dart';
import '../../../data/cache/customer_cache.dart';
import '../../../data/models/loto/loto_list_model.dart';
import '../../../data/models/loto/loto_master_model.dart';
import '../../../di/app_module.dart';
import '../../../repositories/loto/loto_repository.dart';

part 'loto_list_event.dart';

part 'loto_list_state.dart';

class LotoListBloc extends Bloc<LotoListEvent, LotoListState> {
  final LotoRepository _lotoRepository = getIt<LotoRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  Map filters = {};
  List masterData = [];

  LotoListState get initialState => LotoListInitial();
  final List<LotoListDatum> data = [];
  bool hasReachedMax = false;

  LotoListBloc() : super(LotoListInitial()) {
    on<FetchLotoList>(_fetchLotoList);
    on<FetchLotoMaster>(_fetchLotoMaster);
    on<SelectLotoStatusFilter>(_selectLotoStatusFilter);
    on<SelectLotoLocationFilter>(_selectLotoLocationFilter);
    on<ClearLotoListFilter>(_clearLotoListFilter);
    on<ApplyLotoListFilter>(_applyLotoListFilter);
  }

  FutureOr<void> _applyLotoListFilter(
      ApplyLotoListFilter event, Emitter<LotoListState> emit) {
    filters = {
      "st": event.filterMap["st"] ?? '',
      "et": event.filterMap["et"] ?? '',
      "loc": event.filterMap["loc"] ?? '',
      "status": event.filterMap["status"] ?? '',
    };
  }

  Future<FutureOr<void>> _fetchLotoList(
      FetchLotoList event, Emitter<LotoListState> emit) async {
    emit(FetchingLotoList());
    // try {
    String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
    String? userId = await _customerCache.getUserId(CacheKeys.userId);
    if (event.isFromHome == true) {
      filters = {};
      FetchLotoListModel fetchLotoListModel = await _lotoRepository
          .fetchLotoListRepo(event.pageNo, hashCode!, userId!, '');
      data.addAll(fetchLotoListModel.data);
      hasReachedMax = fetchLotoListModel.data.isEmpty;
      emit(LotoListFetched(
          fetchLotoListModel: fetchLotoListModel,
          data: fetchLotoListModel.data,
          hasReachedMax: hasReachedMax,
          filtersMap: const {}));
    } else {
      FetchLotoListModel fetchLotoListModel =
          await _lotoRepository.fetchLotoListRepo(
              event.pageNo, hashCode!, userId!, jsonEncode(filters));
      data.addAll(fetchLotoListModel.data);
      hasReachedMax = fetchLotoListModel.data.isEmpty;
      emit(LotoListFetched(
          fetchLotoListModel: fetchLotoListModel,
          data: data,
          hasReachedMax: hasReachedMax,
          filtersMap: filters));
    }
    // } catch (e) {
    //   emit(LotoListError(error: e.toString()));
    // }
  }

  Future<FutureOr<void>> _fetchLotoMaster(
      FetchLotoMaster event, Emitter<LotoListState> emit) async {
    emit(FetchingLotoMaster());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      FetchLotoMasterModel fetchLotoMasterModel =
          await _lotoRepository.fetchLotoMasterRepo(hashCode!);
      masterData = fetchLotoMasterModel.data;
      emit(LotoMasterFetched(
          fetchLotoMasterModel: fetchLotoMasterModel, lotoMasterMap: filters));
    } catch (e) {
      emit(LotoMasterFetchError(lotoMasterError: e.toString()));
    }
  }

  FutureOr<void> _selectLotoStatusFilter(
      SelectLotoStatusFilter event, Emitter<LotoListState> emit) {
    emit(LotoStatusFilterSelected(event.selectedIndex));
  }

  FutureOr<void> _selectLotoLocationFilter(
      SelectLotoLocationFilter event, Emitter<LotoListState> emit) {
    emit(LotoLocationFilterSelected(
        event.selectLocationName, event.selectLocationId));
  }

  FutureOr<void> _clearLotoListFilter(
      ClearLotoListFilter event, Emitter<LotoListState> emit) {
    filters = {};
  }
}
