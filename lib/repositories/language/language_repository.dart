import '../../data/models/language/check_new_language_keys_model.dart';
import '../../data/models/language/language_keys_model.dart';
import '../../data/models/language/languages_model.dart';

abstract class LanguageRepository {
  Future<LanguagesModel> fetchLanguages();

  Future<LanguageKeysModel> fetchLanguageKeys(
      String languageId, String languageSyncDate);

  Future<CheckNewLanguageKeysModel> isDownloadLanguage(
      String languageId, String languageSyncDate);
}
