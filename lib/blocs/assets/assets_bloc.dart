import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/data/models/assets/assets_list_model.dart';
import 'package:toolkit/repositories/assets/assets_repository.dart';

import '../../data/cache/cache_keys.dart';
import '../../data/cache/customer_cache.dart';
import '../../di/app_module.dart';

part 'assets_event.dart';
part 'assets_state.dart';

class AssetsBloc extends Bloc<AssetsEvent, AssetsState> {
  final AssetsRepository _assetsRepository = getIt<AssetsRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();

  AssetsState get initialState => AssetsInitial();
  AssetsBloc() : super(AssetsInitial()) {
    on<FetchAssetsList>(_fetchAssetsList);
  }

  Future<FutureOr<void>> _fetchAssetsList(
      FetchAssetsList event, Emitter<AssetsState> emit) async {
    emit(AssetsListFetching());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      FetchAssetsListModel fetchAssetsListModel = await _assetsRepository
          .fetchAssetsListRepo(event.pageNo, hashCode!, "");
      emit(AssetsListFetched(fetchAssetsListModel: fetchAssetsListModel));
    } catch (e) {
      emit(AssetsListError(errorMessage: e.toString()));
    }
  }
}
