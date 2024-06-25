import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/dateFormat/date_format_events.dart';
import 'package:toolkit/blocs/dateFormat/date_format_states.dart';
import 'package:toolkit/data/cache/customer_cache.dart';

import '../../data/cache/cache_keys.dart';
import '../../data/enums/date_enum.dart';
import '../../di/app_module.dart';

class DateFormatBloc extends Bloc<SetDateFormat, DateFormatStates> {
  final CustomerCache _customerCache = getIt<CustomerCache>();

  DateFormatBloc() : super(DateFormatSelected(dateFormatString: '')) {
    on<SetDateFormat>(_saveDateFormat);
  }

  FutureOr<void> _saveDateFormat(
      SetDateFormat event, Emitter<DateFormatStates> emit) async {
    if (event.isFromProfile == true) {
      if (event.saveDateFormatValue == '') {
        String dateTimeValue =
            (await _customerCache.getDateFormat(CacheKeys.dateFormatKey))!;
        String dateTimeFormat = CustomDateFormat.values
            .elementAt(CustomDateFormat.values
                .indexWhere((element) => element.value == dateTimeValue))
            .dateFormat;
        emit(DateFormatSelected(
            dateFormatValue: dateTimeValue,
            dateFormatString: dateTimeFormat,
            isFormProfile: event.isFromProfile));
      } else {
        _customerCache.setDateFormatValue(
            CacheKeys.dateFormatKey, event.saveDateFormatValue);
        String timeZoneCode =
            (await _customerCache.getTimeZoneCode(CacheKeys.timeZoneCode))!;
        String userType =
            (await _customerCache.getUserType(CacheKeys.userType))!;
        String apiKey = (await _customerCache.getApiKey(CacheKeys.apiKey))!;
        String hashKey =
            (await _customerCache.getClientId(CacheKeys.clientId))!;
        String hashCode =
            '$apiKey|$hashKey|$userType|${event.saveDateFormatValue}|$timeZoneCode';
        _customerCache.setHashCode(CacheKeys.hashcode, hashCode);
        emit(DateFormatSelected(
            dateFormatValue: event.saveDateFormatValue,
            dateFormatString: event.saveDateFormatString,
            isFormProfile: event.isFromProfile));
      }
    } else {
      if (event.saveDateFormatValue == '') {
        String dateTimeValue = CustomDateFormat.values.elementAt(0).value;
        String dateTimeFormat = CustomDateFormat.values.elementAt(0).dateFormat;
        _customerCache.setDateFormatValue(
            CacheKeys.dateFormatKey, dateTimeValue);
        emit(DateFormatSelected(
            dateFormatValue: dateTimeValue,
            dateFormatString: dateTimeFormat,
            isFormProfile: event.isFromProfile));
      } else {
        _customerCache.setDateFormatValue(
            CacheKeys.dateFormatKey, event.saveDateFormatValue);
        emit(DateFormatSelected(
            dateFormatValue: event.saveDateFormatValue,
            dateFormatString: event.saveDateFormatString,
            isFormProfile: event.isFromProfile));
      }
    }
  }
}
