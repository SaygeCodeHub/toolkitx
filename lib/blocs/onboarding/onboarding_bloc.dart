import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/cache/cache_keys.dart';
import '../../data/cache/customer_cache.dart';
import '../../di/app_module.dart';
import 'onboarding_events.dart';
import 'onboarding_states.dart';

class OnBoardingBloc extends Bloc<OnBoardingEvents, OnBoardingStates> {
  final CustomerCache _customerCache = getIt<CustomerCache>();

  OnBoardingStates get initialState => OnBoardingInitial();

  OnBoardingBloc() : super(OnBoardingInitial()) {
    on<CheckLanguageSelected>(_isLanguageSelected);
    on<CheckTimeZoneSelected>(_isTimeZoneSelected);
    on<CheckDateFormatSelected>(_isDateFormatSelected);
    on<CheckLoggedIn>(_isLoggedIn);
    on<CheckClientSelected>(_checkClientSelected);
  }

  Future<FutureOr<void>> _checkClientSelected(
      CheckClientSelected event, Emitter<OnBoardingStates> emit) async {
    try {
      String? isClientSelected;
      isClientSelected = await _customerCache.getApiKey(CacheKeys.apiKey);
      if (isClientSelected != null) {
        emit(ClientSelected());
      } else {
        add(CheckLoggedIn());
      }
    } catch (e) {
      add(CheckLoggedIn());
    }
  }

  Future<FutureOr<void>> _isLoggedIn(
      CheckLoggedIn event, Emitter<OnBoardingStates> emit) async {
    try {
      bool isLoggedIn =
          (await _customerCache.getIsLoggedIn(CacheKeys.isLoggedIn))!;
      if (isLoggedIn == true) {
        emit(LoggedIn());
      } else {
        add(CheckDateFormatSelected());
      }
    } catch (e) {
      add(CheckDateFormatSelected());
    }
  }

  Future<FutureOr<void>> _isDateFormatSelected(
      CheckDateFormatSelected event, Emitter<OnBoardingStates> emit) async {
    try {
      String? isDateFormatSelected;
      isDateFormatSelected =
          await _customerCache.getDateFormat(CacheKeys.dateFormatKey);
      if (isDateFormatSelected != null) {
        emit(DateFormatSelected());
      } else {
        add(CheckTimeZoneSelected());
      }
    } catch (e) {
      add(CheckTimeZoneSelected());
    }
  }

  Future<FutureOr<void>> _isTimeZoneSelected(
      CheckTimeZoneSelected event, Emitter<OnBoardingStates> emit) async {
    try {
      String? isTimeZoneSelected;
      isTimeZoneSelected =
          await _customerCache.getTimeZoneCode(CacheKeys.timeZoneCode);
      if (isTimeZoneSelected != null) {
        emit(TimeZoneSelected());
      } else {
        add(CheckLanguageSelected());
      }
    } catch (e) {
      add(CheckLanguageSelected());
    }
  }

  FutureOr<void> _isLanguageSelected(
      CheckLanguageSelected event, Emitter<OnBoardingStates> emit) async {
    try {
      String? isLanguageSelected;
      isLanguageSelected =
          await _customerCache.getLanguageId(CacheKeys.languageId);
      if (isLanguageSelected != null) {
        emit(LanguageSelected());
      }
    } catch (e) {
      return;
    }
  }
}
