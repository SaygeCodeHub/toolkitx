import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/repositories/location/location_repository.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../data/cache/cache_keys.dart';
import '../../data/cache/customer_cache.dart';
import '../../data/models/location/fetch_location_checklists_model.dart';
import '../../data/models/location/fetch_location_assets_model.dart';
import '../../data/models/location/fetch_location_details_model.dart';
import '../../data/models/location/fetch_location_logbooks_model.dart';
import '../../data/models/location/fetch_location_loto_model.dart';
import '../../data/models/location/fetch_location_permits_model.dart';
import '../../data/models/location/fetch_location_workorders_model.dart';
import '../../data/models/location/fetch_locations_model.dart';
import '../../di/app_module.dart';
import 'location_event.dart';
import 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationRepository _locationRepository = getIt<LocationRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  List<LocationDatum> locationDatum = [];
  bool locationListReachedMax = false;
  List<LocationPermitsDatum> locationPermits = [];
  bool locationPermitListReachedMax = false;
  List<LocationLotoDatum> locationLoTos = [];
  bool locationLoToListReachedMax = false;
  List<LocationWorkOrdersDatum> workOrderLocations = [];
  bool workOrderLoToListReachedMax = false;
  List<LocationAssetsDatum> locationAssets = [];
  bool locationAssetsListReachedMax = false;
  List<LocationLogBooksDatum> locationLogBooks = [];
  bool locationLogBooksListReachedMax = false;
  String locationId = '';
  Map loToFilterMap = {};
  Map workOrderFilterMap = {};
  Map logBookFilterMap = {};
  Map assetsFilterMap = {};
  Map permitsFilterMap = {};

  LocationBloc() : super(LocationInitial()) {
    on<FetchLocations>(_fetchLocations);
    on<FetchLocationDetails>(_fetchLocationDetails);
    on<FetchLocationPermits>(_fetchLocationPermits);
    on<FetchLocationLoTo>(_fetchLocationLoTo);
    on<FetchLocationWorkOrders>(_fetchLocationWorkOrders);
    on<FetchCheckListsLocation>(_fetchLocationCheckLists);
    on<FetchLocationAssets>(_fetchLocationAssets);
    on<FetchLocationLogBooks>(_fetchLocationLogBooks);
    on<ApplyLoToListFilter>(_applyLoToListFilter);
    on<ApplyWorkOrderListFilter>(_applyWorkOrderListFilter);
    on<ApplyLogBookListFilter>(_applyLogBookListFilter);
    on<ApplyAssetsListFilter>(_applyAssetsListFilter);
    on<ApplyPermitListFilter>(_applyPermitListFilter);
  }

  FutureOr<void> _applyLoToListFilter(
      ApplyLoToListFilter event, Emitter<LocationState> emit) {
    loToFilterMap = {
      "st": event.filterMap["st"] ?? '',
      "et": event.filterMap["et"] ?? '',
      "loc": event.filterMap["loc"] ?? '',
      "status": event.filterMap["status"] ?? '',
    };
  }

  Future<void> _fetchLocations(
      FetchLocations event, Emitter<LocationState> emit) async {
    emit(FetchingLocations());
    try {
      String hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      FetchLocationsModel fetchLocationsModel = await _locationRepository
          .fetchLocations(event.pageNo, hashCode, '{}');
      locationListReachedMax = fetchLocationsModel.data.isEmpty;
      locationDatum.addAll(fetchLocationsModel.data);
      emit(LocationsFetched(
          locationDatum: locationDatum,
          locationListReachedMax: locationListReachedMax));
    } catch (e) {
      emit(LocationsCouldNotFetch(locationsNotFetched: e.toString()));
    }
  }

  Future<void> _fetchLocationDetails(
      FetchLocationDetails event, Emitter<LocationState> emit) async {
    emit(FetchingLocationDetails());
    try {
      String hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      String clientId =
          await _customerCache.getClientId(CacheKeys.clientId) ?? '';
      locationId = event.locationId;
      FetchLocationDetailsModel fetchLocationDetailsModel =
          await _locationRepository.fetchLocationDetails(locationId, hashCode);
      if (fetchLocationDetailsModel.status == 200) {
        emit(LocationDetailsFetched(
            fetchLocationDetailsModel: fetchLocationDetailsModel,
            selectedTabIndex: event.selectedTabIndex,
            clientId: clientId));
      } else {
        emit(LocationDetailsNotFetched(
            detailsNotFetched: fetchLocationDetailsModel.message));
      }
    } catch (e) {
      emit(LocationDetailsNotFetched(detailsNotFetched: e.toString()));
    }
  }

  FutureOr<void> _applyPermitListFilter(
      ApplyPermitListFilter event, Emitter<LocationState> emit) {
    permitsFilterMap = {
      "st": event.filterMap['st'] ?? '',
      "et": event.filterMap['et'] ?? '',
      "kword": event.filterMap['kword'] ?? '',
      "type": event.filterMap['type'] ?? '',
      "status": event.filterMap['status'] ?? '',
      "eme": event.filterMap['eme'] ?? '',
      "locs": event.filterMap['locs'] ?? ''
    };
  }

  Future<void> _fetchLocationPermits(
      FetchLocationPermits event, Emitter<LocationState> emit) async {
    emit(FetchingLocationPermits());
    try {
      String hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      FetchLocationPermitsModel fetchLocationPermitsModel =
          await _locationRepository.fetchLocationPermits(
              event.pageNo, hashCode, jsonEncode(permitsFilterMap), locationId);
      locationPermitListReachedMax = fetchLocationPermitsModel.data.isEmpty;
      locationPermits.addAll(fetchLocationPermitsModel.data);
      if (locationPermits.isNotEmpty) {
        emit(LocationPermitsFetched(
            locationPermits: locationPermits,
            locationPermitListReachedMax: locationPermitListReachedMax,
            filterMap: permitsFilterMap));
      } else {
        emit(LocationPermitsNotFetched(
            permitsNotFetched: StringConstants.kNoRecordsFound,
            filterMap: permitsFilterMap));
      }
    } catch (e) {
      emit(LocationPermitsNotFetched(
          permitsNotFetched: e.toString(), filterMap: {}));
    }
  }

  Future<void> _fetchLocationLoTo(
      FetchLocationLoTo event, Emitter<LocationState> emit) async {
    emit(FetchingLocationLoTo());
    try {
      String hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      String userId = await _customerCache.getUserId(CacheKeys.userId) ?? '';
      FetchLocationLoToModel fetchLocationLoToModel =
          await _locationRepository.fetchLocationLoTo(event.pageNo, hashCode,
              userId, jsonEncode(loToFilterMap), locationId);
      locationLoToListReachedMax = fetchLocationLoToModel.data.isEmpty;
      locationLoTos.addAll(fetchLocationLoToModel.data);
      if (locationLoTos.isNotEmpty) {
        emit(LocationLoToFetched(
            locationLoTos: locationLoTos,
            locationLoToListReachedMax: locationPermitListReachedMax,
            loToFilterMap: loToFilterMap));
      } else {
        emit(LocationLoToNotFetched(
            loToNotFetched: StringConstants.kNoRecordsFound,
            filtersMap: loToFilterMap));
      }
    } catch (e) {
      emit(
          LocationLoToNotFetched(loToNotFetched: e.toString(), filtersMap: {}));
    }
  }

  Future<void> _fetchLocationWorkOrders(
      FetchLocationWorkOrders event, Emitter<LocationState> emit) async {
    emit(FetchingLocationWorkOrders());
    try {
      String hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      FetchLocationWorkOrdersModel fetchLocationWorkOrdersModel =
          await _locationRepository.fetchLocationWorkOrders(event.pageNo,
              hashCode, jsonEncode(workOrderFilterMap), locationId);
      workOrderLoToListReachedMax = fetchLocationWorkOrdersModel.data.isEmpty;
      workOrderLocations.addAll(fetchLocationWorkOrdersModel.data);
      if (workOrderLocations.isNotEmpty) {
        emit(LocationWorkOrdersFetched(
            workOrderLocations: workOrderLocations,
            workOrderLoToListReachedMax: workOrderLoToListReachedMax,
            filterMap: workOrderFilterMap));
      } else {
        emit(LocationWorkOrdersNotFetched(
            workOrderNotFetched: StringConstants.kNoRecordsFound,
            filtersMap: workOrderFilterMap));
      }
    } catch (e) {
      emit(LocationWorkOrdersNotFetched(
          workOrderNotFetched: e.toString(), filtersMap: {}));
    }
  }

  Future<void> _fetchLocationCheckLists(
      FetchCheckListsLocation event, Emitter<LocationState> emit) async {
    emit(FetchingLocationCheckLists());
    try {
      String hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      FetchLocationCheckListsModel fetchLocationCheckListsModel =
          await _locationRepository.fetchLocationCheckLists(
              hashCode, '{}', locationId);
      if (fetchLocationCheckListsModel.data.isNotEmpty) {
        emit(LocationCheckListsFetched(
            fetchLocationCheckListsModel: fetchLocationCheckListsModel));
      } else {
        emit(LocationCheckListsNotFetched(
            checkListsNotFetched: StringConstants.kNoRecordsFound));
      }
    } catch (e) {
      emit(LocationCheckListsNotFetched(checkListsNotFetched: e.toString()));
    }
  }

  FutureOr<void> _applyAssetsListFilter(
      ApplyAssetsListFilter event, Emitter<LocationState> emit) async {
    assetsFilterMap = {
      "name": event.filterMap['name'] ?? '',
      "loc": event.filterMap['loc'] ?? '',
      "status": event.filterMap['status'] ?? '',
      "site": event.filterMap['site'] ?? ''
    };
  }

  Future<void> _fetchLocationAssets(
      FetchLocationAssets event, Emitter<LocationState> emit) async {
    emit(FetchingLocationAssets());
    try {
      String hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      FetchLocationAssetsModel fetchLocationAssetsModel =
          await _locationRepository.fetchLocationAssets(
              event.pageNo, hashCode, jsonEncode(assetsFilterMap));
      locationAssetsListReachedMax = fetchLocationAssetsModel.data.isEmpty;
      locationAssets.addAll(fetchLocationAssetsModel.data);
      if (locationAssets.isNotEmpty) {
        emit(LocationAssetsFetched(
            locationAssetsListReachedMax: locationAssetsListReachedMax,
            locationAssets: locationAssets,
            filterMap: assetsFilterMap));
      } else {
        emit(LocationAssetsNotFetched(
            assetsNotFetched: StringConstants.kNoRecordsFound,
            filterMap: assetsFilterMap));
      }
    } catch (e) {
      emit(LocationAssetsNotFetched(
          assetsNotFetched: e.toString(), filterMap: {}));
    }
  }

  FutureOr<void> _applyLogBookListFilter(
      ApplyLogBookListFilter event, Emitter<LocationState> emit) {
    logBookFilterMap = {
      "kword": event.filterMap['kword'] ?? '',
      "st": event.filterMap['st'] ?? '',
      "et": event.filterMap['et'] ?? '',
      "types": event.filterMap['types'] ?? '',
      "pri": event.filterMap['pri'] ?? '',
      "lgbooks": event.filterMap['lgbooks'] ?? '',
      "act": event.filterMap['act'] ?? '',
      "status": event.filterMap['status'] ?? ''
    };
  }

  Future<void> _fetchLocationLogBooks(
      FetchLocationLogBooks event, Emitter<LocationState> emit) async {
    emit(FetchingLocationLogBooks());
    try {
      String hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      String userId = await _customerCache.getUserId(CacheKeys.userId) ?? '';
      FetchLocationLogBookModel fetchLocationLogBookModel =
          await _locationRepository.fetchLocationLogBooks(event.pageNo,
              hashCode, userId, jsonEncode(logBookFilterMap), locationId);
      locationLogBooksListReachedMax = fetchLocationLogBookModel.data.isEmpty;
      locationLogBooks.addAll(fetchLocationLogBookModel.data);
      if (locationLogBooks.isNotEmpty) {
        emit(LocationLogBooksFetched(
            locationLogBooksListReachedMax: locationLogBooksListReachedMax,
            locationLogBooks: locationLogBooks,
            filterMap: logBookFilterMap));
      } else {
        emit(LocationLogBooksNotFetched(
            logBooksNotFetched: StringConstants.kNoRecordsFound,
            filterMap: logBookFilterMap));
      }
    } catch (e) {
      emit(LocationLogBooksNotFetched(
          logBooksNotFetched: e.toString(), filterMap: {}));
    }
  }

  FutureOr<void> _applyWorkOrderListFilter(
      ApplyWorkOrderListFilter event, Emitter<LocationState> emit) {
    workOrderFilterMap = {
      "status": event.filterMap['status'] ?? '',
      "type": event.filterMap['type'] ?? '',
      "st": event.filterMap['st'] ?? '',
      "et": event.filterMap['et'] ?? '',
      "kword": event.filterMap['kword'] ?? ''
    };
  }
}
