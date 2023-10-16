import '../../data/safetyNotice/add_safety_notice_model.dart';
import '../../data/safetyNotice/fetch_safety_notice_details_model.dart';
import '../../data/safetyNotice/fetch_safety_notices_model.dart';
import '../../data/safetyNotice/hold_safety_notice_model.dart';
import '../../data/safetyNotice/issue_safety_notice_model.dart';
import '../../data/safetyNotice/save_safety_notice_files_model.dart';
import '../../data/safetyNotice/update_safety_notice_model.dart';

abstract class SafetyNoticeRepository {
  Future<FetchSafetyNoticesModel> fetchSafetyNotices(
      int pageNo, String userId, String hashCode, String filter);

  Future<AddSafetyNoticeModel> addSafetyNotices(Map addSafetyNoticeMap);

  Future<SaveSafetyNoticeFilesModel> saveSafetyNoticesFiles(
      Map saveSafetyNoticeFilesMap);

  Future<UpdatingSafetyNoticeModel> updateSafetyNotices(
      Map updateSafetyNoticeMap);

  Future<IssueSafetyNoticeModel> issueSafetyNotices(Map issueSafetyNoticeMap);

  Future<HoldSafetyNoticeModel> holdSafetyNotices(Map holdSafetyNoticeMap);

  Future<FetchSafetyNoticeDetailsModel> fetchSafetyNoticeDetails(
      String safetyNoticeId, String userId, String hashCode);
}
