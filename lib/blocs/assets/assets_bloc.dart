import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/data/models/assets/assets_list_model.dart';
import 'package:toolkit/repositories/assets/assets_repository.dart';
import '../../data/cache/cache_keys.dart';
import '../../data/cache/customer_cache.dart';
import '../../data/models/assets/assets_details_model.dart';
import '../../data/models/assets/assets_master_model.dart';
import '../../di/app_module.dart';
part 'assets_event.dart';
part 'assets_state.dart';

class AssetsBloc extends Bloc<AssetsEvent, AssetsState> {
  final AssetsRepository _assetsRepository = getIt<AssetsRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();

  AssetsState get initialState => AssetsInitial();

  AssetsBloc() : super(AssetsInitial()) {
    on<FetchAssetsList>(_fetchAssetsList);
    on<FetchAssetsDetails>(_fetchAssetsDetails);
    on<FetchAssetsMaster>(_fetchAssetsMaster);
    on<SelectAssetsLocation>(_selectAssetsLocation);
    on<SelectAssetsStatus>(_selectAssetsStatus);
    on<SelectAssetsSite>(_selectAssetsSite);
    on<ApplyAssetsFilter>(_applyAssetsFilter);
    on<ClearAssetsFilter>(_clearAssetsFilter);
  }

  int assetTabIndex = 0;
  List<AssetsListDatum> assetsDatum = [];
  bool hasReachedMax = false;
  Map filters = {};
  List assetMasterData = [];
  String selectLocationName = '';

  Future<FutureOr<void>> _fetchAssetsList(
      FetchAssetsList event, Emitter<AssetsState> emit) async {
    emit(AssetsListFetching());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      if (event.isFromHome == true) {
        FetchAssetsListModel fetchAssetsListModel = await _assetsRepository
            .fetchAssetsListRepo(event.pageNo, hashCode!, "");
        assetsDatum.addAll(fetchAssetsListModel.data);
        hasReachedMax = fetchAssetsListModel.data.isEmpty;
        emit(AssetsListFetched(
            fetchAssetsListModel: fetchAssetsListModel,
            data: fetchAssetsListModel.data,
            hasReachedMax: hasReachedMax,
            filtersMap: {}));
      } else {
        FetchAssetsListModel fetchAssetsListModel = await _assetsRepository
            .fetchAssetsListRepo(event.pageNo, hashCode!, jsonEncode(filters));
        assetsDatum.addAll(fetchAssetsListModel.data);
        hasReachedMax = fetchAssetsListModel.data.isEmpty;
        emit(AssetsListFetched(
            fetchAssetsListModel: fetchAssetsListModel,
            data: fetchAssetsListModel.data,
            hasReachedMax: hasReachedMax,
            filtersMap: filters));
      }
    } catch (e) {
      emit(AssetsListError(errorMessage: e.toString()));
    }
  }

  Future<FutureOr<void>> _fetchAssetsDetails(
      FetchAssetsDetails event, Emitter<AssetsState> emit) async {
    assetTabIndex = event.assetTabIndex;
    emit(AssetsDetailsFetching());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      FetchAssetsDetailsModel fetchAssetsDetailsModel = await _assetsRepository
          .fetchAssetsDetailsRepo(hashCode!, event.assetId);
      emit(AssetsDetailsFetched(
          fetchAssetsDetailsModel: fetchAssetsDetailsModel));
    } catch (e) {
      emit(AssetsDetailsError(errorMessage: e.toString()));
    }
  }

  Future<FutureOr<void>> _fetchAssetsMaster(
      FetchAssetsMaster event, Emitter<AssetsState> emit) async {
    emit(AssetsMasterFetching());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      FetchAssetsMasterModel fetchAssetsMasterModel =
          await _assetsRepository.fetchAssetsMasterRepo(hashCode!);
      assetMasterData = fetchAssetsMasterModel.data;
      emit(AssetsMasterFetched(
          fetchAssetsMasterModel: fetchAssetsMasterModel,
          assetsMasterMap: filters));
    } catch (e) {
      emit(AssetsMasterError(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _selectAssetsLocation(
      SelectAssetsLocation event, Emitter<AssetsState> emit) {
    emit(AssetsLocationSelected(selectLocationName: event.selectLocationName));
  }

  FutureOr<void> _selectAssetsStatus(
      SelectAssetsStatus event, Emitter<AssetsState> emit) {
    emit(AssetsStatusSelected(id: event.id));
  }

  FutureOr<void> _selectAssetsSite(
      SelectAssetsSite event, Emitter<AssetsState> emit) {
    emit(AssetsSiteSelected(id: event.id));
  }

  FutureOr<void> _applyAssetsFilter(
      ApplyAssetsFilter event, Emitter<AssetsState> emit) {
    filters = {
      "name": event.assetsFilterMap["name"],
      "loc": event.assetsFilterMap["loc"],
      "status": event.assetsFilterMap["status"],
      "site": event.assetsFilterMap["site"],
    };
  }

  FutureOr<void> _clearAssetsFilter(
      ClearAssetsFilter event, Emitter<AssetsState> emit) {
    filters = {};
    add(FetchAssetsList(pageNo: 1, isFromHome: false));
  }
}
