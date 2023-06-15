import 'dart:async';

import 'package:toolkit/blocs/home/home_events.dart';
import 'package:toolkit/blocs/home/home_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/cache/cache_keys.dart';
import '../../data/cache/customer_cache.dart';
import '../../data/enums/date_enum.dart';
import '../../di/app_module.dart';

class HomeBloc extends Bloc<HomeEvents, HomeStates> {
  final CustomerCache _customerCache = getIt<CustomerCache>();

  HomeBloc() : super(const HomeInitial()) {
    on<SetDateAndTime>(_setDateAndTime);
    on<StartTimer>(_startTimer);
  }

  FutureOr<void> _startTimer(StartTimer event, Emitter<HomeStates> emit) {
    Stream.periodic(const Duration(seconds: 1), (count) => count)
        .listen((count) => add(const SetDateAndTime()));
  }

  FutureOr<void> _setDateAndTime(
      SetDateAndTime event, Emitter<HomeStates> emit) async {
    try {
      String? timeZoneName;
      DateTime dateTime = DateTime.now();
      String? dateFormatKey =
          await _customerCache.getDateFormat(CacheKeys.dateFormatKey);
      String dateFormat = 'dd.MM.yyyy';
      String? image =
          await _customerCache.getClientImage(CacheKeys.clientImage);
      String? timeZoneOffset =
          await _customerCache.getTimeZoneOffset(CacheKeys.timeZoneOffset);
      timeZoneName =
          await _customerCache.getTimeZoneName(CacheKeys.timeZoneName);
      timeZoneName ??= DateTime.now().timeZoneName;
      if (timeZoneOffset != null) {
        List offset =
            timeZoneOffset.replaceAll('+', '').replaceAll('-', '').split(':');
        if (timeZoneOffset.contains('+')) {
          dateTime = DateTime.now().toUtc().add(Duration(
              hours: int.parse(offset[0]),
              minutes: int.parse(offset[1].trim())));
        } else {
          dateTime = DateTime.now().toUtc().subtract(Duration(
              hours: int.parse(offset[0]),
              minutes: int.parse(offset[1].trim())));
        }
      }
      if (dateFormatKey != null) {
        dateFormat = CustomDateFormat.values
            .elementAt(CustomDateFormat.values
                .indexWhere((element) => element.value == dateFormatKey))
            .dateFormat;
      }
      emit(DateAndTimeLoaded(
          dateTime: dateTime,
          timeZoneName: timeZoneName,
          image: image!,
          dateFormat: dateFormat));
    } catch (e) {
      emit(DateAndTimeLoaded(
          dateTime: DateTime.now(),
          timeZoneName: '',
          image: '',
          dateFormat: ''));
    }
  }
}
