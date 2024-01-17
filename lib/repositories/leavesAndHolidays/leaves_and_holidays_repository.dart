import 'package:toolkit/data/models/leavesAndHolidays/delete_timesheet_model.dart';
import 'package:toolkit/data/models/leavesAndHolidays/fetch_get_checkin_time_sheet_model.dart';

import '../../data/models/leavesAndHolidays/apply_for_leave_model.dart';
import '../../data/models/leavesAndHolidays/fetch_employee_working_at_model.dart';
import '../../data/models/leavesAndHolidays/fetch_get_time_sheet_model.dart';
import '../../data/models/leavesAndHolidays/fetch_leaves_and_holidays_master_model.dart';
import '../../data/models/leavesAndHolidays/fetch_leaves_details_model.dart';
import '../../data/models/leavesAndHolidays/fetch_leaves_summary_model.dart';
import '../../data/models/leavesAndHolidays/fetch_time_sheet_details_model.dart';
import '../../data/models/leavesAndHolidays/save_timesheet_model.dart';

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

  Future<DeleteTimeSheetModel> deleteTimeSheetRepo(Map deleteTimeSheetMap);

  Future<FetchWorkingAtTimeSheetModel> fetchWorkingAtTimeSheet(
      String groupby, String userId, String hashCode);

  Future<SaveTimeSheetModel> saveTimeSheet(Map saveTimeSheetMap);

  Future<FetchTimeSheetDetailsModel> fetchTimeSheetDetails(
      String hashCode, String timeSheetDetailsId);
}
