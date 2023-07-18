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
