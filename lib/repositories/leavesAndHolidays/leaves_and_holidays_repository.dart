import '../../data/models/leavesAndHolidays/fetch_leaves_details_model.dart';
import '../../data/models/leavesAndHolidays/fetch_leaves_summary_model.dart';

abstract class LeavesAndHolidaysRepository {
  Future<FetchLeavesSummaryModel> fetchLeavesSummary(
      String userId, String hashCode);

  Future<FetchLeavesDetailsModel> fetchLeavesDetails(
      String userId, String hashCode, int page);
}
