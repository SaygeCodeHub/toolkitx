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
      TimeZoneModel getTimeZoneModel =
          await _timeZoneRepository.fetchTimeZone();
      emit(TimeZoneFetched(getTimeZoneModel: getTimeZoneModel));
    } catch (e) {
      emit(FetchTimeZoneError());
    }
  }

  FutureOr<void> _selectTimeZone(
      SelectTimeZone event, Emitter<TimeZoneStates> emit) async {
    if (event.isFromProfile == true) {
      String userType = (await _customerCache.getUserType(CacheKeys.userType))!;
      String apiKey = (await _customerCache.getApiKey(CacheKeys.apiKey))!;
      String hashKey = (await _customerCache.getClientId(CacheKeys.clientId))!;
      String dateTimeValue =
          (await _customerCache.getDateFormat(CacheKeys.dateFormatKey))!;
      String hashCode =
          '$apiKey|$hashKey|$userType|$dateTimeValue|${event.timeZoneCode}';
      _customerCache.setHashCode(CacheKeys.hashcode, hashCode);
    }
    _customerCache.setTimeZoneOffset(
        CacheKeys.timeZoneOffset, event.timeZoneOffset.substring(3));
    _customerCache.setTimeZoneCode(CacheKeys.timeZoneCode, event.timeZoneCode);
    _customerCache.setTimeZoneName(CacheKeys.timeZoneName, event.timeZoneName);
  }
}
