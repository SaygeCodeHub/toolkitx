import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/cache/cache_keys.dart';
import '../../data/cache/customer_cache.dart';
import '../../data/models/loto/loto_list_model.dart';
import '../../di/app_module.dart';
import '../../repositories/loto/loto_repository.dart';

part 'loto_list_event.dart';
part 'loto_list_state.dart';

class LotoListBloc extends Bloc<LotoListEvent, LotoListState> {
  final LotoRepository _lotoRepository = getIt<LotoRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();

  LotoListState get initialState => LotoListInitial();
  final List<LotoListDatum> data = [];
  bool hasReachedMax = false;
  LotoListBloc() : super(LotoListInitial()) {
    on<FetchLotoList>(_fetchLotoList);
  }

  Future<FutureOr<void>> _fetchLotoList(
      FetchLotoList event, Emitter<LotoListState> emit) async {
    emit(FetchingLotoList());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);

      FetchLotoListModel fetchLotoListModel = await _lotoRepository
          .fetchLotoListRepo(event.pageNo, hashCode!, userId!, '');
      data.addAll(fetchLotoListModel.data);
      emit(LotoListFetched(
          fetchLotoListModel: fetchLotoListModel,
          data: data,
          hasReachedMax: hasReachedMax));
    } catch (e) {
      emit(LotoListError(error: e.toString()));
    }
  }
}
