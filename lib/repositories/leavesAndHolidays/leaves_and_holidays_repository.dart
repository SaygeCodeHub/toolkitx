import 'package:toolkit/data/models/leavesAndHolidays/fetch_get_checkin_time_sheet_model.dart';

import '../../data/models/leavesAndHolidays/apply_for_leave_model.dart';
import '../../data/models/leavesAndHolidays/fetch_get_time_sheet_model.dart';
import '../../data/models/leavesAndHolidays/fetch_leaves_and_holidays_master_model.dart';
import '../../data/models/leavesAndHolidays/fetch_leaves_details_model.dart';
import '../../data/models/leavesAndHolidays/fetch_leaves_summary_model.dart';

abstract class LeavesAndHolidaysRepository {
  Future<FetchLeavesSummaryModel> fetchLeavesSummary(
      String userId, String hashCode);

  Future<FetchLeavesDetailsModel> fetchLeavesDetails(
      String userId, String hashCode, int page);

  Future<FetchLeavesAndHolidaysMasterModel> fetchLeavesMaster(String hashCode);

  Future<ApplyForLeaveModel> applyForLeave(Map applyForLeaveMap);

  Future<FetchTimeSheetModel> fetchTimeSheet(
      String year, String month, String userId, String hashCode);

  Future<FetchCheckInTimeSheetModel> fetchCheckInTimeSheet(
      String date, String userId, String hashCode);
}
