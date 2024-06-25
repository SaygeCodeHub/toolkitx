import 'package:toolkit/data/models/timeZones/time_zone_model.dart';
import 'package:toolkit/repositories/timeZone/time_zone_repository.dart';

import '../../utils/constants/api_constants.dart';
import '../../utils/dio_client.dart';

class TimeZoneRepositoryImpl extends TimeZoneRepository {
  @override
  Future<TimeZoneModel> fetchTimeZone() async {
    final response = await DioClient()
        .get("${ApiConstants.baseUrl}common/GetSystemTimeZones");
    return TimeZoneModel.fromJson(response);
  }
}
