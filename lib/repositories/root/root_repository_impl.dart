import 'package:toolkit/data/models/currentLocation/current_location.dart';

import '../../data/cache/cache_keys.dart';
import '../../data/cache/customer_cache.dart';
import '../../di/app_module.dart';
import '../../utils/constants/api_constants.dart';
import '../../utils/dio_client.dart';
import 'root_repository.dart';

class RootRepositoryImpl extends RootRepository {
  @override
  Future<CurrentLocationUpdateModel> updateCurrentLocation(
      double latitude, double longitude) async {
    final CustomerCache customerCache = getIt<CustomerCache>();
    String? userId = await customerCache.getUserId(CacheKeys.userId);
    String? hashCode = await customerCache.getHashCode(CacheKeys.hashcode);
    Map requestBody = {
      "id": userId,
      "hashcode": hashCode,
      'latitude': latitude,
      'longitude': longitude
    };
    final response = await DioClient()
        .post("${ApiConstants.baseUrl}common/savelocation", requestBody);
    return CurrentLocationUpdateModel.fromJson(response);
  }
}
