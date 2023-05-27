import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/timeZone/time_zone_events.dart';
import 'package:toolkit/blocs/timeZone/time_zone_states.dart';
import 'package:toolkit/data/cache/cache_keys.dart';
import 'package:toolkit/data/models/timeZones/time_zone_model.dart';
import 'package:toolkit/repositories/timeZone/time_zone_repository.dart';

import '../../data/cache/customer_cache.dart';
import '../../di/app_module.dart';

class TimeZoneBloc extends Bloc<TimeZoneEvents, TimeZoneStates> {
  final TimeZoneRepository _timeZoneRepository = getIt<TimeZoneRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();

  TimeZoneStates get initialState => TimeZoneInitial();

  TimeZoneBloc() : super(TimeZoneInitial()) {
    on<FetchTimeZone>(_fetchTimeZone);
    on<SelectTimeZone>(_selectTimeZone);
  }

  FutureOr<void> _fetchTimeZone(
      FetchTimeZone event, Emitter<TimeZoneStates> emit) async {
    emit(TimeZoneFetching());
    try {
      GetTimeZoneModel getTimeZoneModel =
          await _timeZoneRepository.fetchTimeZone();
      emit(TimeZoneFetched(getTimeZoneModel: getTimeZoneModel));
    } catch (e) {
      emit(FetchTimeZoneError(message: e.toString()));
    }
  }

  _selectTimeZone(SelectTimeZone event, Emitter<TimeZoneStates> emit) {
    _customerCache.setTimeZoneCode(CacheKeys.timeZoneCode, event.timeZoneCode);
    emit(TimeZoneSelected());
  }
}
