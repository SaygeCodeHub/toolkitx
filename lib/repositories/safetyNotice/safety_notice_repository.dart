import '../../data/safetyNotice/add_safety_notice_model.dart';
import '../../data/safetyNotice/cancel_safety_notice_model.dart';
import '../../data/safetyNotice/close_safety_notice_model.dart';
import '../../data/safetyNotice/fetch_safety_notice_details_model.dart';
import '../../data/safetyNotice/fetch_safety_notice_history_model.dart';
import '../../data/safetyNotice/fetch_safety_notices_model.dart';
import '../../data/safetyNotice/hold_safety_notice_model.dart';
import '../../data/safetyNotice/issue_safety_notice_model.dart';
import '../../data/safetyNotice/reissue_safety_notice_model.dart';
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

  Future<FetchHistorySafetyNoticeModel> fetchSafetyNoticeHistoryList(
      int pageNo, String userId, String hashCode, String filter);

  Future<CancelSafetyNoticeModel> cancelSafetyNotices(
      Map cancelSafetyNoticeMap);

  Future<CloseSafetyNoticeModel> closeSafetyNotice(Map closeSafetyNoticeMap);

  Future<ReIssueSafetyNoticeModel> reIssueSafetyNotice(
      Map reIssueSafetyNoticeMap);

  Future<FetchSafetyNoticeDetailsModel> fetchSafetyNoticeDetails(
      String safetyNoticeId, String userId, String hashCode);
}
