import '../../data/models/language/language_keys_model.dart';
import '../../data/models/language/languages_model.dart';

abstract class LanguageStates {}

class LanguageInitial extends LanguageStates {}

class LanguagesFetching extends LanguageStates {}

class LanguagesFetched extends LanguageStates {
  final LanguagesModel languagesModel;

  LanguagesFetched({required this.languagesModel});
}

class LanguagesError extends LanguageStates {
  final String message;

  LanguagesError({required this.message});
}

class CheckingNewLanguageKeys extends LanguageStates {}

class NewLanguageKeysUnavailable extends LanguageStates {}

class NewKeysLanguageAvailable extends LanguageStates {
  final String languageId;
  final String syncDate;
  NewKeysLanguageAvailable({required this.syncDate, required this.languageId});
}

class CheckNewLanguageKeysError extends LanguageStates {
  final String message;

  CheckNewLanguageKeysError({required this.message});
}

class LanguageKeysFetching extends LanguageStates {}

class LanguageKeysFetched extends LanguageStates {
  final bool isFromProfile;
  final LanguageKeysModel languageKeysModel;

  LanguageKeysFetched(
      {required this.isFromProfile, required this.languageKeysModel});
}

class LanguageKeysError extends LanguageStates {
  final String message;

  LanguageKeysError({required this.message});
}
