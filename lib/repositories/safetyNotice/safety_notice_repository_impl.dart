import '../../data/safetyNotice/fetch_safety_notices_model.dart';
import '../../utils/constants/api_constants.dart';
import '../../utils/dio_client.dart';
import 'safety_notice_repository.dart';

class SafetyNoticeRepositoryImpl extends SafetyNoticeRepository {
  @override
  Future<FetchSafetyNoticesModel> fetchSafetyNotices(
      int pageNo, String userId, String hashCode, String filter) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}notice/get?pageno=$pageNo&userid=$userId&hashcode=$hashCode&filter=$filter");
    return FetchSafetyNoticesModel.fromJson(response);
  }
}
