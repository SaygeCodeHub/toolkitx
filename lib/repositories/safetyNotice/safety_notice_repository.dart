import '../../data/safetyNotice/fetch_safety_notices_model.dart';

abstract class SafetyNoticeRepository {
  Future<FetchSafetyNoticesModel> fetchSafetyNotices(
      int pageNo, String userId, String hashCode, String filter);
}
