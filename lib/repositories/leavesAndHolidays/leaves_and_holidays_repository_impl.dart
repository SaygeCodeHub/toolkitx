import 'package:toolkit/data/models/leavesAndHolidays/fetch_leaves_details_model.dart';
import 'package:toolkit/data/models/leavesAndHolidays/fetch_leaves_summary_model.dart';

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
}
