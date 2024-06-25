import '../../data/models/language/check_new_language_keys_model.dart';
import '../../data/models/language/language_keys_model.dart';
import '../../data/models/language/languages_model.dart';
import '../../utils/constants/api_constants.dart';
import '../../utils/dio_client.dart';
import 'language_repository.dart';

class LanguageRepositoryImpl extends LanguageRepository {
  @override
  Future<LanguagesModel> fetchLanguages() async {
    final response =
        await DioClient().get("${ApiConstants.baseUrl}common/GetLanguages");
    return LanguagesModel.fromJson(response);
  }

  @override
  Future<LanguageKeysModel> fetchLanguageKeys(
      String languageId, String languageSyncDate) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}common/getlanguagekeys?languageid=$languageId&syncdate=$languageSyncDate&pageno=-1");
    return LanguageKeysModel.fromJson(response);
  }

  @override
  Future<CheckNewLanguageKeysModel> isDownloadLanguage(
      String languageId, String languageSyncDate) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}common/IsDownloadLanguage?languageid=$languageId&syncdate=$languageSyncDate");
    return CheckNewLanguageKeysModel.fromJson(response);
  }
}
