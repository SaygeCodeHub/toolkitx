import 'package:toolkit/data/safetyNotice/add_safety_notice_model.dart';
import 'package:toolkit/data/safetyNotice/cancel_safety_notice_model.dart';
import 'package:toolkit/data/safetyNotice/close_safety_notice_model.dart';
import 'package:toolkit/data/safetyNotice/fetch_safety_notice_details_model.dart';
import 'package:toolkit/data/safetyNotice/fetch_safety_notice_history_model.dart';
import 'package:toolkit/data/safetyNotice/hold_safety_notice_model.dart';
import 'package:toolkit/data/safetyNotice/issue_safety_notice_model.dart';
import 'package:toolkit/data/safetyNotice/reissue_safety_notice_model.dart';
import 'package:toolkit/data/safetyNotice/save_safety_notice_files_model.dart';
import 'package:toolkit/data/safetyNotice/update_safety_notice_model.dart';

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

  @override
  Future<AddSafetyNoticeModel> addSafetyNotices(Map addSafetyNoticeMap) async {
    final response = await DioClient()
        .post("${ApiConstants.baseUrl}notice/Save", addSafetyNoticeMap);
    return AddSafetyNoticeModel.fromJson(response);
  }

  @override
  Future<SaveSafetyNoticeFilesModel> saveSafetyNoticesFiles(
      Map saveSafetyNoticeFilesMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}notice/savefiles", saveSafetyNoticeFilesMap);
    return SaveSafetyNoticeFilesModel.fromJson(response);
  }

  @override
  Future<FetchSafetyNoticeDetailsModel> fetchSafetyNoticeDetails(
      String safetyNoticeId, String userId, String hashCode) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}notice/GetNotice?noticeid=$safetyNoticeId&userid=$userId&hashcode=$hashCode");
    return FetchSafetyNoticeDetailsModel.fromJson(response);
  }

  @override
  Future<UpdatingSafetyNoticeModel> updateSafetyNotices(
      Map updateSafetyNoticeMap) async {
    final response = await DioClient()
        .post("${ApiConstants.baseUrl}notice/Update", updateSafetyNoticeMap);
    return UpdatingSafetyNoticeModel.fromJson(response);
  }

  @override
  Future<IssueSafetyNoticeModel> issueSafetyNotices(
      Map issueSafetyNoticeMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}notice/IssueNotice", issueSafetyNoticeMap);
    return IssueSafetyNoticeModel.fromJson(response);
  }

  @override
  Future<HoldSafetyNoticeModel> holdSafetyNotices(
      Map holdSafetyNoticeMap) async {
    final response = await DioClient()
        .post("${ApiConstants.baseUrl}notice/HoldNotice", holdSafetyNoticeMap);
    return HoldSafetyNoticeModel.fromJson(response);
  }

  @override
  Future<CancelSafetyNoticeModel> cancelSafetyNotices(
      Map cancelSafetyNoticeMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}notice/CancelNotice", cancelSafetyNoticeMap);
    return CancelSafetyNoticeModel.fromJson(response);
  }

  @override
  Future<CloseSafetyNoticeModel> closeSafetyNotice(
      Map closeSafetyNoticeMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}notice/CloseNotice", closeSafetyNoticeMap);
    return CloseSafetyNoticeModel.fromJson(response);
  }

  @override
  Future<FetchHistorySafetyNoticeModel> fetchSafetyNoticeHistoryList(
      int pageNo, String userId, String hashCode, String filter) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}notice/GetHistory?pageno=$pageNo&userid=$userId&hashcode=$hashCode&filter=$filter");
    return FetchHistorySafetyNoticeModel.fromJson(response);
  }

  @override
  Future<ReIssueSafetyNoticeModel> reIssueSafetyNotice(
      Map reIssueSafetyNoticeMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}notice/ReIssueNotice", reIssueSafetyNoticeMap);
    return ReIssueSafetyNoticeModel.fromJson(response);
  }

  @override
  Future<void> saveReadReceipt(Map saveReadReceiptMap) async {
    final response = await DioClient()
        .post("${ApiConstants.baseUrl}notice/ReadReceipt", saveReadReceiptMap);
    return response;
  }
}
