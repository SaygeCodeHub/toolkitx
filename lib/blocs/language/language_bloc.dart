import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/data/cache/cache_keys.dart';
import 'package:toolkit/data/models/language/check_new_language_keys_model.dart';
import 'package:toolkit/data/models/language/language_keys_model.dart';
import 'package:toolkit/di/app_module.dart';
import 'package:toolkit/data/models/language/languages_model.dart';
import 'package:toolkit/utils/database_utils.dart';

import '../../data/cache/customer_cache.dart';
import '../../repositories/language/language_repository.dart';
import 'language_events.dart';
import 'language_states.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageStates> {
  final LanguageRepository _languageRepository = getIt<LanguageRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();

  LanguageStates get initialState => LanguageInitial();

  LanguageBloc() : super(LanguageInitial()) {
    on<FetchLanguages>(_fetchLanguages);
    on<FetchLanguageKeys>(_fetchLanguageKeys);
    on<CheckNewLanguageKeys>(_downloadLanguage);
  }

  FutureOr<void> _fetchLanguages(
      FetchLanguages event, Emitter<LanguageStates> emit) async {
    emit(LanguagesFetching());
    try {
      LanguagesModel languagesModel =
          await _languageRepository.fetchLanguages();
      emit(LanguagesFetched(languagesModel: languagesModel));
    } catch (e) {
      emit(LanguagesError(message: e.toString()));
    }
  }

  FutureOr<void> _fetchLanguageKeys(
      FetchLanguageKeys event, Emitter<LanguageStates> emit) async {
    try {
      String? languageId =
          await _customerCache.getLanguageId(CacheKeys.languageId);
      String? syncDate =
          await _customerCache.getLanguageSyncDate(CacheKeys.languageSyncDate);

      if (languageId != event.languageId || event.isFromProfile == false) {
        emit(LanguageKeysFetching());
        LanguageKeysModel getLanguageKeysModel =
            await _languageRepository.fetchLanguageKeys(event.languageId, '');
        if (getLanguageKeysModel.status == 200) {
          _customerCache.setLanguageId(
              CacheKeys.languageId, event.languageId.toString());
          _customerCache.setLanguageSyncDate(CacheKeys.languageSyncDate,
              getLanguageKeysModel.data!.currentdate);
          for (var element in getLanguageKeysModel.data!.keys) {
            DatabaseUtil.box.put(element.key, element.value);
          }
          emit(LanguageKeysFetched(
              languageKeysModel: getLanguageKeysModel,
              isFromProfile: event.isFromProfile));
        } else {
          emit(LanguageKeysError(
              message:
                  DatabaseUtil.getText('some_unknown_error_please_try_again')));
        }
      } else {
        add(CheckNewLanguageKeys(languageId: languageId!, syncDate: syncDate!));
      }
    } catch (e) {
      emit(LanguageKeysError(message: e.toString()));
    }
  }

  FutureOr<void> _downloadLanguage(
      CheckNewLanguageKeys event, Emitter<LanguageStates> emit) async {
    emit(CheckingNewLanguageKeys());
    try {
      CheckNewLanguageKeysModel checkNewLanguageKeysModel =
          await _languageRepository.isDownloadLanguage(
              event.languageId, event.syncDate);
      if (checkNewLanguageKeysModel.data.download == '1') {
        emit(NewKeysLanguageAvailable(
            syncDate: event.syncDate, languageId: event.languageId));
      } else {
        emit(NewLanguageKeysUnavailable());
      }
    } catch (e) {
      emit(CheckNewLanguageKeysError(message: e.toString()));
    }
  }
}
