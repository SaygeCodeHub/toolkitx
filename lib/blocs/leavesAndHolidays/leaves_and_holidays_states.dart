import 'package:toolkit/data/models/leavesAndHolidays/fetch_get_checkin_time_sheet_model.dart';
import 'package:toolkit/data/models/leavesAndHolidays/save_timesheet_model.dart';

import '../../data/models/expense/expense_working_at_number_model.dart';
import '../../data/models/leavesAndHolidays/apply_for_leave_model.dart';
import '../../data/models/leavesAndHolidays/fetch_get_time_sheet_model.dart';
import '../../data/models/leavesAndHolidays/fetch_leaves_and_holidays_master_model.dart';
import '../../data/models/leavesAndHolidays/fetch_leaves_details_model.dart';
import '../../data/models/leavesAndHolidays/fetch_leaves_summary_model.dart';
import '../../data/models/leavesAndHolidays/fetch_time_sheet_details_model.dart';

abstract class LeavesAndHolidaysStates {}

class LeavesAndSummaryInitial extends LeavesAndHolidaysStates {}

class FetchingLeavesSummary extends LeavesAndHolidaysStates {}

class LeavesSummaryFetched extends LeavesAndHolidaysStates {
  final FetchLeavesSummaryModel fetchLeavesSummaryModel;

  LeavesSummaryFetched({required this.fetchLeavesSummaryModel});
}

class LeavesSummaryNotFetched extends LeavesAndHolidaysStates {
  final String summaryNotFetched;

  LeavesSummaryNotFetched({required this.summaryNotFetched});
}

class FetchingLeavesDetails extends LeavesAndHolidaysStates {}

class LeavesDetailsFetched extends LeavesAndHolidaysStates {
  final FetchLeavesDetailsModel fetchLeavesDetailsModel;

  LeavesDetailsFetched({required this.fetchLeavesDetailsModel});
}

class LeavesDetailsNotFetched extends LeavesAndHolidaysStates {
  final String detailsNotFetched;

  LeavesDetailsNotFetched({required this.detailsNotFetched});
}

class FetchingLeavesAndHolidaysMaster extends LeavesAndHolidaysStates {}

class LeavesAndHolidaysMasterFetched extends LeavesAndHolidaysStates {
  final FetchLeavesAndHolidaysMasterModel fetchLeavesAndHolidaysMasterModel;

  LeavesAndHolidaysMasterFetched(
      {required this.fetchLeavesAndHolidaysMasterModel});
}

class LeavesAndHolidaysMasterNotFetched extends LeavesAndHolidaysStates {
  final String masterNotFetched;

  LeavesAndHolidaysMasterNotFetched({required this.masterNotFetched});
}

class LeaveTypeSelected extends LeavesAndHolidaysStates {
  final String leaveTypeId;

  LeaveTypeSelected({required this.leaveTypeId});
}

class ApplyingForLeave extends LeavesAndHolidaysStates {}

class AppliedForLeave extends LeavesAndHolidaysStates {
  final ApplyForLeaveModel applyForLeaveModel;

  AppliedForLeave({required this.applyForLeaveModel});
}

class CouldNotApplyForLeave extends LeavesAndHolidaysStates {
  final String couldNotApplyForLeave;

  CouldNotApplyForLeave({required this.couldNotApplyForLeave});
}

class ApplyForLeaveManagerConfirmationNeeded extends LeavesAndHolidaysStates {
  final String confirmationMessage;

  ApplyForLeaveManagerConfirmationNeeded({required this.confirmationMessage});
}

class GetTimeSheetFetching extends LeavesAndHolidaysStates {}

class GetTimeSheetFetched extends LeavesAndHolidaysStates {
  final FetchTimeSheetModel fetchTimeSheetModel;

  GetTimeSheetFetched({required this.fetchTimeSheetModel});
}

class GetTimeSheetNotFetched extends LeavesAndHolidaysStates {
  final String errorMessage;
  GetTimeSheetNotFetched({required this.errorMessage});
}

class CheckInTimeSheetFetching extends LeavesAndHolidaysStates {}

class CheckInTimeSheetFetched extends LeavesAndHolidaysStates {
  final FetchCheckInTimeSheetModel fetchCheckInTimeSheetModel;

  CheckInTimeSheetFetched({required this.fetchCheckInTimeSheetModel});
}

class CheckInTimeSheetNotFetched extends LeavesAndHolidaysStates {
  final String errorMessage;
  CheckInTimeSheetNotFetched({required this.errorMessage});
}

class TimeSheetDeleting extends LeavesAndHolidaysStates {}

class TimeSheetDeleted extends LeavesAndHolidaysStates {}

class TimeSheetNotDeleted extends LeavesAndHolidaysStates {
  final String errorMessage;

  TimeSheetNotDeleted({required this.errorMessage});
}

class TimeSheetWorkingAtOptionSelected extends LeavesAndHolidaysStates {
  final String workingAt;
  final String workingAtValue;

  TimeSheetWorkingAtOptionSelected(
      {required this.workingAtValue, required this.workingAt});
}

class TimeSheetWorkingAtNumberSelected extends LeavesAndHolidaysStates {
  final Map timeSheetWorkingAtNumberMap;

  TimeSheetWorkingAtNumberSelected({required this.timeSheetWorkingAtNumberMap});
}

class FetchingTimeSheetWorkingAtNumberData extends LeavesAndHolidaysStates {}

class TimeSheetWorkingAtNumberDataFetched extends LeavesAndHolidaysStates {
  final ExpenseWorkingAtNumberDataModel expenseWorkingAtNumberDataModel;

  TimeSheetWorkingAtNumberDataFetched(
      {required this.expenseWorkingAtNumberDataModel});
}

class TimeSheetWorkingAtNumberDataNotFetched extends LeavesAndHolidaysStates {
  final String dataNotFetched;

  TimeSheetWorkingAtNumberDataNotFetched({required this.dataNotFetched});
}

class TimeSheetSaving extends LeavesAndHolidaysStates {}

class TimeSheetSaved extends LeavesAndHolidaysStates {
  final SaveTimeSheetModel saveTimeSheetModel;

  TimeSheetSaved({required this.saveTimeSheetModel});
}

class TimeSheetNotSaved extends LeavesAndHolidaysStates {
  final String errorMessage;

  TimeSheetNotSaved({required this.errorMessage});
}

class TimeSheetSubmitting extends LeavesAndHolidaysStates {}

class TimeSheetSubmitted extends LeavesAndHolidaysStates {}

class TimeSheetNotSubmitted extends LeavesAndHolidaysStates {
  final String errorMessage;

  TimeSheetNotSubmitted({required this.errorMessage});
}

class FetchingTimeSheetDetails extends LeavesAndHolidaysStates {}

class TimeSheetDetailsFetched extends LeavesAndHolidaysStates {
  final FetchTimeSheetDetailsModel fetchTimeSheetDetailsModel;

  TimeSheetDetailsFetched({required this.fetchTimeSheetDetailsModel});
}

class TimeSheetDetailsNotFetched extends LeavesAndHolidaysStates {
  final String errorMessage;

  TimeSheetDetailsNotFetched({required this.errorMessage});
}

class CheckBoxSelected extends LeavesAndHolidaysStates {
  final bool isChecked;

  CheckBoxSelected({required this.isChecked});
}
