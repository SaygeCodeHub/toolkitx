import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/data/models/trips/fetch_trip_master_model.dart';
import 'package:toolkit/data/models/trips/fetch_trips_list_model.dart';
import 'package:toolkit/repositories/trips/trips_repository.dart';

import '../../data/cache/cache_keys.dart';
import '../../data/cache/customer_cache.dart';
import '../../data/models/trips/fetch_trip_details_model.dart';
import '../../di/app_module.dart';

part 'trip_event.dart';

part 'trip_state.dart';

class TripBloc extends Bloc<TripEvent, TripState> {
  final TripsRepository _tripsRepository = getIt<TripsRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();

  TripState get initialState => TripInitial();

  TripBloc() : super(TripInitial()) {
    on<FetchTripsList>(_fetchTripsList);
    on<FetchTripsDetails>(_fetchTripsDetails);
    on<FetchTripMaster>(_fetchTripMaster);
    on<SelectTripStatusFilter>(_selectTripStatusFilter);
    on<SelectTripVesselFilter>(_selectTripVesselFilter);
    on<ApplyTripFilter>(_applyTripFilter);
    on<ClearTripFilter>(_clearTripFilter);
  }
  int tripTabIndex = 0;

  bool hasReachedMax = false;
  List<TripDatum> tripDatum = [];
  Map filters = {};
  String vesselName = '';

  Future<FutureOr<void>> _fetchTripsList(
      FetchTripsList event, Emitter<TripState> emit) async {
    emit(TripsListFetching());
    try {
      if (event.isFromHome) {
        String? hashCode =
            await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
        String? userId = await _customerCache.getUserId(CacheKeys.userId) ?? '';
        FetchTripsListModel fetchTripsListModel = await _tripsRepository
            .fetchTripsList(event.pageNo, hashCode, "{}", userId);
        tripDatum.addAll((fetchTripsListModel.data));
        hasReachedMax = fetchTripsListModel.data.isEmpty;
        emit(TripsListFetched(
            fetchTripsListModel: fetchTripsListModel,
            tripDatum: tripDatum,
            filterMap: {}));
      } else {
        String? hashCode =
            await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
        String? userId = await _customerCache.getUserId(CacheKeys.userId) ?? '';
        FetchTripsListModel fetchTripsListModel =
            await _tripsRepository.fetchTripsList(
                event.pageNo, hashCode, jsonEncode(filters), userId);
        tripDatum.addAll((fetchTripsListModel.data));
        hasReachedMax = fetchTripsListModel.data.isEmpty;
        emit(TripsListFetched(
            fetchTripsListModel: fetchTripsListModel,
            tripDatum: tripDatum,
            filterMap: filters));
      }
    } catch (e) {
      emit(TripsListNotFetched(errorMessage: e.toString()));
    }
  }

  Future<FutureOr<void>> _fetchTripsDetails(
      FetchTripsDetails event, Emitter<TripState> emit) async {
    tripTabIndex = event.tripTabIndex;
    emit(TripDetailsFetching());
    try {
      String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      String? userId = await _customerCache.getUserId(CacheKeys.userId) ?? '';

      FetchTripDetailsModel fetchTripDetailsModel = await _tripsRepository
          .fetchTripDetails(event.tripId, hashCode, userId);

      if (fetchTripDetailsModel.status == 200) {
        emit(TripDetailsFetched(fetchTripDetailsModel: fetchTripDetailsModel));
      } else {
        emit(
            TripDetailsNotFetched(errorMessage: fetchTripDetailsModel.message));
      }
    } catch (e) {
      emit(TripDetailsNotFetched(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _selectTripStatusFilter(
      SelectTripStatusFilter event, Emitter<TripState> emit) {
    emit(TripsStatusFilterSelected(
        selected: event.selected, selectedIndex: event.selectedIndex));
  }

  Future<FutureOr<void>> _fetchTripMaster(
      FetchTripMaster event, Emitter<TripState> emit) async {
    emit(TripsListFetching());
    try {
      String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';

      FetchTripMasterModel fetchTripMasterModel =
          await _tripsRepository.fetchTripMaster(hashCode);
      if (fetchTripMasterModel.status == 200) {
        emit(TripMasterFetched(fetchTripMasterModel: fetchTripMasterModel));
      } else {
        emit(TripMasterNotFetched(errorMessage: fetchTripMasterModel.message));
      }
    } catch (e) {
      emit(TripMasterNotFetched(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _selectTripVesselFilter(
      SelectTripVesselFilter event, Emitter<TripState> emit) {
    emit(TripsVesselFilterSelected(selectVessel: event.selectVessel));
  }

  FutureOr<void> _applyTripFilter(
      ApplyTripFilter event, Emitter<TripState> emit) {
    filters = event.tripFilterMap;
  }

  FutureOr<void> _clearTripFilter(
      ClearTripFilter event, Emitter<TripState> emit) {
    filters = {};
  }
}
