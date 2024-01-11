import '../../data/models/leavesAndHolidays/apply_for_leave_model.dart';
import '../../data/models/leavesAndHolidays/fetch_get_time_sheet_model.dart';
import '../../data/models/leavesAndHolidays/fetch_leaves_and_holidays_master_model.dart';
import '../../data/models/leavesAndHolidays/fetch_leaves_details_model.dart';
import '../../data/models/leavesAndHolidays/fetch_leaves_summary_model.dart';

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

class GetTimeSheetSaving extends LeavesAndHolidaysStates {}

class GetTimeSheetSaved extends LeavesAndHolidaysStates {
  final FetchTimeSheetModel fetchTimeSheetModel;

  GetTimeSheetSaved({required this.fetchTimeSheetModel});
}

class GetTimeSheetNotSaved extends LeavesAndHolidaysStates {
  final String errorMessage;
  GetTimeSheetNotSaved({required this.errorMessage});
}

class SelectTimeSheetChecklistMultiAnswerSaved extends LeavesAndHolidaysStates {
  final bool isChecked;

  SelectTimeSheetChecklistMultiAnswerSaved({required this.isChecked});
}
