import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/data/models/trips/fetch_trips_list_model.dart';
import 'package:toolkit/repositories/trips/trips_repository.dart';

import '../../data/cache/cache_keys.dart';
import '../../data/cache/customer_cache.dart';
import '../../di/app_module.dart';

part 'trip_event.dart';

part 'trip_state.dart';

class TripBloc extends Bloc<TripEvent, TripState> {
  final TripsRepository _tripsRepository = getIt<TripsRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();

  TripState get initialState => TripInitial();

  TripBloc() : super(TripInitial()) {
    on<FetchTripsList>(_fetchTripsList);
  }

  Future<FutureOr<void>> _fetchTripsList(
      FetchTripsList event, Emitter<TripState> emit) async {
    emit(TripsListFetching());
    try {
      String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      String? userId = await _customerCache.getUserId(CacheKeys.userId) ?? '';

      FetchTripsListModel fetchTripsListModel = await _tripsRepository
          .fetchTripsList(event.pageNo, hashCode, "{}", userId);

      if (fetchTripsListModel.status == 200) {
        emit(TripsListFetched(fetchTripsListModel: fetchTripsListModel));
      } else {
        emit(TripsListNotFetched(errorMessage: fetchTripsListModel.message));
      }
    } catch (e) {
      emit(TripsListNotFetched(errorMessage: e.toString()));
    }
  }
}
