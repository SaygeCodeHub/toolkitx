import 'package:toolkit/data/models/leavesAndHolidays/apply_for_leave_model.dart';
import 'package:toolkit/data/models/leavesAndHolidays/fetch_get_checkin_time_sheet_model.dart';
import 'package:toolkit/data/models/leavesAndHolidays/fetch_get_time_sheet_model.dart';
import 'package:toolkit/data/models/leavesAndHolidays/fetch_leaves_and_holidays_master_model.dart';
import 'package:toolkit/data/models/leavesAndHolidays/fetch_leaves_details_model.dart';
import 'package:toolkit/data/models/leavesAndHolidays/fetch_leaves_summary_model.dart';

import '../../data/models/leavesAndHolidays/delete_timesheet_model.dart';
import '../../data/models/leavesAndHolidays/submit_time_sheet_model.dart';
import '../../utils/constants/api_constants.dart';
import '../../utils/dio_client.dart';
import 'leaves_and_holidays_repository.dart';

class LeavesAndHolidaysRepositoryImpl extends LeavesAndHolidaysRepository {
  @override
  Future<FetchLeavesSummaryModel> fetchLeavesSummary(
      String userId, String hashCode) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}timesheet/GetWorkforceLeaveDetails?userid=$userId&hashcode=$hashCode");
    return FetchLeavesSummaryModel.fromJson(response);
  }

  @override
  Future<FetchLeavesDetailsModel> fetchLeavesDetails(
      String userId, String hashCode, int page) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}timesheet/getemployeeleaves?userid=$userId&hashcode=$hashCode&pageno=$page");
    return FetchLeavesDetailsModel.fromJson(response);
  }

  @override
  Future<FetchLeavesAndHolidaysMasterModel> fetchLeavesMaster(
      String hashCode) async {
    final response = await DioClient()
        .get("${ApiConstants.baseUrl}timesheet/getmaster?hashcode=$hashCode");
    return FetchLeavesAndHolidaysMasterModel.fromJson(response);
  }

  @override
  Future<ApplyForLeaveModel> applyForLeave(Map applyForLeaveMap) async {
    final response = await DioClient()
        .post("${ApiConstants.baseUrl}timesheet/applyleave", applyForLeaveMap);
    return ApplyForLeaveModel.fromJson(response);
  }

  @override
  Future<FetchTimeSheetModel> fetchTimeSheet(
      String year, String month, String userId, String hashCode) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}timesheet/get?year=$year&month=$month&userid=$userId&hashcode=$hashCode");
    return FetchTimeSheetModel.fromJson(response);
  }

  @override
  Future<FetchCheckInTimeSheetModel> fetchCheckInTimeSheet(
      String date, String userId, String hashCode) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}timesheet/getcheckIns?date=$date&userid=$userId&hashcode=$hashCode");
    return FetchCheckInTimeSheetModel.fromJson(response);
  }

  @override
  Future<DeleteTimeSheetModel> deleteTimeSheetRepo(
      Map deleteTimeSheetMap) async {
    final response = await DioClient()
        .post("${ApiConstants.baseUrl}timesheet/delete", deleteTimeSheetMap);
    return DeleteTimeSheetModel.fromJson(response);
  }

  @override
  Future<SubmitTimeSheetModel> submitTimeSheetRepo(
      Map submitTimeSheetMap) async {
    final response = await DioClient()
        .post("${ApiConstants.baseUrl}timesheet/submittimesheet", submitTimeSheetMap);
    return SubmitTimeSheetModel.fromJson(response);
  }
}
